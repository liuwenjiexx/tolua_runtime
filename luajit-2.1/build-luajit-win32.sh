#export PATH=${MSYS64}/mingw32/bin:${PATH}
OUTPUT=build/win/x32
rm -dr ${OUTPUT}
mkdir -p ${OUTPUT}

make clean
make HOST_CC="gcc -m32"

cp -R src/jit ${OUTPUT}
cp src/luajit.exe ${OUTPUT}
cp src/lua51.dll ${OUTPUT}
make clean