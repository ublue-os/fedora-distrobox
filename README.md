# fedora-distrobox

[![build-fedora-distrobox](https://github.com/ublue-os/fedora-distrobox/actions/workflows/build.yml/badge.svg)](https://github.com/ublue-os/fedora-distrobox/actions/workflows/build.yml) 

Fedora toolbox images modified for the best possible OOTB experience under distrobox

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/ublue-os/fedora-distrobox
