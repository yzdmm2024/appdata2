# AppData2Prefs — Settings bundle for AppData2

TARGET := iphone:clang:latest:14.0
ARCHS := arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME := AppData2Prefs

APPDATA_DIR := ../AppData

AppData2Prefs_FILES := \
	ADPreferencesController.m \
	Classes/ADPrefsHelper.m \
	Classes/Cells/ADHeaderTableViewCell.m \
	Classes/Cells/ADSwitchTableViewCell.m \
	Classes/Controllers/ADSelectListTableViewController.m \
	$(APPDATA_DIR)/Classes/Helpers/ADSettings.m

# Standard layout: the bundle goes to /Library/PreferenceBundles, the entry plist
# to /Library/PreferenceLoader/Preferences (see internal-stage below).
AppData2Prefs_INSTALL_PATH := /Library/PreferenceBundles
AppData2Prefs_FRAMEWORKS := Foundation UIKit
# PSViewController is provided at runtime by the host (Settings process), so the
# Preferences framework binary is never linked — resolve symbols dynamically.
AppData2Prefs_LDFLAGS := -Wl,-undefined,dynamic_lookup
AppData2Prefs_CFLAGS := -fobjc-arc -Wno-error -Wno-deprecated-declarations \
	-IClasses -IClasses/Cells -IClasses/Controllers \
	-I$(APPDATA_DIR)/Classes/Helpers
# Resources/ (Info.plist + icons) is staged into the bundle automatically.

include $(THEOS_MAKE_PATH)/bundle.mk

# Register the "Settings → AppData2" entry. theos adds the /var/jb prefix when packing.
internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AppData2Prefs.plist$(ECHO_END)