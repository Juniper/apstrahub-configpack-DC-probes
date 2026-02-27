# Tofu Guidelines

The following OpenTofu configuration guidelines must be followed for a pack to be distributed by Apstra Hub:
- All OpenTofu configuration files are placed in the `pack/tofu/` directory.
- All OpenTofu configuration file names must end with `.tf`.
- Only OpenTofu configuration files may be placed in the `pack/tofu/` directory.
- All OpenTofu configuration files must be formatted with `tofu fmt`.
- A `terraform` block containing only the following must be included in one of the `.tf` files:
  ```terraform
  terraform {
    required_providers {
      apstra = {
        source = "Juniper/apstra" # relative path is required
        version = "0.85.2"        # version may be selected by the publisher, must be at least x.x.x // todo
      }
    }
  }
  ```
- Only the `Juniper/Apstra` provider may be used.
- No `provider` blocks are permitted.
- No `provisioner` blocks are permitted within `resource` blocks.
- Tofu functions which reference the local filesystem are not permitted.
