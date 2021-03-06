#!/bin/sh
#
# SCRIPT: upcase.sh
# AUTHOR: Janos Gyerik <info@janosgyerik.com>
# DATE:   2004-12-23
# REV:    1.0.T (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PLATFORM: Not platform dependent
#
# PURPOSE: Rename specified files to all uppercase letters.
#
# set -n   # Uncomment to check your syntax, without execution.
#          # NOTE: Do not forget to put the comment back in or
#          #       the shell script will not execute!
# set -x   # Uncomment to debug this shell script (Korn shell only)
#          
#

usage() {
    test $# = 0 || echo $@
    echo "Usage: $0 [OPTION]... FILE..."
    echo
    echo "Rename files to all uppercase letters."
    echo
    echo "  -h, --help            Print this help"
    echo
    exit 1
}

args=
#arg=
#flag=off
#param=
while [ $# != 0 ]; do
    case $1 in
    -h|--help) usage ;;
#    -f|--flag) flag=on ;;
#    -p|--param) shift; param=$1 ;;
    --) shift; while [ $# != 0 ]; do args="$args \"$1\""; shift; done; break ;;
    -?*) usage "Unknown option: $1" ;;
    *) args="$args \"$1\"" ;;  # script that takes multiple arguments
#    *) test "$arg" && usage || arg=$1 ;;  # strict with excess arguments
#    *) arg=$1 ;;  # forgiving with excess arguments
    esac
    shift
done

eval "set -- $args"

test $# -gt 0 || usage

for i in "$@"; do
    file=`basename "$i"`
    dir=`dirname "$i"`
    upcased=`echo "$file" | tr a-z A-Z`
    old="$dir/$file"
    new="$dir/$upcased"
    test "$new" != "$old" && echo "\`$i' -> \`$new'" && mv -i -- "$i" "$new"
done

# eof
