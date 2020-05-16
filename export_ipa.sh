
#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/Count\ my\ breaths.xcarchive \
            -exportOptionsPlist Count\ my\ breaths/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty