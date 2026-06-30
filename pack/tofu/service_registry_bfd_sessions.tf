#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "bfd_sessions" {
  url     = "/api/telemetry-service-registry"
  id      = "bfd_sessions_${var.blueprint_id}"
  payload = <<-EOT
{
    "service_name": "bfd_sessions_${var.blueprint_id}",
    "description": "BFD session state information",
    "storage_schema_path": "aos.sdk.telemetry.schemas.iba_data",
    "application_schema": {
        "properties": {
            "key": {
                "properties": {
                    "session_neighbor": {
                        "type": "string"
                    },
                    "multihop_local_address": {
                        "type": "string"
                    },
                    "session_interface": {
                        "type": "string"
                    },
                    "local_session_state": {
                        "type": "string"
                    },
                    "session_type": {
                        "type": "string"
                    },
                    "client_name": {
                        "type": "string"
                    },
                    "local_diagnostic": {
                        "type": "string"
                    },
                    "remote_diagnostic": {
                        "type": "string"
                    },
                    "remote_session_state": {
                        "type": "string"
                    }
                },
                "required": [
                    "session_neighbor",
                    "session_interface",
                    "local_session_state",
                    "session_type",
                    "client_name",
                    "local_diagnostic",
                    "remote_diagnostic",
                    "remote_session_state"
                ],
                "type": "object"
            },
            "value": {
                "properties": {
                    "session_state": {
                        "type": "string"
                    },
                    "session_up_time": {
                        "type": "string"
                    },
                    "previous_down_time": {
                        "type": "string"
                    }
                },
                "required": [
                    "session_state"
                ],
                "type": "object"
            }
        },
        "required": [
            "key",
            "value"
        ],
        "type": "object"
    }
}
  EOT
}
