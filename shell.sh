#!/bin/bash

################################################################################
# R-dyntrace only works if the R JIT is disabled. This is done by setting
# environment variables.
#
# This script starts a local shell with the proper environment variables
# defined; the variables will be unset when the shell exits.
#
# WARNING: This script will not work if it is symlinked; DIR will contain the
# symlink's directory and not the original script's directory.
################################################################################

# Don't start a vtrace-shell inside a vtrace-shell
if [ -n "$VTRACE_SHELL" ]; then
    echo "Already in vtrace-shell!"
    exit 255
fi

# Get the script's directory and set $R and the PATH
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export R=$DIR/../R-dyntrace/bin/R
export PATH=$DIR/../R-dyntrace/bin:$PATH

# Set custom environment variables
export VTRACE_SHELL=1
export R_ENABLE_JIT=0
export R_DISABLE_BYTECODE=1

# Replace the current shell script process with bash, inheriting all
# environment variables, sourcing .bashrc to retain aliases, and then setting a
# custom prompt so we know we're in vtrace-shell.
#
# If we set the prompt before calling bash, then it will be overwritten by
# sourcing ~/.bashrc. If we call bash with --norc --noprofile then we don't get
# any aliases or functions defined in ~/.bashrc.
exec bash --rcfile <(echo '. ~/.bashrc; PS1="\[\033[01;35m\](vtrace-shell)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]> "')
