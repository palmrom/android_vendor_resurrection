PRODUCT_BRAND ?= ResurrectionRemix

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
# Enable ADB authentication
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/rr/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/rr/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/rr/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/rr/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/rr/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# RR-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/rr/config/permissions/rr-sysconfig.xml:system/etc/sysconfig/rr-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/rr/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/rr/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/rr/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all rr-specific init rc files
$(foreach f,$(wildcard vendor/rr/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/rr/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is RR! (Based on LineageOS)
PRODUCT_COPY_FILES += \
    vendor/rr/config/permissions/org.lineageos.android.xml:system/etc/permissions/org.lineageos.android.xml \
    vendor/rr/config/permissions/privapp-permissions-lineage.xml:system/etc/permissions/privapp-permissions-lineage.xml

# Include audio files
include vendor/rr/config/rr_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/rr/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/rr/config/twrp.mk
endif

# Required rr packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    LineageParts \
    Development \
    Profiles

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom rr packages
PRODUCT_PACKAGES += \
    AudioFX \
    LineageSettingsProvider \
    Eleven \
    ExactCalculator \
    Trebuchet \
    LockClock \
    SnapdragonCamera2 \
    WallpaperPicker \
    WeatherProvider \
    OmniJaws \
    OmniStyle

# Berry styles
PRODUCT_PACKAGES += \
    LineageDarkTheme \
    LineageSysUIDarkTheme \
    LineageSettingsDarkTheme \
    LineageBlackTheme \
    LineageSysUIBlackTheme \
    LineageSettingsBlackTheme \
    LineageAmberAccent \
    LineageBlackAccent \
    LineageWhiteAccent \
    LineageBrownAccent \
    LineageCyanAccent \
    LineageGreenAccent \
    LineageOrangeAccent \
    LineagePinkAccent \
    LineagePurpleAccent \
    LineageRedAccent \
    LineageYellowAccent \
    LineageTealAccent

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in RR
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
PRODUCT_PACKAGES += \
    lineage_charger_res_images \
    font_log.png \
    libhealthd.lineage
endif

# exFAT tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    mkfs.exfat

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh
    
# Included prebuilt apk's
PRODUCT_PACKAGES += \
    GoogleClock \
    Wallpapers
 
# rsync
PRODUCT_PACKAGES += \
    rsync

# DUI Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)

PRODUCT_PACKAGES += \
    procmem \
    procrank

endif

DEVICE_PACKAGE_OVERLAYS += vendor/rr/overlay/common

PRODUCT_VERSION = 15.1
RR_VERSION := PalmProject-Oreo-$(PRODUCT_VERSION)-$(shell date +%Y%m%d)-$(RR_BUILD)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.palm.version=$(RR_VERSION) \
    ro.palm.releasetype=$(RR_BUILDTYPE) \
    ro.palm.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(RR_VERSION) \
    rr.build.type=$(RR_BUILDTYPE) \

# Properties for build flash info script
PRODUCT_PROPERTY_OVERRIDES += \
    ro.palm.version=$(RR_VERSION) \
    ro.palm.releasetype=$(RR_BUILDTYPE) \
    ro.palm.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(RR_VERSION) \
    rr.build.type=$(RR_BUILDTYPE) \
    
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/rr/build/target/product/security/rr

RR_DISPLAY_VERSION := $(RR_VERSION)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += 
    ro.rr.display.version=$(RR_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/rr/config/partner_gms.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
