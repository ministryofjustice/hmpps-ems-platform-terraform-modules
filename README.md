# HMPPS Electronic Monitoring Service Terraform Modules

This repository contains terraform modules that are consumed by [hmpps-ems-platform](https://github.com/ministryofjustice/hmpps-ems-platform).

## Releasing

Features should be developed on new short-lived branches. Once a feature is ready to release, open a pull request. The pull request will need to be reviewed and approved by a [CODEOWNER](.github/CODEOWNERS) before it can be merged.

When a pull request is merged to main a new tag and release with the appropriate version number.

Versioning is managed by [GitVersion](https://gitversion.net/docs/) and uses the ContinuousDelivery configuraton.

A current list of releases can be found on the [releases page](https://github.com/ministryofjustice/hmpps-ems-platform-terraform-modules/releases).

### Assigning Releases

Releases can be assigned and pushed as follows:

    E.g. tag 0.1.34

    ```shell
        git tag 0.1.34
        git push --tags
    ```
