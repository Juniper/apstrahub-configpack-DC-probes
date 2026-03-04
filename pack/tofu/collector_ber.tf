#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "ber_collector" {
  depends_on = [
    apstra_raw_json.ber_service
  ]

  # The endpoint for creating/updating collectors
  url = "/api/telemetry/collectors"
  id = "ber_${var.blueprint_id}"
  payload = <<-EOT
  {
    "service_name": "ber_${var.blueprint_id}",
    "collectors": [
      {
        "platform": {
          "os_type": "junos_evo",
          "os_version": "",
          "family": "qfx-ms-fixed",
          "model": ""
        },
        "source_type": "cli",
        "cli": "show interfaces extensive",
        "query": {
          "accessors": {
            "input_bytes": "/interface-information/physical-interface/ethernet-mac-statistics/input-bytes",
            "output_packets": "/interface-information/physical-interface/ethernet-mac-statistics/output-packets",
            "name": "/interface-information/physical-interface/name",
            "output_bytes": "/interface-information/physical-interface/ethernet-mac-statistics/output-bytes",
            "output_crc_errors": "/interface-information/physical-interface/ethernet-mac-statistics/output-crc-errors",
            "input_packets": "/interface-information/physical-interface/ethernet-mac-statistics/input-packets",
            "input_crc_errors": "/interface-information/physical-interface/ethernet-mac-statistics/input-crc-errors",
            "pre_fec_ber": "/interface-information/physical-interface/ethernet-fec-statistics/pre-fec-ber",
            "fec_ccw_count": "/interface-information/physical-interface/ethernet-fec-statistics/fec_ccw_count",
            "fec_nccw_count": "/interface-information/physical-interface/ethernet-fec-statistics/fec_nccw_count"
          },
          "keys": {
            "name": "name"
          },
          "values": {
            "input_bytes": "input_bytes",
            "output_packets": "output_packets",
            "output_bytes": "output_bytes",
            "output_crc_errors": "output_crc_errors",
            "input_packets": "input_packets",
            "input_crc_errors": "input_crc_errors",
            "pre_fec_ber": "pre_fec_ber",
            "fec_ccw_count": "fec_ccw_count",
            "fec_nccw_count": "fec_nccw_count"
          },
          "filter": "keys['name'].startswith(\"et-\" or \"ge-\" or \"xe-\") and \"lo0.0\" not in keys['name']"
        },
        "relaxed_schema_validation": true
      }
    ]
  }
  EOT
}