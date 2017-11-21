# These and other macros are documented in ../droid-configs-device/droid-configs.inc
# Feel free to cleanup this file by removing comments, once you have memorised them ;)

%define device oneplus3
%define vendor oneplus

%define vendor_pretty OnePlus
%define device_pretty OnePlus 3

# Community HW adaptations need this
%define community_adaptation 1

# Sailfish OS is considered to-scale, if in app grid you get 4-in-a-row icons
# and 2x2 or 3x3 covers when up-to-4 or 5-or-more apps are open respectively.
# For 4-5.5" device screen sizes of 16:9 ratio, use this formula (hold portrait):
# pixel_ratio = 4.5/DiagonalDisplaySizeInches * HorizontalDisplayResolution/540
# Other screen sizes and ratios will require more trial-and-error.
%define pixel_ratio 1.6

# We assume most devices will
%define have_modem 1

# Device-specific ofono configuration
Provides: ofono-configs

%define ofono_enable_plugins hfp_bluez5,hfp_ag_bluez5

%include droid-configs-device/droid-configs.inc

# IMPORTANT if you want to comment out any macros in your .spec, delete the %
# sign, otherwise they will remain defined! E.g.:
#define some_macro "I'll not be defined because I don't have % in front"

