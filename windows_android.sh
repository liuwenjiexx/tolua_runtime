source windows.sh

if [ -n "$ANDROID_NDK" ]; then
    export NDK=${ANDROID_NDK}
elif [ -n "$ANDROID_NDK_HOME" ]; then
    export NDK=${ANDROID_NDK_HOME}
elif [ -n "$ANDROID_NDK_HOME" ]; then
    export NDK=${ANDROID_NDK_HOME}
else
    export NDK=X:/bin/Android/SDK/ndk/android-ndk-r15c
fi

if [ ! -d "$NDK" ]; then
    echo "Please set ANDROID_NDK environment to the root of NDK."
    exit 1
fi

NDK_API=21

export PATH=${NDK}:${PATH}

echo NDK: $NDK

function build_a() {
    LIBRARY=$1
    NDK_ABI=$2
    $NDK/ndk-build.cmd clean NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk APP_ABI=${NDK_ABI} APP_PLATFORM=android-${NDK_API}
    $NDK/ndk-build.cmd NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk APP_ABI=${NDK_ABI} APP_PLATFORM=android-$NDK_API
    cp ./obj/local/${NDK_ABI}/lib${LIBRARY}.a ../android/jni/lib${LIBRARY}.a
    $NDK/ndk-build.cmd clean NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk APP_ABI=${NDK_ABI} APP_PLATFORM=android-$NDK_API
}


function build() {
    NDK_ABI=$1
    NDK_TOOLCHAIN=$2

    cd pbc
    build_a pbc ${NDK_ABI}
    cd ..

    cd ./android
    ${NDK}/ndk-build.cmd clean APP_ABI=${NDK_ABI} APP_PLATFORM=android-${NDK_API}
    ${NDK}/ndk-build.cmd APP_ABI=${NDK_ABI} APP_PLATFORM=android-${NDK_API}
    cp libs/${NDK_ABI}/libtolua.so ../Plugins/Android/libs/${NDK_ABI} 
    ${NDK}/ndk-build.cmd clean APP_ABI=${NDK_ABI} APP_PLATFORM=android-${NDK_API}
    cd ..

}



# build armeabi-v7a arm-linux-androideabi-4.9
# build arm64-v8a  arm-linux-androideabi-clang
# build x86 x86-4.9