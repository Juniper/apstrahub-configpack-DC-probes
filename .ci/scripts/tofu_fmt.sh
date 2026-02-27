#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

if ! files_needing_fmt=$(tofu fmt -check tofu/)
then
  echo "Error - The following files need formatting with \`tofu fmt\`:"
  echo "$files_needing_fmt" | sed 's/^/  /'
  exit 1
fi
