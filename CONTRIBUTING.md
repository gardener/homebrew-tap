Please refer to the [Gardener contributor guide](https://gardener.cloud/docs/contribute).

## Homebrew tap maintenance

This repository contains the Homebrew formulas for selected Gardener-related CLI tools.

### How formula updates work

The formulas in this repository are primarily updated automatically via the GitHub workflow
[`remote-dispatch.yaml`](./.github/workflows/remote-dispatch.yaml).

For the currently automated components:

- `diki`
- `gardenlogin`
- `gardenctl-v2`

the update flow is:

1. A release happens in the source repository.
2. The source repository triggers this repository via `repository_dispatch`.
3. The workflow runs the matching update script in `.github/workflows/update-<component>.sh`.
4. The workflow opens a pull request with the updated formula.

### Maintaining automated formulas

When adding another automatically maintained formula, update all of the following:

1. **Formula file**
   - Add the new `<component>.rb` formula to the repository.
2. **Update script**
   - Add `.github/workflows/update-<component>.sh`.
   - Follow the existing scripts for generating the formula content from the version/tag and the
     platform-specific SHA256 digests.
3. **Central update workflow**
   - Update `.github/workflows/remote-dispatch.yaml`:
     - add the component to the `workflow_dispatch.inputs.component.options` list
     - allow the component in the `Validate component` step
4. **Source repository release automation**
   - Update the GitHub Actions workflow in the source repository so that, after a release is built,
     it triggers this repository with the required payload:
     - `component`
     - `tag`
     - `darwin_sha_amd64`
     - `darwin_sha_arm64`
     - `linux_sha_amd64`
     - `linux_sha_arm64`

Without the source repository workflow update, new releases will not automatically update the
formula in this tap.

### Manual retrigger of a formula update

If the automatic trigger didn’t run, failed for any reason, or you need to recreate a formula update pull request, you can manually trigger the workflow:

1. Open the GitHub Actions page for this repository.
2. Select the **Update Homebrew Formula** workflow.
3. Click **Run workflow**.
4. In **Component**, choose the component you want to update.
5. In **Version / tag (e.g. v1.4.0)**, enter the release tag.
6. Provide the SHA256 values in:
   - **Provide sha256 for darwin-amd64**
   - **Provide sha256 for darwin-arm64**
   - **Provide sha256 for linux-amd64**
   - **Provide sha256 for linux-arm64**
7. Run the workflow. It will generate the formula update and open a pull request.

#### How to obtain the required hashes

The required SHA256 digests can be taken from the build workflow in the source repository for the
corresponding release.

Look for the step named **Read-Digests** in the release/build workflow run. This step can usually be found in the last job of the release pipeline and should be labelled like *publish-to-package-repositories / update_gardenlogin_in_homebrew_tap_and_chocolatey_packages* or similar.

Use the digests from that step as input for the manual workflow run in this repository.