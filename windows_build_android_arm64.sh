# Android/ARM, arm64-v8a, Android 4.0+ (ICS)

source windows_android.sh

cd luajit-2.1/src

NDK_ABI=arm64-v8a
NDK_TOOLCHAIN=aarch64-linux-android-4.9

NDKVER=${NDK}/toolchains/${NDK_TOOLCHAIN}
NDKP=${NDKVER}/prebuilt/windows-x86_64/bin/aarch64-linux-android-
NDKF="--sysroot ${NDK}/platforms/android-${NDK_API}/arch-arm64" 
NDKARCH="-DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1 -DLUAJIT_ENABLE_GC64=1"

make clean
make HOST_CC="gcc -m64" CROSS=${NDKP} TARGET_SYS=Linux TARGET_FLAGS="${NDKF} ${NDKARCH}"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean
cd ../../

build ${NDK_ABI} ${NDK_TOOLCHAIN}

echo Successfully linked