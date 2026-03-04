#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_raw_json" "histogram_service" {
  url     = "/api/telemetry-service-registry"
  id     = "histogram_${var.blueprint_id}"
  payload = <<-EOT
  {
    "description": "Histogram service registry",
    "application_schema": {
      "properties": {
        "key": {
          "properties": {
            "bin_num": {
              "type": "string"
            },
            "name": {
              "type": "string"
            }
          },
          "required": [
            "bin_num",
            "name"
          ],
          "type": "object"
        },
        "value": {
          "properties": {
            "enabled_fec_mode": {
              "type": "string"
            },
            "sym_harvest_err": {
              "type": "string"
            },
            "sym_live_err": {
              "type": "string"
            }
          },
          "required": [
            "enabled_fec_mode",
            "sym_harvest_err",
            "sym_live_err"
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
    "service_name": "histogram_${var.blueprint_id}",
    "storage_schema_path": "aos.sdk.telemetry.schemas.iba_data"
  }
  EOT
}
