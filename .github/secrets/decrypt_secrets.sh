#!/bin/sh
set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/provisioningiOSCountmybreaths.mobileprovision ./.github/secrets/provisioningiOSCountmybreaths.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/Certificates.cer ./.github/secrets/Certificates.cer.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/provisioningiOSCountmybreaths.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/provisioningiOSCountmybreaths.mobileprovision


security create-keychain -p "" build.keychain
security import ./.github/secrets/Certificates.cer -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain