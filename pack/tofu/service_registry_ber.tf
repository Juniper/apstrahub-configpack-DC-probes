#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "ber_service" {
  url     = "/api/telemetry-service-registry"
  id      = "ber_${var.blueprint_id}"
  payload = <<-EOT
  {
    "description": "BER service registry",
    "application_schema": {
      "properties": {
        "key": {
          "properties": {
            "name": {
              "type": "string"
            }
          },
          "required": [
            "name"
          ],
          "type": "object"
        },
        "value": {
          "properties": {
            "input_bytes": {
              "type": "string"
            },
            "output_packets": {
              "type": "string"
            },
            "output_bytes": {
              "type": "string"
            },
            "output_crc_errors": {
              "type": "string"
            },
            "input_packets": {
              "type": "string"
            },
            "input_crc_errors": {
              "type": "string"
            },
            "pre_fec_ber": {
              "type": "string"
            },
            "fec_ccw_count": {
              "type": "string"
            },
            "fec_nccw_count": {
              "type": "string"
            }
          },
          "required": [
            "fec_ccw_count",
            "fec_nccw_count",
            "input_bytes",
            "input_crc_errors",
            "input_packets",
            "output_bytes",
            "output_crc_errors",
            "output_packets",
            "pre_fec_ber"
          ],
          "type": "object"
        }
      },
      "required": [
        "key",
        "value"
      ],
      "type": "object"
    },
    "service_name": "ber_${var.blueprint_id}",
    "storage_schema_path": "aos.sdk.telemetry.schemas.iba_data"
  }
  EOT
}
