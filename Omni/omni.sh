#!/bin/bash
# init
function pause(){
   read -p "$*"
}

echo -e $CL_BLU"Fake buildbot by batlin1977"$CL_RST


echo -e $CL_BLU"Deleting involved repos"$CL_RST
rm -rf ~/android/omni/frameworks/av
rm -rf ~/android/omni/frameworks/native
rm -rf ~/android/omni/frameworks/base
rm -rf ~/android/omni/system/core 
rm -rf ~/android/omni/system/vold
rm -rf ~/android/omni/hardware/libhardware_legacy
rm -rf ~/android/omni/packages/services/Telephony
rm -rf ~/android/omni/device/samsung/u8500-common
rm -rf ~/android/omni/device/samsung/codina
rm -rf ~/android/omni/build
rm -rf ~/android/omni/art
rm -rf ~/android/omni/external/clang
rm -rf ~/android/omni/external/bash
rm -rf ~/android/omni/external/fuse
rm -rf ~/android/omni/external/exfat

echo -e $CL_BLU"Syncing repositories"$CL_RST
repo sync -f frameworks/av
repo sync -f frameworks/native
repo sync -f frameworks/base
repo sync -f packages/services/Telephony
repo sync -f device/samsung/u8500-common
repo sync -f device/samsung/codina
repo sync -f system/vold
repo sync -f system/core
repo sync -f hardware/libhardware_legacy
repo sync -f build
repo sync -f art
repo sync -f external/clang
repo sync -f external/bash
repo sync -f external/exfat
repo sync -f external/fuse

repo sync -f 

echo -e $CL_BLU"Cherrypicking OMX Patch - android_frameworks_av"$CL_RST
cd frameworks/av
git fetch https://github.com/TeamCanjica/omni_frameworks_av android-4.4
git cherry-pick 3e8e2b16811e8c060d3339869b4f85b4842c26a7
cd ..

echo -e $CL_BLU"Cherrypicking OMX Patch - android_frameworks_native"$CL_RST
cd native
git fetch https://github.com/TeamCanjica/omni_frameworks_native android-4.4
git cherry-pick 90db937c9b944c87a386c2b5b713dae811cf69cc
echo -e $CL_BLU"Cherrypicking Legacy sensors"$CL_RST
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/11/59311/1
git cherry-pick FETCH_HEAD
cd ..

echo -e $CL_BLU"Cherrypicking RIL build error fix"$CL_RST
cd opt/telephony
git fetch https://github.com/TeamCanjica/omni_frameworks_opt_telephony android-4.4
git cherry-pick 5e09e67658d95db425d3684e65fbcf73a3705a5b
cd ../..

cd base
echo -e $CL_BLU"Cherrypicking OK Google patch"$CL_RST
git fetch https://github.com/TeamCanjica/android_frameworks_base cm-11.0
git cherry-pick de30387b3c32c2a9cf653590c8454bd002bf0dd1
git fetch https://github.com/batlin1977/android_frameworks_base kk
git cherry-pick f8d8cdabb5227960bbcacbb97f88d6ef01e6fc75
cd ../..

echo -e $CL_BLU"Cherrypicking Core Patch - OMX and reboot/shutdown fix"$CL_RST
cd system/core
git fetch https://github.com/TeamCanjica/android_system_core cm-11.0
git cherry-pick 02f79390ff2d6a0e173d1dd8bfae02844d4c33a6
git cherry-pick 910ccc43a23b042df3df12ed1bbbe32954749e59
cd ../..

echo -e $CL_BLU"Cherrypicking vold patch to allow switching storages"$CL_RST
cd system/vold
git fetch http://github.com/TeamCanjica/omni_system_vold android-4.4
git cherry-pick e241d065c40385713c0628601a62f0d01fd20100
cd ../..

echo -e $CL_BLU"Cherrypicking vibrator fix"$CL_RST
cd hardware/libhardware_legacy
git fetch https://github.com/TeamCanjica/omni_hardware_libhardware_legacy android-4.4
git cherry-pick 2e71ea08a201040727f1e82768e9e50e1cf44fe9
cd ../..

echo -e $CL_BLU"Cherrypicking Low-InCall fix"$CL_RST
cd packages/services/Telephony
git fetch https://github.com/TeamCanjica/omni_packages_services_Telephony android-4.4
git cherry-pick 167b42ab759bf5c9612cf81d8e2a9315534dd3c8
cd ../../..

echo -e $CL_BLU"Cherrypicking ART fix"$CL_RST
cd art
git fetch https://github.com/TeamCanjica/omni_art android-4.4
git cherry-pick e5d00edb9d6cff7845b72e32ed8e048e7234c688
cd ..

# cd device/samsung/u8500-common
# git fetch https://github.com/om-mah-car/android_device_samsung_u8500-common omni
# git cherry-pick 2ef7636e80fc45160bd498bc7e8a7d69ee9875e8
# git cherry-pick c283ff8f63957b9503175fdc478b086b2398985f
# cd ../../..

cd device/samsung/u8500-common
git fetch https://github.com/judas77/android_device_samsung_u8500-common nowy
git cherry-pick af30e63a8fd80355adfcf21b2685f4ccd4353fa4
cd ../../..

cd device/samsung/u8500-common
git fetch https://github.com/shine911/android_device_samsung_u8500-common slimkat
git cherry-pick 8b008d01beed93b661bf4b86e3094f98a038f727
cd ../../..

cd device/samsung/codina
git fetch https://github.com/om-mah-car/android_device_samsung_codina omni
git cherry-pick 35aded0293c364005aac86b900244754464d97d6
cd ../../..

echo -e $CL_RED"Experimental PART"$CL_RST

echo -e $CL_BLU"Temporary - OmniGears: lockscreen notification #1"$CL_RST
cd packages/apps/OmniGears
git fetch https://gerrit.omnirom.org/android_packages_apps_OmniGears refs/changes/62/6062/20 && git cherry-pick FETCH_HEAD
echo -e $CL_BLU"Temporary - OmniGears: OTG #1"$CL_RST
git fetch https://gerrit.omnirom.org/android_packages_apps_OmniGears refs/changes/24/6324/3 && git cherry-pick FETCH_HEAD
cd ../../..

echo -e $CL_BLU"Temporary - Frameworsk/base: lockscreen notification #2"$CL_RST
cd frameworks/base
git fetch https://gerrit.omnirom.org/android_frameworks_base refs/changes/34/5734/23 && git cherry-pick FETCH_HEAD
echo -e $CL_BLU"Temporary - Frameworsk/base: OTG #2"$CL_RST
git fetch https://gerrit.omnirom.org/android_frameworks_base refs/changes/23/6323/13 && git cherry-pick FETCH_HEAD
cd ../..

echo -e $CL_BLU"Toolchain and flags change"$CL_RST
cd build
git fetch https://github.com/JustArchi/android_build OptiV3
git cherry-pick 0cf89401cc8092dda959b5746ec4899fda756cec
# git cherry-pick 676fe87c969ff603fd036da04571ec14f248dab1
cd ..

echo -e $CL_BLU"Turn errors off"$CL_RST
cd frameworks/rs
git fetch https://github.com/JustArchi/android_frameworks_rs android-4.4
git cherry-pick 525af84628f8db47688de392b13c1c2fa73854bb
cd ../..

cd external/clang
git fetch https://github.com/zwliew/android_external_clang cm-11.0
git cherry-pick bb0a1a5f007dc6e6f111c3a726977c4cce256bc5
git cherry-pick 085466671e3c0483466de009bbc81fd31505f6e6
cd ../..

echo -e $CL_BLU"Cherrypicking exfat compilation fix"$CL_RST
cd external/fuse
git fetch https://github.com/SlimSaber/android_external_fuse kk4.4
git cherry-pick f3736cb1104f72ee1f1322a4eea79e960bee0cd6
cd ..
cd exfat
git fetch https://github.com/SlimSaber/android_external_exfat kk4.4
git cherry-pick 0cbb04e3fd9a254dbddf440355949383a9a00976
cd ../..

# cd external/bash
# git fetch https://github.com/DJL10-2/android_external_bash DJL10.2
# git cherry-pick 1ff746e4ce40ed7b58598b63f05b036f5b2b3120
# cd ../..


pause 'Press [Enter] key to continue...'

./omni codina 4
