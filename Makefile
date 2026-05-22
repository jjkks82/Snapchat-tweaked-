TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SnapchatPlus

SnapchatPlus_FILES = Tweak.xm
SnapchatPlus_CFLAGS = -fobjc-arc
SnapchatPlus_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
