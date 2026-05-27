#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "dc-optical-transceiver-probe" {

  url     = format("/api/blueprints/%s/probes", var.blueprint_id)
  payload = <<-EOT
  {
    "label": "Optical Transceivers",
    "description": "Built-in telemetry for optical interfaces is analysed in this probe.",
    "processors": [
      {
        "name": "Optical Xcvr Stats",
        "type": "optical_xcvr",
        "properties": {
          "execution_count": "-1",
          "service_name": "optical_xcvr",
          "query_expansion": {},
          "service_interval": "600",
          "enable_streaming": true,
          "device_profile": "str(device_profile.label)",
          "system_id": "str(system.system_id)",
          "query_tag_filter": {
            "filter": {},
            "operation": "and"
          },
          "graph_query": "node(\"device_profile\",     name=\"device_profile\").in_(\"device_profile\").node(\"interface_map\").in_(\"interface_map\").node(\"system\",      system_id=not_none(),      deploy_mode=is_in([\"deploy\", \"drain\"]),      name=\"system\")",
          "query_group_by": [],
          "service_input": "''"
        },
        "inputs": {},
        "outputs": {
          "lane": "Lane Stats",
          "interface": "Interface Stats"
        }
      }
    ],
    "stages": [
      {
        "description": "Interface-related optical parameters",
        "enable_metric_logging": true,
        "retention_size": 0,
        "name": "Interface Stats",
        "graph_annotation_properties": {},
        "retention_duration": 2592000,
        "units": {
          "vendor": "",
          "tx_power_high_warn": "dBm",
          "rx_power_low_alarm": "dBm",
          "media_type": "",
          "part_number": "",
          "tx_bias_low_warn": "mA",
          "tx_bias_high_alarm": "mA",
          "vendor_sn": "",
          "rx_power_high_warn": "dBm",
          "tx_bias_low_alarm": "mA",
          "voltage_has_low_warn": "",
          "temperature_has_low_warn": "",
          "voltage_has_low_alarm": "",
          "voltage_low_alarm": "V",
          "temperature_high_alarm": "℃",
          "voltage_has_high_alarm": "",
          "tx_power_high_alarm": "dBm",
          "voltage_has_high_warn": "",
          "temperature_low_alarm": "℃",
          "tx_power_low_alarm": "dBm",
          "temperature_has_high_alarm": "",
          "temperature_has_high_warn": "",
          "voltage": "V",
          "temperature_has_low_alarm": "",
          "temperature_high_warn": "℃",
          "tx_power_low_warn": "dBm",
          "fiber_type": "",
          "voltage_high_alarm": "V",
          "voltage_low_warn": "V",
          "temperature_low_warn": "℃",
          "rx_power_high_alarm": "dBm",
          "tx_bias_high_warn": "mA",
          "wave_length": "nm",
          "temperature": "℃",
          "voltage_high_warn": "V",
          "rx_power_low_warn": "dBm"
        }
      },
      {
        "description": "Lane-related optical parameters",
        "enable_metric_logging": true,
        "retention_size": 0,
        "name": "Lane Stats",
        "graph_annotation_properties": {},
        "retention_duration": 2592000,
        "units": {
          "tx_bias_has_low_warn": "",
          "rx_power": "dBm",
          "tx_power": "dBm",
          "tx_power_has_high_warn": "",
          "tx_bias_has_high_warn": "",
          "tx_bias_has_low_alarm": "",
          "tx_power_has_low_warn": "",
          "tx_power_has_low_alarm": "",
          "rx_power_has_high_warn": "",
          "rx_power_has_low_warn": "",
          "tx_bias_has_high_alarm": "",
          "rx_power_has_high_alarm": "",
          "tx_bias": "mA",
          "tx_power_has_high_alarm": "",
          "rx_power_has_low_alarm": ""
        }
      }
    ]
  }
EOT
}