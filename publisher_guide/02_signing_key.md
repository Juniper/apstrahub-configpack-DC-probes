# Signing Key

[up](../README.md)  
[<- previous](./01_create.md) | [next ->](./03_pack_payload.md)

---

Apstra Hub Configuration Packs must be signed using a key known to Apstra Hub.

The public component of the signing key will be shared with Apstra Hub when registering the pack
for distribution.

If you use the release process outlined in this repository, the private component of the signing key
will be stored in the settings of the repository as a _GitHub Actions Secret_ and will be used by
the [release](../.github/workflows/release.yml) GitHub Actions workflow to sign release artifacts.

Additionally, the signing key will be tested with each repository _push_ event by the [checks](../.github/workflows/checks.yml)
GitHub Actions workflow so that any problems can be detected before it's time to create a pack release.

Use the following steps to create and export a signing key.

## Create a GPG key on your local system
Begin by creating a signing key in your GPG keyring on your local system. GitHub's
[instructions](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key) may be useful here, or you can follow the example below.

In this example, the key has no passphrase and the key's _user-id_ is "Apstra Hub Publisher". We'll be
deleting this key from the local system's keyring soon, so it's likely that neither of these choices
will matter. If you intend to keep the key hanging around in the keyring, consider whether a
different key _user-id_ or use of a passphrase is appropriate to your use case. The passphrase can be
included in the command below or (better) supplied interactively by omitting the `--passphrase ""`
argument altogether. 
```shell
key_user_id="Apstra Hub Publisher"
gpg --batch --passphrase "" --quick-gen-key "$key_user_id" rsa4096 sign none
```

## Export the GPG public key for Apstra Hub
Using the same key _user-id_ as above, export the public key for use by Apstra Hub:
```shell
key_user_id="Apstra Hub Publisher"
gpg --output public_key.txt --armor --export "$key_user_id"
```
We'll share the contents of `public_key.txt` when registering the pack for distribution by Apstra Hub.

## Export the GPG secret key for signing within GitHub Actions
Using the same key _user-id_ as above, export the secret key for use within GitHub Actions:
```shell
key_user_id="Apstra Hub Publisher"
gpg --output secret_key.txt --armor --export-secret-key "$key_user_id"
```
We'll be saving the contents of `secret_key.txt` as a GitHub Actions Secret in a moment.

## Delete the signing key from the local system (optional)
```shell
# First, get the key fingerprint from the public key export file:
fingerprint=$(gpg --show-keys --with-colons public_key.txt | awk -F: '/fpr:/{print $10}')
# Use the fingerprint to delete the key from the keyring
gpg --delete-secret-and-public-key --batch --yes "$fingerprint"
```

## Add the private key to GitHub Actions
At this point, you should have two files: `public_key.txt` and `secret_key.txt`. The public key is
not sensitive, and must be shared with Apstra Hub when registering your pack for distribution. Apstra
Hub will use it to validate of your pack artifacts. The secret key _is sensitive_, and will be used
only within a GitHub Actions workflow to sign pack artifacts when creating a release.

- Within the GitHub repository's web UI, select _Settings_ -> _Secrets and variables_ -> _Actions_.
- On the _Secrets_ tab, press the _New repository secret_ button.
- The secret must be named `GPG_PRIVATE_KEY`
- The secret value must be the entire contents of the `secret_key.txt` including the `-----BEGIN PGP PRIVATE KEY BLOCK-----` and `-----END PGP PRIVATE KEY BLOCK-----` lines.
- If you chose to encrypt your key with a passphrase, create a second repository secret:
    - Name: `PASSPHRASE`
    - Value: Your selected passphrase

---

[up](../README.md)  
[<- previous](./01_create.md) | [next ->](./03_pack_payload.md)
