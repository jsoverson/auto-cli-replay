#!/bin/bash

set -e

usage() { echo "Usage: $0 [-d] -f <script>" 1>&2; exit 1; }

while getopts ":df:" opt; do
  case $opt in
    f)
      FILE="$OPTARG"
      ;;
    d)
      DEBUG=true
      ;;
  esac
done
shift $((OPTIND-1))

if [ -z "${FILE}" ]; then
    usage
fi

SELF=$(dirname -- "$0");

function resize() {
  local width=$1;
  local height=$2;
  printf "\\e[8;$2;$1t"
}

. $SELF/../demo-magic/demo-magic.sh

. $SELF/SCRIPT_SETUP.sh

# Have to duplicate the handling of this option after we've run SETUP
if [ $DEBUG ]; then
  unset TYPE_SPEED
fi

. $SELF/../$FILE

. $SELF/SCRIPT_TEARDOWN.sh

