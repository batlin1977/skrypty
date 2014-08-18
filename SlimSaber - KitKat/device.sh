#!/bin/bash
# init
function pause(){
   read -p "$*"
}
echo -e $CL_BLU"Deleting involved repos"$CL_RST
rm -rf ~/android/ss/device/samsung/codina
rm -rf ~/android/ss/device/samsung/u8500-common

echo -e $CL_BLU"Resyncing involved repos"$CL_RST
repo sync -f -j5 device/samsung/codina
repo sync -f -j5 device/samsung/u8500-common


cd device/samsung/u8500-common
git fetch https://github.com/shine911/android_device_samsung_u8500-common slimkat
git cherry-pick e262ecc39146eb8fbbba8dc9b4209ea65b416905
git cherry-pick d0b983f7eeb20e18949d6bfde62b22504b3d3e5e
git cherry-pick 8b008d01beed93b661bf4b86e3094f98a038f727
git fetch https://github.com/om-mah-car/android_device_samsung_u8500-common ss
git cherry-pick cdbae40dc4006fe98c5eee7003857bdf90381c63
git cherry-pick d7fe64543507136809fd9589a7f63f809fdf42d3
cd ..

cd codina
git fetch https://github.com/om-mah-car/android_device_samsung_codina ss
git cherry-pick 0a1c62c800a893e691c6d16f5b541badd4faeaa7
git cherry-pick 42b0ceae71719b1ddd9f8f44df73633c2785f6df
cd ../../..
pause 'Press [Enter] key to continue...'

make clobber
 . ss.sh codina nosync 4 
