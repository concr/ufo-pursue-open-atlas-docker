#!/bin/sh

set -e

targetDir=$1

[[ -n $targetDir ]] || { echo "Usage: $0 [targetDir]"; exit 1; }

case "${TARGETARCH}" in
	amd64)
		dumbinitFile="dumb-init_1.2.5_x86_64"
		;;
	arm64)
		dumbinitFile="dumb-init_1.2.5_aarch64"
		;;
	*)
		echo "ERROR Unsupported Arch: ${TARGETARCH}"
		exit 1
		;;
esac

dumbinitUrl="https://github.com/Yelp/dumb-init/releases/download/v1.2.5/${dumbinitFile}"

echo "### Downloading ${dumbinitUrl}" && \
curl -fLs -o dumb-init "${dumbinitUrl}" && \
chmod 0755 dumb-init && \
file dumb-init
