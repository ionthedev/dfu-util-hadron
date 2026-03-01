#!/usr/bin/env bash
set -euxo pipefail

install -d "${PREFIX}/bin"
install -m 0755 dfu-util dfu-prefix dfu-suffix "${PREFIX}/bin/"
