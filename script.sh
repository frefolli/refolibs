#!/bin/bash

REPOS="libclipp  libgc  libhyper  liblexer  libparser  libutils liblogger libajax"
THIS_PATH=$(dirname "$0")

function clone_repo() {
    REPO="$1"
    echo -e "Scripts::Clone($REPO)"
    git clone git@github.com:frefolli/$REPO
}

function pull_repo() {
    REPO="$1"
    BACK=$(pwd)
    cd $REPO
    echo -e "Scripts::Pull($REPO)"
    git pull
    cd $BACK
}

function push_repo() {
    REPO="$1"
    BACK=$(pwd)
    cd $REPO
    echo -e "Scripts::Push($REPO)"
    git push
    cd $BACK
}

function status_repo() {
    REPO="$1"
    BACK=$(pwd)
    cd $REPO
    echo -e "Scripts::Status($REPO)"
    git status
    cd $BACK
}

function do_clone() {
    if [[ "$THIS_PATH" == '.' ]]; then
        echo -e "cannot execute $0 from it's own directory"
    else
        for repo in $REPOS; do
            clone_repo $repo
        done
    fi
}

function do_pull() {
    if [[ "$THIS_PATH" == '.' ]]; then
        echo -e "cannot execute $0 from it's own directory"
    else
        for repo in $REPOS; do
            pull_repo $repo
        done
    fi
}

function do_push() {
    if [[ "$THIS_PATH" == '.' ]]; then
        echo -e "cannot execute $0 from it's own directory"
    else
        for repo in $REPOS; do
            push_repo $repo
        done
    fi
}

function do_status() {
    if [[ "$THIS_PATH" == '.' ]]; then
        echo -e "cannot execute $0 from it's own directory"
    else
        for repo in $REPOS; do
            status_repo $repo
        done
    fi
}

function do_assert() {
    if [[ "$THIS_PATH" == '.' ]]; then
        echo -e "cannot execute $0 from it's own directory"
    else
        for repo in $REPOS; do
            if [ -d $repo ]; then
                pull_repo $repo
            else
                clone_repo $repo
            fi
        done
    fi
}

if [ ! -z "$1" ]; then
    if [[ "$1" == 'clone' ]]; then
        do_clone
    elif [[ "$1" == 'pull' ]]; then
        do_pull
    elif [[ "$1" == 'push' ]]; then
        do_push
    elif [[ "$1" == 'status' ]]; then
        do_status
    elif [[ "$1" == 'assert' ]]; then
        do_assert
    fi
else
    echo -e "choose an action [clone | pull | push | status | assert ...]"
fi
