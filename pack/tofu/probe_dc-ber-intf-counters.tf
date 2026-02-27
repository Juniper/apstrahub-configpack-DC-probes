#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "dc-ber-intf-counters-probe" {
  depends_on = [
    apstra_raw_json.ber_collector,
    apstra_raw_json.histogram_collector
  ]
  url     = format("/api/blueprints/%s/probes", var.blueprint_id)
  payload = <<-EOT
  {
    "label": "dc-ber-intf-counters-probe",
    "description": "",  
    "processors": [

      {
        "name": "ber",
        "type": "extensible_data_collector",
        "properties": {
          "execution_count": "-1",
          "service_name": "ber_${var.blueprint_id}",
          "query_expansion": {},
          "service_interval": "600",
          "enable_streaming": true,
          "system_id": "system.system_id",
          "query_tag_filter": {
            "filter": {},
            "operation": "and"
          },
          "graph_query": [
            "match(node('system', name='system', deploy_mode='deploy', role=is_in(['leaf', 'access', 'spine', 'superspine'])))"
          ],
          "keys": [],
          "query_group_by": [],
          "ingestion_filter": {},
          "value_map": {},
          "data_type": "dynamic",
          "service_input": "''"
        },
        "inputs": {},
        "outputs": {
          "out": "ber"
        }
      },
      {
        "name": "histogram",
        "type": "extensible_data_collector",
        "properties": {
          "execution_count": "-1",
          "service_name": "histogram_${var.blueprint_id}",
          "name": "str(interface.if_name)",
          "query_expansion": {
            "bin_num_iter": {
              "type": "string",
              "generator": "map(str, range(16))"
            }
          },
          "service_interval": "600",
          "enable_streaming": true,
          "system_id": "system.system_id",
          "query_tag_filter": {
            "filter": {},
            "operation": "and"
          },
          "bin_num": "str(bin_num_iter)",
          "graph_query": [
            "match(node('system', name='system', system_id=not_none(), deploy_mode=is_in(['deploy'])).out('hosted_interfaces').node('interface', name='interface', if_name=not_none()))"
          ],
          "keys": [
            "bin_num",
            "name"
          ],
          "query_group_by": [],
          "ingestion_filter": {},
          "value_map": {},
          "data_type": "static",
          "service_input": "''"
        },
        "inputs": {},
        "outputs": {
          "out": "histogram"
        }
      }
    
    ],
    "stages": [
      {
        "description": "",
        "enable_metric_logging": false,
        "retention_size": 0,
        "name": "histogram",
        "graph_annotation_properties": {},
        "retention_duration": 86400,
        "hidden_columns": [],
        "units": {
          "sym_live_err": "",
          "enabled_fec_mode": "",
          "sym_harvest_err": ""
        }
      },
      {
        "description": "",
        "enable_metric_logging": false,
        "retention_size": 0,
        "name": "ber",
        "graph_annotation_properties": {},
        "retention_duration": 86400,
        "hidden_columns": [],
        "units": {
          "input_bytes": "",
          "output_packets": "",
          "output_bytes": "",
          "output_crc_errors": "",
          "input_packets": "",
          "input_crc_errors": "",
          "pre_fec_ber": "",
          "fec_ccw_count": "",
          "fec_nccw_count": ""
        }
      }
    ]
  }
EOT
}
