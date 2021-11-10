#!/bin/bash
source windows_android.sh

# Android armeabi-v7a
NDK_ABI=armeabi-v7a
NDK_TOOLCHAIN=arm-linux-androideabi-4.9

NDKVER=${NDK}/toolchains/${NDK_TOOLCHAIN}
NDKP=${NDKVER}/prebuilt/windows-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot ${NDK}/platforms/android-${NDK_API}/arch-arm" 
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"

cd ./luajit-2.1/src

make clean
make HOST_CC="gcc -m32" CROSS=${NDKP} TARGET_SYS=Linux TARGET_FLAGS="${NDKF} ${NDKARCH}"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../

build ${NDK_ABI} ${NDK_TOOLCHAIN}


# Android x86
NDK_ABI=x86
NDK_TOOLCHAIN=x86-4.9

cd ./luajit-2.1/src

NDKVER=${NDK}/toolchains/${NDK_TOOLCHAIN}
NDKP=${NDKVER}/prebuilt/windows-x86_64/bin/i686-linux-android-
NDKF="--sysroot ${NDK}/platforms/android-${NDK_API}/arch-x86"

make clean
make HOST_CC="gcc -m32" CROSS=${NDKP} TARGET_SYS=Linux TARGET_FLAGS="${NDKF}"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean
cd ../../

build ${NDK_ABI} ${NDK_TOOLCHAIN}


echo Successfully linked