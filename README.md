# HMPPS Electronic Monitoring Service Terraform Modules

This repository contains terraform modules that are consumed by [hmpps-ems-platform](https://github.com/ministryofjustice/hmpps-ems-platform).

## Releasing

Releases are automatically drafted by the `draft-release.yml` workflow. This includes updating the release notes and updating the published version tag. Every push to the main branch will cause the draft release to be updated. The semantic version is automatically incremented depending on the labels associated with the latest pull requests merged to the main branch.

```yaml
version-resolver:
  major:
    labels:
      - 'major'
  minor:
    labels:
      - 'minor'
  patch:
    labels:
      - 'patch'
  default: patch
```

Release notes are generated from the pull request titles associated with the release so it is good practice to create clear, concise titles that descibe the changes being made. Frequent, small pull requests will help to ensure that release notes are useful to end users.

A current list of releases can be found on the [releases page](https://github.com/ministryofjustice/hmpps-ems-platform-terraform-modules/releases).

### Publishing Releases

Ensure that the release notes make sense to a entity using these terraform modules. If necessary, make changes to improve readability.

- Navigate to the releases page and open the current draft release.
- Click publish release.
