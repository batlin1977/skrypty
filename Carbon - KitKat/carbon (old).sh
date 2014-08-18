#!/bin/bash
# init
function pause(){
   read -p "$*"
}

echo -e $CL_BLU"Fake buildbot by batlin1977"$CL_RST

echo -e $CL_BLU"Deleting involved repos"$CL_RST
rm -rf ~/android/cb/frameworks/av
rm -rf ~/android/cb/frameworks/native
rm -rf ~/android/cb/frameworks/base
rm -rf ~/android/cb/system/core 
rm -rf ~/android/cb/system/vold
rm -rf ~/android/cb/hardware/libhardware_legacy
rm -rf ~/android/cb/packages/apps/Camera2
rm -rf ~/android/cb/packages/services/Telephony
rm -rf ~/android/cb/packages/apps/CarbonFibers
rm -rf ~/android/cb/device/samsung/codina
rm -rf ~/android/cb/packages/apps/Settings
rm -rf ~/android/cb/packages/apps/DeviceSettings

echo -e $CL_BLU"Syncing repositories"$CL_RST
repo sync -f

echo -e $CL_BLU"Cherrypicking OMX Patch1 - android_frameworks_av"$CL_RST
cd frameworks/av
git fetch https://github.com/batlin1977/android_frameworks_av kk
git cherry-pick 55cb5348924a5c06b57e23bd91c3ba06e3bc03d4
git cherry-pick 04a45041d4f908aac25634c9e6c4c922d5ec918a
cd ..

echo -e $CL_BLU"Cherrypicking OMX Patch2 - android_frameworks_native"$CL_RST
cd native
git fetch https://github.com/batlin1977/android_frameworks_native kk
git cherry-pick 53addaabc5f921aba2ca7760d4bf3b6e0767fd16
git cherry-pick 0f3649487351e137c115ec014151d844b7bfeedd
cd ..

echo -e $CL_BLU"Cherrypicking OMX Patch3 -to do- android_frameworks_base"$CL_RST
cd base
git fetch https://github.com/batlin1977/android_frameworks_base kk
git cherry-pick 25f9360ce13f9f45cfb757b9b8d0667e8f43663a
git cherry-pick 401f49a4d7244b9cf0f66fe893b9652a2b98b000
# git cherry-pick b9c6b30daba5e30b7350c8c50d6ce6598b7f9a5e
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/34/63034/2 && git cherry-pick FETCH_HEAD

cd ../..

echo -e $CL_BLU"Cherrypicking OMX Patch4 - Core "$CL_RST
cd system/core
git fetch https://github.com/batlin1977/android_system_core kk
git cherry-pick e2598fa0e98e4218d856b3892c0dc0e242719130
echo -e $CL_BLU"Cherrypicking Core Patch - OMX and reboot/shutdown fix"$CL_RST
git cherry-pick 8514cef8ee4e27689f9ab8098744b6e13eac44cf
cd ..

echo -e $CL_BLU"Cherrypicking vold patch to allow switching storages"$CL_RST
cd vold
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/15/56515/2
git cherry-pick FETCH_HEAD
cd ../..

echo -e $CL_BLU"Cherrypicking vibrator fix"$CL_RST
cd hardware/libhardware_legacy
git fetch https://github.com/TeamCanjica/android_hardware_libhardware_legacy cm-11.0
git cherry-pick 9c2250d32a1eda9afe3b5cefe3306104148aa532
cd ../..

echo -e $CL_BLU"Cherrypicking Camera fix"$CL_RST
cd packages/apps/Camera2
git fetch https://github.com/batlin1977/packages_apps_Camera2 kk
git cherry-pick 56318fc4a2ebca5c245a9ac689240c5962dfd249
cd ../../..


echo -e $CL_BLU"Cherrypicking Low-InCall fix"$CL_RST
cd packages/services/Telephony
git fetch https://github.com/batlin1977/android_packages_services_Telephony kk
git cherry-pick 5fb2eec820b94967414bd19938b095fcfa0d065d
cd ../../..

echo -e $CL_BLU"Cherrypicking Ace II Settings"$CL_RST
cd device/samsung/codina
git fetch https://github.com/judas77/android_device_samsung_codina carbon
git cherry-pick b04803cadf1b973dcd6748eb7c5a24f7b5e01cc1
git cherry-pick 2dc39d0a32c82701385a8ea518484a775f7b6470
# git cherry-pick ce64400200b0ee8d31276392e719415c1c8f0624
# git fetch https://github.com/judas77/android_device_samsung_codina cm-11.0
# git cherry-pick 139b9d446ea13299b311a82c1973c177d24256e2
cd ../../..

cd device/samsung/u8500-common
# git revert 12469547480ccb2fc2950b65afa8b93b95e78bb0
# git fetch https://github.com/judas77/android_device_samsung_u8500-common cm-11.0
# git cherry-pick 1b5dee446bd7ed12c3893f64cbd6ce9790910507
cd ../../..

echo -e $CL_BLU"Cherrypicking Carbon Fibers polish translation"$CL_RST
cd packages/apps/CarbonFibers
git fetch https://github.com/batlin1977/android_packages_apps_CarbonFibers kk
git cherry-pick f3b7e9c2f2a449b04026b05778c965d9881b91a2
git cherry-pick 1c05b6df0ea09f5f18dca6ec731f6a6e2bd9e621
git cherry-pick 2bac33f05c1f4889d5753d9f98dec13580d48978
cd ../../..

echo -e $CL_BLU"Tlumaczenie ustawien"$CL_RST
cd packages/apps/Settings
git fetch https://github.com/batlin1977/android_packages_apps_Settings kk
# git cherry-pick 8da7146dcd57d92ca5ca174508ac531ec8c47087
git cherry-pick c2157fda7ed3be11d9916200ae620cd33d62d8d2
# git cherry-pick c5123c33fa91fe81b8f7ee18295347a39171d1c5
git fetch https://github.com/batlin1977/android_packages_apps_Settings rsr
git cherry-pick 93b3ebce872d3f96311a1683094bdd3a5d3b11fd
cd ..

echo -e $CL_BLU"NovaThor settings copperfield'y thing;)"$CL_RST
cd DeviceSettings
git fetch https://github.com/batlin1977/android_packages_apps_DeviceSettings invi
git cherry-pick b2fc6b300af8475add4e59f76b79587c32305f8d
# git fetch https://github.com/judas77/android_packages_apps_DeviceSettings master
# git cherry-pick 7745ee5104ab65991973ad446819ca10ffc33667
cd ../../..

echo -e $CL_BLU"Toolchain and flags change"$CL_RST
cd build
git fetch https://github.com/judas77/android_build kk
git cherry-pick b4fb68a7d005e88fb72d88ec93f13627c5de2601
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

# echo -e $CL_BLU"Cherrypicking libjhead symlink patch"$CL_RST
# cd external/jhead
# git fetch https://github.com/akfaew/android_external_jhead cm-11.0
# git cherry-pick 9d1169a729345b09656d7aaccc2cdebda67ee69b
# cd ../..

echo -e $CL_BLU"Cherrypicking exfat compilation fix"$CL_RST
cd external/fuse
git fetch https://github.com/SlimSaber/android_external_fuse kk4.4
git cherry-pick f3736cb1104f72ee1f1322a4eea79e960bee0cd6
cd ..
cd exfat
git fetch https://github.com/SlimSaber/android_external_exfat kk4.4
git cherry-pick 0cbb04e3fd9a254dbddf440355949383a9a00976
cd ../..

pause 'Press [Enter] key to continue...'

make clean
 ./carbon codina 4
