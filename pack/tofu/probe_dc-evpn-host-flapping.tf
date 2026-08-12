#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "dc-evpn-host-flapping" {
  url     = format("/api/blueprints/%s/probes", var.blueprint_id)
  payload = <<-EOT
{
  "label": "EVPN Host Flapping",
  "description": "On every EOS or Junos leaf probe monitors MAC addresses that are being learned alternately from local and VTEP interfaces more often than it is allowed by constraints configured in the system.",
  "processors": [
    {
      "name": "EVPN Host Flapping MAC Addresses",
      "type": "extensible_data_collector",
      "properties": {
        "service_name": "evpn_host_flap",
        "service_interval": "120",
        "value_map": {
          "value": {
            "0": "unknown",
            "1": "flapping"
          }
        },
        "graph_query": "node(\"device_profile\", selector=_or(has_items({\"os\": \"EOS\"}), has_items({\"os\": \"Junos\"}))).in_(\"device_profile\").node(\"system\", name=\"system\", deploy_mode=\"deploy\", system_id=not_none(), tag=has_all([\"layer_leaf\"]))",
        "service_input": "''",
        "query_group_by": [],
        "keys": [],
        "collection_type": "\"any\"",
        "ingestion_filter": {},
        "data_type": "dynamic",
        "query_tag_filter": {
          "filter": {},
          "operation": "and"
        },
        "system_node_id": "str(system.id)",
        "execution_count": "-1",
        "system_id": "str(system.system_id)",
        "query_expansion": {}
      },
      "inputs": {},
      "outputs": {
        "out": "EVPN Host Flapping MAC Addresses"
      }
    },
    {
      "name": "EVPN Host Flapping Count per System",
      "type": "set_count",
      "properties": {
        "group_by": [
          "system_id",
          "system_node_id"
        ]
      },
      "inputs": {
        "in": {
          "stage": "EVPN Host Flapping MAC Addresses",
          "column": "value"
        }
      },
      "outputs": {
        "out": "EVPN Host Flapping Count per System"
      }
    },
    {
      "name": "EVPN Host Flapping per System",
      "type": "range_check",
      "properties": {
        "property": "value",
        "raise_on_nan": false,
        "raise_anomaly": false,
        "graph_query": [],
        "anomaly_retention_duration": 86400,
        "range": {
          "min": 1
        },
        "anomalous_node_id_property_name": null,
        "anomaly_retention_size": 1073741824,
        "enable_anomaly_logging": false
      },
      "inputs": {
        "in": {
          "stage": "EVPN Host Flapping Count per System",
          "column": "value"
        }
      },
      "outputs": {
        "out": "EVPN Host Flapping per System"
      }
    },
    {
      "name": "Sustained EVPN Host Flapping",
      "type": "time_in_state_check",
      "properties": {
        "raise_anomaly": true,
        "graph_query": [],
        "anomaly_retention_duration": 86400,
        "state_range": {
          "\"true\"": [
            {
              "min": 120
            }
          ]
        },
        "time_window": 120,
        "anomalous_node_id_property_name": "system_node_id",
        "anomaly_retention_size": 1073741824,
        "enable_anomaly_logging": false
      },
      "inputs": {
        "in": {
          "stage": "EVPN Host Flapping per System",
          "column": "value"
        }
      },
      "outputs": {
        "out": "Sustained EVPN Host Flapping"
      }
    }
  ],
  "stages": [
    {
      "name": "Sustained EVPN Host Flapping",
      "hidden_columns": [
        "system_node_id"
      ],
      "enable_metric_logging": true,
      "retention_duration": 2592000,
      "description": "Raises anomalies for the leafs that suppresses at least one MAC address during 100 (\"Anomaly Threshold\") of \"Anomaly Time Window\" period.",
      "units": {
        "value": ""
      }
    },
    {
      "name": "EVPN Host Flapping MAC Addresses",
      "hidden_columns": [
        "system_node_id"
      ],
      "enable_metric_logging": true,
      "retention_duration": 2592000,
      "description": "Suppressed MAC adresses and VNI/VLAN ID they were advertised from.",
      "units": {
        "value": ""
      }
    },
    {
      "name": "EVPN Host Flapping per System",
      "hidden_columns": [
        "system_node_id"
      ],
      "description": "Indicates \"true\" if the leaf suppressed at least one MAC address, \"false\" otherwise.",
      "units": {
        "value": ""
      }
    },
    {
      "name": "EVPN Host Flapping Count per System",
      "hidden_columns": [
        "system_node_id"
      ],
      "enable_metric_logging": true,
      "retention_duration": 2592000,
      "description": "Counts the number of suppressed MAC addresses for the leafs.",
      "units": {
        "value": ""
      }
    }
  ]
}
EOT
}
