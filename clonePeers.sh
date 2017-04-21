#!/usr/bin/env bash

##############################################################################
##
##  Wrapper sript to pull all peer git repositories
##
##############################################################################

if [ -z "$1" ]; then
    MYBRANCH=`git rev-parse --abbrev-ref HEAD`
else
    MYBRANCH=$1
fi

BASEREPO="https://github.com/jbcodeforce/refarch-cognitive"
REPO_WCS="https://github.com/jbcodeforce/refarch-cognitive-conversation-broker"
REPO_WDS="https://github.com/jbcodeforce/refarch-cognitive-discovery-broker"

echo 'Cloning peer projects...'

GIT_AVAIL=$(which git)
if [ ${?} -ne 0 ]; then
  echo "git is not available on your local system.  Please install git for your operating system and try again."
  exit 1
fi

DEFAULT_BRANCH=${MYBRANCH:-master}

echo -e '\nClone Cognitive Compute Conversation Broker project'
REPO=${REPO_WCS}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Cognitive Compute Discovery Broker project'
REPO=${REPO_WDS}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nCloned all peer projects successfully!\n'
ls ../ | grep refarch-cognitive
