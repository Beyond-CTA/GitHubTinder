$PODS_ROOT/SwiftGen/bin/swiftgen config run
if which “${PODS_ROOT}/SwiftLint/swiftlint” >/dev/null; then
${PODS_ROOT}/SwiftLint/swiftlint
swiftlint autocorrect --format
else
echo “warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint”
fi

if which mint >/dev/null; then
  rm -f $SRCROOT/Generated/MockResults.swift
  mint run mockolo mockolo --sourcedirs $SRCROOT/BeyondCTAProject --destination $SRCROOT/BeyondCTAProject/Generated/MockResults.swift
else
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
fi
