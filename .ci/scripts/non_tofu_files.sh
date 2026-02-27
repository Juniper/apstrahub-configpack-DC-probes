#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

if [ $# -ne 1 ]; then
  echo "usage: $0 module_path"
  exit 2
fi

FILES=$(find "$1" -type f \! -name '*.tf')

if [ "$FILES" != "" ]; then
  echo "non .tf files found in $1:"
  echo "$FILES"
  exit 3
fi