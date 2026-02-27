#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

MYML="pack/manifest.yml"

[ ! -e "$MYML" ] && echo "$MYML does not exist" && exit 2

[ "$(yq '.manifest_version' < "$MYML")" == "null" ] && echo "manifest_version is required" && exit 3
[ ! "$(yq '.manifest_version | type' < "$MYML")" == "!!int" ] && echo "manifest_version must be an integer" && exit 4
[ ! "$(yq '.manifest_version' < "$MYML")" -eq 1 ] && echo "manifest_version must be 1" && exit 5

[ "$(yq '.description' < "$MYML")" == "null" ] && echo "description is required" && exit 6
[ ! "$(yq '.description | type' < "$MYML")" == "!!str" ] && echo "description must be a string" && exit 7
[ -z "$(yq '.description' < "$MYML")" ] && echo "description must not be empty" && exit 8

[ "$(yq '.supported_apstra_versions' < "$MYML")" == "null" ] && echo "supported_apstra_versions is required" && exit 9
[ ! "$(yq '.supported_apstra_versions | type' < "$MYML")" == "!!seq" ] && echo "supported_apstra_versions must be a list" && exit 10
[ -z "$(yq '.supported_apstra_versions' < "$MYML")" ] && echo "supported_apstra_versions must not be empty" && exit 11

exit 0

