#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

if [ -z "$ZIP_FILE_NAME" ]
then
  echo "env ZIP_FILE_NAME is empty"
  exit 2
fi

SIG_FILE_NAME="${ZIP_FILE_NAME}.sig"
#gpg --no-tty --local-user "$FINGERPRINT" --passphrase "$PASSPHRASE" --pinentry-mode=loopback --output "$SIG_FILE_NAME" --detach-sig "$ZIP_FILE_NAME"
gpg --output "$SIG_FILE_NAME" --detach-sig "$ZIP_FILE_NAME"

echo "SIG_FILE_NAME=${SIG_FILE_NAME}" >> "$GITHUB_ENV"

ZIP_DIR="$(dirname "$ZIP_FILE_NAME")"
echo "contents of $ZIP_DIR"
ls -l "$ZIP_DIR"
