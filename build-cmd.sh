#!/usr/bin/env bash

cd "$(dirname "$0")"

# turn on verbose debugging output
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

source_environment_tempfile="$stage/source_environment.sh"
"$AUTOBUILD" source_environment > "$source_environment_tempfile"
. "$source_environment_tempfile"

SOURCE_DIR="THREE.CubemapToEquirectangular"

build=${AUTOBUILD_BUILD_ID:=0}

echo "1.1.0" > "$stage/VERSION.txt"

case "$AUTOBUILD_PLATFORM" in
    windows* | darwin64)

        mkdir -p "$stage/js"
        mkdir -p "$stage/LICENSES"

        cp "${SOURCE_DIR}/src/CubemapToEquirectangular.js" "$stage/js/"

        cp "${SOURCE_DIR}/LICENSE" "$stage/LICENSES/CUBEMAPTOEQUIRECTANGULAR_LICENSE.txt"
    ;;

    "linux")
    ;;

    "linux64")
    ;;
esac
