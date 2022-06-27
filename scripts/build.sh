cd ..

rm -rf build

xcodebuild archive \
-scheme OSPaymentsLib \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './scripts/build/OSPaymentsLib.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES


xcodebuild archive \
-scheme OSPaymentsLib \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './scripts/build/OSPaymentsLib.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES


xcodebuild -create-xcframework \
-framework './scripts/build/OSPaymentsLib.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/OSPaymentsLib.framework' \
-framework './scripts/build/OSPaymentsLib.framework-iphoneos.xcarchive/Products/Library/Frameworks/OSPaymentsLib.framework' \
-output './scripts/build/OSPaymentsLib.xcframework'