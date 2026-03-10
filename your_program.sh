#!/bin/sh
#
# Use this script to run your program LOCALLY.
#
# Note: Changing this script WILL NOT affect how CodeCrafters runs your program.
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit early if any commands fail

# support command-line options
#  -b  build only
#  -r  run only
build_flag=0
run_flag=0

while getopts "br" opt; do
  case "$opt" in
    b)
      build_flag=1;;
    r)
      run_flag=1;;
    *)
      echo "Usage: $0 [-b] [-r] [program args]" >&2
      exit 1;;
  esac
done
shift $((OPTIND - 1))

# Copied from .codecrafters/compile.sh
#
# - Edit this to change how your program compiles locally
# - Edit .codecrafters/compile.sh to change how your program compiles remotely
build() {
  (
    cd "$(dirname "$0")" # Ensure compile steps are run within the repository directory
    cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
    cmake --build ./build
  )
}

# Copied from .codecrafters/run.sh
#
# - Edit this to change how your program runs locally
# - Edit .codecrafters/run.sh to change how your program runs remotely
run() {
  exec $(dirname "$0")/build/shell "$@"
}

# default behaviour: build then run
if [ "$build_flag" -eq 0 ] && [ "$run_flag" -eq 0 ]; then
  build
  run "$@"
  # run exits the script
fi

if [ "$build_flag" -eq 1 ]; then
  build
  [ "$run_flag" -eq 0 ] && exit 0
fi

if [ "$run_flag" -eq 1 ]; then
  run "$@"
fi
