#!/bin/bash
# init
function pause(){
   read -p "$*"
}

echo -e $CL_BLU"Fake buildbot by batlin1977"$CL_RST


echo -e $CL_BLU"Deleting involved repos"$CL_RST
rm -rf ~/android/mahdi/frameworks/av
rm -rf ~/android/mahdi/frameworks/native
rm -rf ~/android/mahdi/frameworks/base
rm -rf ~/android/mahdi/system/core 
rm -rf ~/android/mahdi/system/vold
rm -rf ~/android/mahdi/hardware/libhardware_legacy
rm -rf ~/android/mahdi/packages/services/Telephony
rm -rf ~/android/mahdi/packages/apps/Camera2
rm -rf ~/android/mahdi/device/samsung/u8500-common
rm -rf ~/android/mahdi/device/samsung/codina
rm -rf ~/android/mahdi/build
rm -rf ~/android/mahdi/art
rm -rf ~/android/mahdi/external/clang
rm -rf ~/android/mahdi/external/bash
rm -rf ~/android/mahdi/external/fuse
rm -rf ~/android/mahdi/external/exfat


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
repo sync -f packages/apps/Camera2

echo -e $CL_BLU"Cherrypicking Core Patch - OMX and reboot/shutdown fix"$CL_RST
cd system/core
git fetch https://github.com/TeamCanjica/android_system_core cm-11.0
git cherry-pick 8aa242d1827875506ce3339d2df3e0fed6f89e42
git cherry-pick 347658ad1b53234b52d32d42fba2a72878b883c5
cd ../..
echo -e $CL_BLU"Cherrypicking OK Google patch"$CL_RST
cd frameworks/base
git fetch https://github.com/TeamCanjica/android_frameworks_base cm-11.0
git cherry-pick de30387b3c32c2a9cf653590c8454bd002bf0dd1
cd ../..

echo -e $CL_BLU"Cherrypicking ART fix"$CL_RST
cd art
git fetch https://github.com/cernekee/android_art monitor-stack-v1
git cherry-pick fc2ac71d0d9e147c607bff9371fe2ef25d8470af
cd ..
echo -e $CL_BLU"Cherrypicking OMX Patch - android_frameworks_av"$CL_RST
cd frameworks/av
git fetch https://github.com/TeamCanjica/android_frameworks_av cm-11.0
git cherry-pick 87618c1ea54009c2e5e5dfb60060f9cc2e9bcc52
git fetch https://github.com/batlin1977/android_frameworks_av kk
git cherry-pick 68cce31f77c25c0b4c9322f5e3561f9b22a507bb
cd ..
echo -e $CL_BLU"Cherrypicking OMX Patch - android_frameworks_native"$CL_RST
cd native
git fetch https://github.com/TeamCanjica/android_frameworks_native cm-11.0
git cherry-pick f5a8698ce9a3568cea95c03302deb068eff765bd
# echo -e $CL_BLU"Cherrypicking Legacy sensors"$CL_RST
# git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/11/59311/1
# git cherry-pick FETCH_HEAD
cd ../..
echo -e $CL_BLU"Cherrypicking vold patch to allow switching storages"$CL_RST
cd system/vold
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/15/56515/2
git cherry-pick FETCH_HEAD
cd ../..
echo -e $CL_BLU"Cherrypicking Low-InCall fix"$CL_RST
cd packages/services/Telephony
git fetch https://github.com/TeamCanjica/android_packages_services_Telephony cm-11.0
git cherry-pick fdf281fdabe5e7517eb96f2faf159bbcc74ae4a6
cd ../../..
echo -e $CL_BLU"Cherrypicking vibrator fix"$CL_RST
cd hardware/libhardware_legacy
git fetch https://github.com/TeamCanjica/android_hardware_libhardware_legacy cm-11.0
git cherry-pick 9c2250d32a1eda9afe3b5cefe3306104148aa532
cd ../..

echo -e $CL_BLU"Cherrypicking JustArchi's ArchiDroid Optimizations V3"$CL_RST
cd build
git fetch https://github.com/TeamCanjica/android_build cm-11.0
git cherry-pick dbe7e5b4fff354cd9a9ef2e6605fa7db7eef9727
cd ..
echo -e $CL_BLU"Cherrypicking ART compatibility fix with GCC 4.8"$CL_RST
cd art
git fetch https://github.com/JustArchi/android_art cm-11.0
git cherry-pick 71a0ca3057cc3865bd8e41dcb94443998d028407
cd ..
echo -e $CL_BLU"Cherrypicking clang optimisation suppression patches"$CL_RST
cd external/clang
git fetch https://github.com/zwliew/android_external_clang cm-11.0
git cherry-pick bb0a1a5f007dc6e6f111c3a726977c4cce256bc5
git cherry-pick 085466671e3c0483466de009bbc81fd31505f6e6
cd ../..

echo -e $CL_BLU"Cherrypicking Device tree fixes"$CL_RST
cd device/samsung/codina
git fetch https://github.com/judas77/android_device_samsung_codina carbon
git cherry-pick b04803cadf1b973dcd6748eb7c5a24f7b5e01cc1
git cherry-pick 2dc39d0a32c82701385a8ea518484a775f7b6470
git fetch https://github.com/judas77/android_device_samsung_codina mahdi
git cherry-pick de0cc0478c55728aad2e8ce960c2f26a48e3b640
cd ../../..

echo -e $CL_BLU"Cherrypicking exfat compilation fix"$CL_RST
cd external/fuse
git fetch https://github.com/SlimSaber/android_external_fuse kk4.4
git cherry-pick f3736cb1104f72ee1f1322a4eea79e960bee0cd6
cd ..
cd exfat
git fetch https://github.com/SlimSaber/android_external_exfat kk4.4
git cherry-pick 0cbb04e3fd9a254dbddf440355949383a9a00976
cd ../..

cd device/samsung/u8500-common
# git revert 12469547480ccb2fc2950b65afa8b93b95e78bb0
git fetch https://github.com/judas77/android_device_samsung_u8500-common cm-11.0
git cherry-pick 37e9cfcdcaa0640ac66ebcf38b3b9e121f5a1ce4
git cherry-pick 2026a3625e4d514947a6fb802981c4d41f4e8260
git cherry-pick 6385effa362ec51c012b0adeacb36d2135b14a95
git cherry-pick 1721ab804f4a5bad8a5ca8d4cfa874506bb81048
git cherry-pick 89d8176eb016ce8fe967019cf145fc5d3888ce27
git cherry-pick d7d14b1241826611dca6585435476f20d3277793
# git cherry-pick 7a08afeb9457b01b2a6c231acf924cb457fba425
# git cherry-pick 21a9725d2d51dae0744f9cd1649583568fbde9ef
# git fetch https://github.com/shine911/android_device_samsung_u8500-common cm-11.0
# git cherry-pick 31c908050f7294d8d468a49577f82f04fbe26064
cd ../../..

# echo -e $CL_BLU"Cherrypicking libjhead symlink patch"$CL_RST
# cd external/jhead
# git fetch https://github.com/akfaew/android_external_jhead cm-11.0
# git cherry-pick 9d1169a729345b09656d7aaccc2cdebda67ee69b
# cd ../..

cd external/bash
git fetch https://github.com/DJL10-2/android_external_bash DJL10.2
git cherry-pick 1ff746e4ce40ed7b58598b63f05b036f5b2b3120
cd ../..

# cd build
# git fetch https://github.com/omnirom/android_build android-4.4
# git cherry-pick d5685b6a017a0684bb792008734379257b8527bc
# cd ..

echo -e $CL_BLU"Cherrypicking Camera fix"$CL_RST
cd packages/apps/Camera2
git fetch https://github.com/batlin1977/packages_apps_Camera2 kk
git cherry-pick 56318fc4a2ebca5c245a9ac689240c5962dfd249
cd ../../..

pause 'Press [Enter] key to continue...'

make clean

./mahdi codina 4
