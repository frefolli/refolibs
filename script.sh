#!/bin/bash

REPOS="libclipp  libgc  libhyper  liblexer  libparser  libutils liblogger libajax libligma"
THIS_PATH=$(dirname "$0")

function not_in_this_folder() {
    if [[ "$THIS_PATH" == '.' ]]; then
        echo -e "cannot execute this action of $0 from it's own directory"
        exit 1
    fi
}

function in_this_folder() {
    if [[ "$THIS_PATH" != '.' ]]; then
        echo -e "must execute this action of $0 from it's own directory"
        exit 1
    fi
}

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
    not_in_this_folder
    for repo in $REPOS; do
        clone_repo $repo
    done
}

function do_pull() {
    not_in_this_folder
    for repo in $REPOS; do
        pull_repo $repo
    done
}

function do_push() {
    not_in_this_folder
    for repo in $REPOS; do
        push_repo $repo
    done
}

function do_status() {
    not_in_this_folder
    for repo in $REPOS; do
        status_repo $repo
    done
}

function do_assert() {
    not_in_this_folder
    for repo in $REPOS; do
        if [ -d $repo ]; then
            pull_repo $repo
        else
            clone_repo $repo
        fi
    done
}

function do_update() {
    in_this_folder
    git submodule update --remote
}

function do_init() {
    in_this_folder
    git submodule init
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
    elif [[ "$1" == 'update' ]]; then
        do_update
    elif [[ "$1" == 'init' ]]; then
        do_init
    fi
else
    echo -e "choose an action [clone | pull | push | status | assert | update ...]"
fi
