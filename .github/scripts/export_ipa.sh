
#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/Count\ my\ breaths.xcarchive \
            -exportOptionsPlist Count\ my\ breaths/ExportOptions.plist \
            -exportPath $PWD/build \
            -exportArchive | xcpretty