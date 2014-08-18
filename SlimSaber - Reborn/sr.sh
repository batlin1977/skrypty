#!/bin/bash
# init
function pause(){
   read -p "$*"
}

echo -e $CL_BLU"Fake buildbot by batlin1977"$CL_RST

echo -e $CL_BLU"Deleting involved repos"$CL_RST
rm -rf ~/android/sr/frameworks/av
rm -rf ~/android/sr/frameworks/native
rm -rf ~/android/sr/frameworks/base
rm -rf ~/android/sr/system/core 
rm -rf ~/android/sr/hardware/libhardware_legacy
rm -rf ~/android/sr/packages/apps/Phone
# rm -rf ~/android/sr/packages/apps/DeviceSettings
# rm -rf ~/android/sr/device/samsung/codina
rm -rf ~/android/ss/device/samsung/u8500-common

echo -e $CL_BLU"Resyncing involved repos"$CL_RST
repo sync -f -j5 frameworks/av
repo sync -f -j5 frameworks/native
repo sync -f -j5 frameworks/base
repo sync -f -j5 system/core 
repo sync -f -j5 hardware/libhardware_legacy
repo sync -f -j5 packages/apps/Phone
# repo sync -f -j5 packages/apps/DeviceSettings
# repo sync -f -j5 device/samsung/codina
repo sync -f -j5 device/samsung/u8500-common


echo -e $CL_BLU"Cherrypicking Oliver patches - android_system_core"$CL_RST
cd system/core
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/34/52034/2
git cherry-pick FETCH_HEAD
echo -e $CL_BLU"Cherrypicking Core Patch - OMX and reboot/shutdown fix - na wszelki wypadek zostawiam skomentowane"$CL_RST
# git cherry-pick 8514cef8ee4e27689f9ab8098744b6e13eac44cf
cd ../..

echo -e $CL_BLU"Cherrypicking Oliver patches - android_frameworks_av"$CL_RST
cd frameworks/av
git fetch https://github.com/om-mah-car/frameworks_av reborn
git cherry-pick bff15bdab719cf981492f37bdb88e1b1a5609adf
cd ..

echo -e $CL_BLU"Cherrypicking Oliver patches - android_frameworks_native"$CL_RST
cd native
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/33/52033/5
git cherry-pick FETCH_HEAD
# echo -e $CL_BLU"Cherrypicking LEGACY SENSORS"$CL_RST
# git fetch https://github.com/batlin1977/android_frameworks_native kk
# git cherry-pick 0f3649487351e137c115ec014151d844b7bfeedd
cd ..

echo -e $CL_BLU"FRAMEWORKS_BASE - imports from KK - moje /judas/"$CL_RST
cd base
# git fetch https://github.com/batlin1977/android_frameworks_base kk
# echo -e $CL_BLU"OK GOOGLE FIX"$CL_RST
# git cherry-pick 401f49a4d7244b9cf0f66fe893b9652a2b98b000
echo -e $CL_BLU"Szybsze wybudzanie z Deep Sleep"$CL_RST
git fetch https://github.com/om-mah-car/frameworks_base reborn
git cherry-pick 91817eed2129b88bd5b51a5d4aff8fccbbb54a8c
#może coś z tego zrobię - long press configurable git cherry-pick b9c6b30daba5e30b7350c8c50d6ce6598b7f9a5e
echo -e $CL_BLU"Reducing memory leaks"$CL_RST
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/34/63034/2 && git cherry-pick FETCH_HEAD
cd ../..

echo -e $CL_BLU"Cherrypicking low in-call volume fix"$CL_RST
cd packages/apps/Phone
git fetch https://github.com/om-mah-car/packages_apps_Phone reborn
git cherry-pick 913d04476de50120981e1bbbae8c4772edaca9b5
cd ../../..
  
# echo -e $CL_BLU"SLIM-changes to device"$CL_RST
# cd device/samsung/codina
# git fetch https://github.com/om-mah-car/android_device_samsung_codina
# git cherry-pick 47fddc582832c875348a0e313a8f13f7285f1024
# git cherry-pick 0f4a8b7fb8673bd11199a91ee9ba51e0ab83721d
# cd ../../..

# echo -e $CL_BLU"SLIM-changes to device-common"$CL_RST
# cd device/samsung/u8500-common
# git fetch https://github.com/shine911/android_device_samsung_u8500-common slimkat
# git cherry-pick 8b008d01beed93b661bf4b86e3094f98a038f727
# cd ../../..

cd device/samsung/u8500-common
git fetch https://github.com/om-mah-car/android_device_samsung_u8500-common reborn
git cherry-pick 5e4d70beb51c62c3f6285b25bac84cf3dcab6b4c
git fetch https://github.com/shine911/android_device_samsung_u8500-common slimkat
git cherry-pick e262ecc39146eb8fbbba8dc9b4209ea65b416905
git cherry-pick d0b983f7eeb20e18949d6bfde62b22504b3d3e5e
git cherry-pick 8b008d01beed93b661bf4b86e3094f98a038f727

pause 'Press [Enter] key to continue...'

make clean
 ./carbon codina 4
