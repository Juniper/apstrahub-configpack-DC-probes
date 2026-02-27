#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

if ! [[ "$GITHUB_REF_TYPE" == "tag" ]]
then
  echo "GITHUB_REF_TYPE is $GITHUB_REF_TYPE"
  echo "not generating a release"
  exit 1
fi

if ! [[ "$GITHUB_REF_NAME" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
  echo "tag is $GITHUB_REF_NAME"
  echo "not generating a release"
  exit 2
fi

BUILD_DIR=$(mktemp -d)
TMP_DIR=$(mktemp -d)

[ -e LICENSE ] && cp LICENSE $TMP_DIR
[ -e LICENSE.txt ] && cp LICENSE.txt $TMP_DIR
[ -e pack/README.md ] && cp pack/README.md $TMP_DIR
[ -e pack/manifest.yml ] && cp -r pack/manifest.yml $TMP_DIR
[ -d pack/tofu ] && cp -r pack/tofu $TMP_DIR

ZIP_FILE_NAME="$BUILD_DIR/${GITHUB_REPOSITORY/\//__}__${GITHUB_REF_NAME}.zip"
(cd "$TMP_DIR"; zip -r "$ZIP_FILE_NAME" .)

echo "ZIP_FILE_NAME=${ZIP_FILE_NAME}" >> "$GITHUB_ENV"

echo "contents of $BUILD_DIR"
ls -l "$BUILD_DIR"

