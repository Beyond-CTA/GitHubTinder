PRODUCT_NAME := BeyondCTAProject
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

xcodegen: 
	@mint run yonaskolb/XcodeGen xcodegen generate --use-cache
setup:
	mint bootstrap
	make xcodegen
	bundle exec pod install
	open ./${WORKSPACE_NAME}
open:
	open ./${WORKSPACE_NAME}
