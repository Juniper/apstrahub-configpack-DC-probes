#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "bfd_sessions_collector" {
  depends_on = [
    apstra_raw_json.bfd_sessions
  ]

  # The endpoint for creating/updating collectors
  url     = "/api/telemetry/collectors"
  id      = "bfd_sessions_${var.blueprint_id}"
  payload = <<-EOT
{
    "service_name": "bfd_sessions_${var.blueprint_id}",
    "collectors": [
        {
            "platform": {
                "os_type": "junos",
                "os_version": "",
                "family": "junos,junos-ex,junos-qfx",
                "model": ""
            },
            "source_type": "cli",
            "cli": "show bfd session extensive",
            "query": {
                "accessors": {
                    "session_up_time": "/bfd-session-information/bfd-session/session-up-time",
                    "local_diagnostic": "/bfd-session-information/bfd-session/local-diagnostic",
                    "previous_down_time": "/bfd-session-information/bfd-session/previous-down-time",
                    "session_state": "/bfd-session-information/bfd-session/session-state",
                    "session_type": "/bfd-session-information/bfd-session/session-type",
                    "session_neighbor": "/bfd-session-information/bfd-session/session-neighbor",
                    "multihop_local_address": "/bfd-session-information/bfd-session/multihop-local-address",
                    "remote_diagnostic": "/bfd-session-information/bfd-session/remote-diagnostic",
                    "session_interface": "/bfd-session-information/bfd-session/session-interface",
                    "remote_state": "/bfd-session-information/bfd-session/remote-state",
                    "client_name": "/bfd-session-information/bfd-session/bfd-client/client-name"
                },
                "keys": {
                    "session_neighbor": "session_neighbor",
                    "multihop_local_address": "multihop_local_address",
                    "session_interface": "session_interface",
                    "local_session_state": "session_state",
                    "session_type": "session_type",
                    "client_name": "client_name",
                    "local_diagnostic": "local_diagnostic",
                    "remote_diagnostic": "remote_diagnostic",
                    "remote_session_state": "remote_state"
                },
                "values": {
                    "session_state": "session_state",
                    "session_up_time": "session_up_time",
                    "previous_down_time": "previous_down_time"
                }
            },
            "relaxed_schema_validation": true
        }
    ]
}
  EOT
}