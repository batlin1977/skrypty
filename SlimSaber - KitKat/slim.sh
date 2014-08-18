#!/bin/bash
# init
function pause(){
   read -p "$*"
}

echo -e $CL_BLU"Deleting involved repos"$CL_RST
rm -rf ~/android/ss/system/core
rm -rf ~/android/ss/frameworks/base
rm -rf ~/android/ss/frameworks/av
rm -rf ~/android/ss/frameworks/native
rm -rf ~/android/ss/packages/Services/Telephony
rm -rf ~/android/ss/packages/apps/Camera2
rm -rf ~/android/ss/hardware/libhardware_legacy
# rm -rf ~/android/ss/external/chromium_org
# rm -rf ~/android/sr/packages/apps/DeviceSettings
# rm -rf ~/android/sr/device/samsung/codina
# rm -rf ~/android/sr/device/samsung/u8500-common

echo -e $CL_BLU"Resyncing involved repos"$CL_RST
repo sync -f -j5 system/core 
repo sync -f -j5 frameworks/base
repo sync -f -j5 frameworks/av
repo sync -f -j5 frameworks/native
repo sync -f -j5 packages/services/Telephony
repo sync -f -j5 packages/apps/Camera2
repo sync -f -j5 hardware/libhardware_legacy
repo sync -f -j5 external/chromium_org
# repo sync -f -j5 packages/apps/DeviceSettings
# repo sync -f -j5 device/samsung/codina
# repo sync -f -j5 device/samsung/u8500-common



echo -e $CL_BLU"Fake buildbot by batlin1977"$CL_RST
echo -e $CL_BLU"Cherrypicking Core Patch - OMX and reboot/shutdown fix"$CL_RST
cd system/core
git fetch https://github.com/TeamCanjica/android_system_core cm-11.0
git cherry-pick 8aa242d1827875506ce3339d2df3e0fed6f89e42
# git cherry-pick 347658ad1b53234b52d32d42fba2a72878b883c5
git fetch https://github.com/shine911/android_system_core kk4.4
git cherry-pick 2b0023e4f82d1204fd21da10bd94bb3b79179366
cd ../..
echo -e $CL_BLU"Cherrypicking OK Google patch"$CL_RST
cd frameworks/base
git fetch https://github.com/TeamCanjica/android_frameworks_base cm-11.0
git cherry-pick de30387b3c32c2a9cf653590c8454bd002bf0dd1
# git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/34/63034/2
# git cherry-pick FETCH_HEAD
cd ../..
echo -e $CL_BLU"Cherrypicking OMX Patch - android_frameworks_av"$CL_RST
cd frameworks/av
git fetch https://github.com/TeamCanjica/android_frameworks_av cm-11.0
git cherry-pick 87618c1ea54009c2e5e5dfb60060f9cc2e9bcc52
cd ..
echo -e $CL_BLU"Cherrypicking OMX Patch - android_frameworks_native"$CL_RST
cd native
git fetch https://github.com/TeamCanjica/android_frameworks_native cm-11.0
git cherry-pick f5a8698ce9a3568cea95c03302deb068eff765bd
echo -e $CL_BLU"Cherrypicking Legacy sensors"$CL_RST
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/11/59311/1
git cherry-pick FETCH_HEAD
cd ../..
# echo -e $CL_BLU"Cherrypicking vold patch to allow switching storages"$CL_RST
# cd system/vold
# git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/15/56515/2
# git cherry-pick FETCH_HEAD
# cd ../..
echo -e $CL_BLU"Cherrypicking Low-InCall fix"$CL_RST
cd packages/services/Telephony
git fetch https://github.com/TeamCanjica/android_packages_services_Telephony cm-11.0
git cherry-pick fdf281fdabe5e7517eb96f2faf159bbcc74ae4a6
cd ../../..
echo -e $CL_BLU"Cherrypicking Camera fix"$CL_RST
cd packages/apps/Camera2
git fetch https://github.com/CyanogenMod/android_packages_apps_Camera2 cm-11.0
git cherry-pick 42067bbce2203088e09039169b0262691dd07e97
cd ../../..


echo -e $CL_BLU"Cherrypicking vibrator fix"$CL_RST
cd hardware/libhardware_legacy
git fetch https://github.com/TeamCanjica/android_hardware_libhardware_legacy cm-11.0
git cherry-pick 9c2250d32a1eda9afe3b5cefe3306104148aa532
cd ../..
# echo -e $CL_BLU"Cherrypicking clang optimisation suppression patches"$CL_RST
# cd external/clang
# git fetch https://github.com/zwliew/android_external_clang cm-11.0
# git cherry-pick bb0a1a5f007dc6e6f111c3a726977c4cce256bc5
# git cherry-pick 085466671e3c0483466de009bbc81fd31505f6e6

echo -e $CL_BLU"Cherrypicking chromium_org don't make error build"$CL_RST
cd external/chromium_org
git fetch https://github.com/shine911/android_external_chromium_org cm-11.0
git cherry-pick FETCH_HEAD
cd ../..
# cd base
# git fetch https://github.com/shine911/frameworks_base kk4.4
# git cherry-pick d92f530127d3622801d723ba50252eff8fab6b43
# git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/34/63034/2
# git cherry-pick FETCH_HEAD
# cd ../..

pause 'Press [Enter] key to continue...'

. device.sh
