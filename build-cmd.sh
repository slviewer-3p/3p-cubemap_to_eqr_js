#!/usr/bin/env bash

cd "$(dirname "$0")"

# turn on verbose debugging output for parabuild logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x

# make errors fatal
set -e
# bleat on references to undefined shell variables
set -u

if [ -z "$AUTOBUILD" ] ; then
    exit 1
fi

if [ "$OSTYPE" = "cygwin" ] ; then
    export AUTOBUILD="$(cygpath -u $AUTOBUILD)"
fi

top="$(pwd)"
stage="$(pwd)/stage"

# load autobuild provided shell functions and variables
source_environment_tempfile="$stage/source_environment.sh"
"$AUTOBUILD" source_environment > "$source_environment_tempfile"
. "$source_environment_tempfile"

# source directory
SOURCE_DIR="THREE.CubemapToEquirectangular"

# used in VERSION.txt but common to all bit-widths and platforms
build=${AUTOBUILD_BUILD_ID:=0}

# no version information for this package so come up with something
echo "1.1.0" > "$stage/VERSION.txt"

case "$AUTOBUILD_PLATFORM" in
    windows* | darwin64)

        # create folders
        mkdir -p "$stage/js"
        mkdir -p "$stage/LICENSES"

        # javascript files
        cp "${SOURCE_DIR}/src/CubemapToEquirectangular.js" "$stage/js/"

        # license file
        cp "${SOURCE_DIR}/LICENSE" "$stage/LICENSES/CUBEMAPTOEQUIRECTANGULAR_LICENSE.txt"
    ;;

    "linux")
    ;;

    "linux64")
    ;;
esac
