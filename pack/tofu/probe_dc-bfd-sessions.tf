#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "dc-bfd-sessions" {
  depends_on = [
    apstra_raw_json.bfd_sessions,
    apstra_raw_json.bfd_sessions_collector
  ]
  url     = format("/api/blueprints/%s/probes", var.blueprint_id)
  payload = <<-EOT
{
  "label": "DCA BFD Monitoring",
  "description": "Monitors BFD session state on all deployed switches and raises an anomaly when a session remains down for a sustained period.",
  "processors": [
    {
      "name": "Ingest BFD Sessions",
      "type": "extensible_data_collector",
      "properties": {
        "service_name": "bfd_sessions_${var.blueprint_id}",
        "service_interval": "15",
        "value_map": {},
        "graph_query": [
          "node(\"system\", name=\"system\", deploy_mode=\"deploy\", system_type=\"switch\")"
        ],
        "service_input": "''",
        "query_group_by": [],
        "keys": [],
        "ingestion_filter": {},
        "data_type": "dynamic",
        "query_tag_filter": {
          "filter": {},
          "operation": "and"
        },
        "execution_count": "-1",
        "system_id": "system.system_id",
        "system_node_id": "str(system.id)",
        "query_expansion": {}
      },
      "inputs": {},
      "outputs": {
        "out": "BFD Sessions"
      }
    },
    {
      "name": "Check BFD Session Down",
      "type": "match_string",
      "properties": {
        "raise_anomaly": false,
        "graph_query": [],
        "anomaly_retention_duration": 86400,
        "regexp": "\"^(Down|Init|Failing)$\"",
        "anomalous_node_id_property_name": null,
        "anomaly_retention_size": 1073741824,
        "enable_anomaly_logging": false
      },
      "inputs": {
        "in": {
          "stage": "BFD Sessions",
          "column": "session_state"
        }
      },
      "outputs": {
        "out": "BFD Session Down"
      }
    },
    {
      "name": "Check Sustained BFD Session Down",
      "type": "time_in_state_check",
      "properties": {
        "raise_anomaly": true,
        "graph_query": [],
        "anomaly_retention_duration": 86400,
        "state_range": {
          "\"true\"": [
            {
              "min": 30
            }
          ]
        },
        "time_window": 60,
        "anomalous_node_id_property_name": "system_node_id",
        "anomaly_retention_size": 1073741824,
        "enable_anomaly_logging": false
      },
      "inputs": {
        "in": {
          "stage": "BFD Session Down",
          "column": "value"
        }
      },
      "outputs": {
        "out": "Sustained BFD Session Down"
      }
    }
  ],
  "stages": [
    {
      "name": "BFD Sessions",
      "description": "All BFD sessions per switch with their current state.",
      "enable_metric_logging": true,
      "retention_duration": 2592000,
      "retention_size": 0,
      "hidden_columns": [
        "system_node_id"
      ],
      "units": {
        "session_state": "",
        "session_up_time": "",
        "previous_down_time": ""
      }
    },
    {
      "name": "BFD Session Down",
      "description": "Boolean per session: true when the BFD session state is Down, Init, or Failing.",
      "enable_metric_logging": false,
      "retention_duration": 86400,
      "retention_size": 0,
      "hidden_columns": [
        "system_node_id"
      ],
      "units": {
        "value": ""
      }
    },
    {
      "name": "Sustained BFD Session Down",
      "description": "Boolean per session: true when the BFD session has remained down for at least the configured duration within the configured evaluation window. Raises an anomaly attributed to the device node.",
      "enable_metric_logging": true,
      "retention_duration": 86400,
      "retention_size": 0,
      "hidden_columns": [
        "system_node_id"
      ],
      "units": {
        "value": ""
      }
    }
  ]
}
EOT
}
