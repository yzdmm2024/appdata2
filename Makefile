# AppData2 — rootless theos tweak
#
# Fork of Fouad Raheb's AppData (https://github.com/FouadRaheb/AppData).
# Adds a "Safe Clean" action that frees app storage while keeping the login state.

export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:14.0
export THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AppData2

APPDATA_DIR = AppData
APPDATA_INCLUDES = \
	-I$(APPDATA_DIR) \
	-I$(APPDATA_DIR)/Classes/Helpers \
	-I$(APPDATA_DIR)/Classes/Model \
	-I$(APPDATA_DIR)/Classes/Tools \
	-I$(APPDATA_DIR)/Classes/Controller \
	-I$(APPDATA_DIR)/Classes/Controller/Cells \
	-I$(APPDATA_DIR)/Classes/Controller/DataSource \
	-I$(APPDATA_DIR)/Classes/Presentation \
	-I$(APPDATA_DIR)/Vendors/NRFileManager

AppData2_FILES = \
	$(APPDATA_DIR)/AppData.xm \
	$(APPDATA_DIR)/Classes/Controller/ADDataViewController.m \
	$(APPDATA_DIR)/Classes/Controller/Cells/ADActionsBarView.m \
	$(APPDATA_DIR)/Classes/Controller/Cells/ADExpandableSectionHeaderView.m \
	$(APPDATA_DIR)/Classes/Controller/Cells/ADTitleSectionHeaderView.m \
	$(APPDATA_DIR)/Classes/Controller/DataSource/ADMainDataSource.m \
	$(APPDATA_DIR)/Classes/Controller/DataSource/ADMoreDataSource.m \
	$(APPDATA_DIR)/Classes/Helpers/ADAppearance.m \
	$(APPDATA_DIR)/Classes/Helpers/ADHelper.m \
	$(APPDATA_DIR)/Classes/Helpers/ADSettings.m \
	$(APPDATA_DIR)/Classes/Model/ADAppData.m \
	$(APPDATA_DIR)/Classes/Presentation/ADDataPresentationAnimator.m \
	$(APPDATA_DIR)/Classes/Presentation/ADDataPresentationController.m \
	$(APPDATA_DIR)/Classes/Presentation/ADDataPresentationManager.m \
	$(APPDATA_DIR)/Classes/Tools/ADTCC.m \
	$(APPDATA_DIR)/Classes/Tools/ADTerminator.m \
	$(APPDATA_DIR)/Vendors/NRFileManager/NRFileManager.m

AppData2_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore CoreLocation MobileCoreServices
AppData2_CFLAGS = -fobjc-arc -Wno-error -Wno-deprecated-declarations $(APPDATA_INCLUDES)
AppData2_CFLAGS += -include $(APPDATA_DIR)/AppData2-Prefix.h
# LSApplicationProxy / SpringBoardServices are private and resolved at runtime inside SpringBoard.
AppData2_LDFLAGS = -Wl,-undefined,dynamic_lookup

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += AppDataPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk