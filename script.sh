#!/bin/bash

REPOS="libclipp  libgc  libhyper  liblexer  libparser  libutils liblogger"
THIS_PATH=$(dirname "$0")

function download() {
    if [[ "$THIS_PATH" == '.' ]]; then
        echo -e "cannot execute $0 from it's own directory"
    else
        for repo in $REPOS; do
            git clone git@github.com:frefolli/$repo
        done
    fi
}

if [ ! -z "$1" ]; then
    if [[ "$1" == 'download' ]]; then
        download
    fi
else
    echo -e "choose an action [download | ...]"
fi
