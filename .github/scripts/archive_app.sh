#!/bin/bash

set -eo pipefail

xcodebuild -workspace Count\ my\ breaths.xcodeproj \
            -scheme Count\ my\ breaths \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/Count\ my\ breaths.xcarchive \
            clean archive | xcpretty
