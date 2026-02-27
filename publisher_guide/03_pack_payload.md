# Pack Payload

[up](../README.md)  
[<- previous](./02_signing_key.md) | [next ->](./04_update_readme.md)

---

Pack payload consists of:

- OpenTofu configuration files in `pack/tofu`
- A markdown document at `pack/README.md`
- A manifest file at `pack/manifest.yml`

### OpenTofu configuration files

OpenTofu configuration (`.tf`) files, and _only_ those files should appear in the `tofu/` directory.

Further guidelines about OpenTofu configuration can be found [here](./tofu-guidelines.md).

### README.md

The `pack/README.md` file is distinct from the `README.md` at the top of the GitHub repository. This one will be
displayed to users in the Apstra Hub web UI, and distributed with the pack. It should describe the pack and its
installation requirements to potential users.

### manifest.yml

The `pack/manifest.yml` file contains release-specific details about the pack.

| Field                         | Description                                                  | Required | Type            | Example                                   |
|-------------------------------|--------------------------------------------------------------|----------|-----------------|-------------------------------------------|
| __manifest_version__          | Version of the Apstra Hub manifest.yml. Must be 1.           | Yes      | Number          | 1                                         |
| __description__               | Text description of what this _Apstra Hub Content_ is doing. | Yes      | String          | `Loop detection for a specific VLAN ID.`  |
| __supported_apstra_versions__ | Versions of Apstra that are supported.                       | Yes      | List of Strings | `- 4.2.2`                                 |
| __authors__                   | List of authors responsible for the content in email format. | No       | List of Strings | `- "First Last <first.last@example.com>"` |

Example `manifest.yml`:
```yaml
---
manifest_version: 1
description: This is an example pack which includes a single configlet.
supported_apstra_versions:
  - 5.0.0
  - 5.0.1
  - 5.1.0
```


---

[up](../README.md)  
[<- previous](./02_signing_key.md) | [next ->](./04_update_readme.md)
