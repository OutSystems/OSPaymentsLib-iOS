rm -rf build

xcodebuild archive \
-workspace OSPaymentsLib.xcworkspace \
-scheme OSPaymentsLib \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './build/OSPaymentsLib.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcodebuild archive \
-workspace OSPaymentsLib.xcworkspace \
-scheme OSPaymentsLib \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './build/OSPaymentsLib.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
-framework './build/OSPaymentsLib.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/OSPaymentsLib.framework' \
-framework './build/OSPaymentsLib.framework-iphoneos.xcarchive/Products/Library/Frameworks/OSPaymentsLib.framework' \
-output './build/OSPaymentsLib.xcframework'