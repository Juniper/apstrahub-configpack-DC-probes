#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

[[ "$GITHUB_REPOSITORY" = *__* ]] && echo "GITHUB_REPOSITORY env var must not contain '__'" && exit 2
IFS=\/ read -r -a PARTS <<< "$GITHUB_REPOSITORY"
[ ! ${#PARTS[@]} -eq 2 ] && echo "GITHUB_REPOSITORY env var should only have a single forward slash" && exit 3
[[ "${PARTS[0]}" == *_ ]] && echo "GitHub org ID must not end with '_'" && exit 4
[[ "${PARTS[1]}" == _* ]] && echo "GitHub repository name must not begin with '_'" && exit 5
[[ "${PARTS[1]}" == *_ ]] && echo "GitHub repository name must not end with '_'" && exit 6

echo "no problematic underscores found in $GITHUB_REPOSITORY"