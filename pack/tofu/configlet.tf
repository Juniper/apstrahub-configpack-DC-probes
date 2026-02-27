#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

resource "apstra_configlet" "example" {
  name = var.name
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_hierarchical"
      template_text = <<-EOT
        ether-options {
          802.3ad {
            lacp {
              force-up;
            }
          }
        }
      EOT
    },
  ]
}
