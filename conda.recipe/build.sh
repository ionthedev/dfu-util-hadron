#!/usr/bin/env bash
set -euxo pipefail

owner="ionthedev"
repo="dfu-util-hadron"
version="${PKG_VERSION}"

case "${target_platform}" in
  linux-64)
    asset="dfu-util-v${version}-linux-x86_64.tar.gz"
    ;;
  osx-arm64)
    asset="dfu-util-v${version}-mac-arm64.tar.gz"
    ;;
  osx-64)
    asset="dfu-util-v${version}-mac-x86_64.tar.gz"
    ;;
  *)
    echo "Unsupported target_platform: ${target_platform}" >&2
    exit 1
    ;;
esac

url="https://github.com/${owner}/${repo}/releases/download/v${version}/${asset}"
curl -fL --retry 3 --retry-delay 2 -o release.tar.gz "${url}"
tar -xzf release.tar.gz

install -d "${PREFIX}/bin"
install -m 0755 dfu-util dfu-prefix dfu-suffix "${PREFIX}/bin/"

# Include runtime libraries when they are present in the release artifact.
shopt -s nullglob
for lib in libusb-1.0*.dylib libusb-1.0.so*; do
  install -m 0755 "${lib}" "${PREFIX}/bin/"
done
