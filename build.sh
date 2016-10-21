#!/usr/bin/env bash

set -e

xcodebuild -project DSGetLite/DSGetLite.xcodeproj -scheme "DSGetLite" -destination "platform=iOS Simulator,name=iPhone 6" test
