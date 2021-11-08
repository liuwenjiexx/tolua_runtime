# MinGW32 Android/x86, x86 (i686 SSE3), Android 4.0+ (ICS)
source windows_android.sh

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
