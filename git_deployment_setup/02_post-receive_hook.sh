#!/bin/bash
#
# This hook script is triggered on the server after a push.
# It checks out the code, builds the Hugo site, and deploys it.
#

# --- Configuration (ADJUST THESE IF YOUR PATHS ARE DIFFERENT) ---
GIT_REPO_PATH="${HOME}/my-website.git"    # Path to this bare Git repository
GIT_WORK_TREE="/var/www/my-hugo-source"   # Where to checkout the source code for building
PUBLIC_WWW="/var/www/html/my-blog" # Where Nginx serves the built static files from
HUGO_EXECUTABLE="$(which hugo)"       # Full path to hugo if not in standard PATH
TARGET_BRANCH=$(cd ${GIT_REPO_PATH} && git symbolic-ref --short HEAD) #get the branch name, cd to it, safer for git to understand the context
# --- End Configuration ---

# Function for logging with timestamp
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] - $1"
}

log "-----> Git post-receive hook triggered."

# Check if HUGO_EXECUTABLE was found by 'which' right away
if [ -z "${HUGO_EXECUTABLE}" ]; then
    log "!!!!!! ERROR: Hugo executable not found using 'which hugo'. Check PATH or set HUGO_EXECUTABLE manually."
    exit 1
fi

# Read the pushed branch details (comes from stdin)
while read oldrev newrev refname
do
    # Extract the short branch name from the refname
    branch=$(git rev-parse --symbolic --abbrev-ref $refname)
    log "-----> Received push to ref: $refname (Branch: $branch)"

    # Check if the pushed branch is the desired target branch
    if [ "$branch" == "$TARGET_BRANCH" ]; then
        log "-----> Push to target branch '$TARGET_BRANCH' detected. Starting deployment..."

        # Create work tree directory if it doesn't exist
        mkdir -p ${GIT_WORK_TREE}
        mkdir -p ${PUBLIC_WWW}

        # Force checkout of the latest code from the target branch into the work tree
        log "-----> Checking out branch '$TARGET_BRANCH' to ${GIT_WORK_TREE}..."
        if ! GIT_DIR=${GIT_REPO_PATH} git --work-tree=${GIT_WORK_TREE} checkout -f ${TARGET_BRANCH}; then
            log "!!!!!! ERROR: Git checkout failed."
            exit 1
        fi
        log "-----> Checkout successful." # Moved success log here

        # Navigate to the source directory and build with Hugo
        log "-----> Building Hugo site from ${GIT_WORK_TREE} using '${HUGO_EXECUTABLE}'..."
        # Change to the working tree directory before building
        cd ${GIT_WORK_TREE}
        if ! ${HUGO_EXECUTABLE}; then
            log "!!!!!! ERROR: Hugo build failed."
            exit 1
        fi
        log "-----> Hugo build successful. Output in ${GIT_WORK_TREE}/public/"

        # Deploy: Remove old site files and copy new ones
        log "-----> Deploying built site from ${GIT_WORK_TREE}/public/ to ${PUBLIC_WWW}..."
        if [ -d "${PUBLIC_WWW}" ] && [ ! -z "${PUBLIC_WWW}" ]; then # Safety check
            rm -rf ${PUBLIC_WWW}/*
        else
            log "!!!!!! ERROR: PUBLIC_WWW variable is empty or directory does not exist. Aborting deployment."
            exit 1
        fi

        # Copy new content
        cp -R ${GIT_WORK_TREE}/public/* ${PUBLIC_WWW}/
        if [ $? -ne 0 ]; then
            log "!!!!!! ERROR: Copying files to ${PUBLIC_WWW} failed."
            exit 1
        fi
        log "-----> Hugo site deployed successfully to ${PUBLIC_WWW}"
        log "-----> Content should now be live."

    else
        log "-----> Push was not to target branch '$TARGET_BRANCH' (it was to '$branch'). Ignoring."
        # This path implies the hook script itself ran correctly, it just didn't deploy.
        # The overall script will still exit 0 as intended.
    fi
done
exit 0                                                                                                      
