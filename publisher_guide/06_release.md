# Create a Release

[up](../README.md)  
[<- previous](./04_update_readme.md) | next ->

---

Ensure that the checks workflows for the branch to be released have completed successfully.

Navigate to the root of your repository in the GitHub web UI and click **_Tags_**, **_Releases_**, and then **_Draft a new release_**.

Create or select a tag for the new release. The tag must be a valid [semver 2.0.0](https://semver.org) string prefixed with `v`. For exapmle: `v1.2.3`.

Press **Publish Release**.

Once a pack version has been released and the release artifacts collected by Apstra Hub, that tag cannot be re-used.
Use a new tag with each release. Tags with pre-release labels (`v1.2.3-alpha`) will be accepted by Apstra Hub, but will
be "unlisted". They will not appear in search results on Apstra Hub.

---

[up](../README.md)  
[<- previous](./04_update_readme.md) | next ->
