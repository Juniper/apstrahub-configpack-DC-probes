#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "histogram_collector" {
  depends_on = [
    apstra_raw_json.histogram_service
  ]

  # The endpoint for creating/updating collectors
  url = "/api/telemetry/collectors"

  payload = <<-EOT
  {
    "service_name": "histogram_${var.blueprint_id}",
    "collectors": [
      {
        "platform": {
          "os_type": "junos_evo",
          "os_version": "23.4r2",
          "family": "qfx-ms-fixed",
          "model": ""
        },
        "source_type": "cli",
        "cli": "show interfaces extensive",
        "query": {
          "accessors": {
            "bin_num": "/interface-information/physical-interface/ethernet-fechistogram-statistics/bin-num",
            "sym_harvest_err": "/interface-information/physical-interface/ethernet-fechistogram-statistics/sym-harvest-err",
            "sym_live_err": "/interface-information/physical-interface/ethernet-fechistogram-statistics/sym-live-err",
            "enabled_fec_mode": "/interface-information/physical-interface/ethernet-fec-mode/enabled_fec_mode",
            "name": "/interface-information/physical-interface/name"
          },
          "keys": {
            "name": "name",
            "bin_num": "bin_num"
          },
          "values": {
            "enabled_fec_mode": "enabled_fec_mode",
            "sym_harvest_err": "sym_harvest_err",
            "sym_live_err": "sym_live_err"
          },
          "filter": "keys['name'].startswith([\"et-\"]) and keys['bin_num']!=\"\" and \"lo0.0\" not in keys['name'] "
        },
        "relaxed_schema_validation": true
      }
    ]
  }
  EOT
}