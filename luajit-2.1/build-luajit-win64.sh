OUTPUT=build/win/x64
rm -dr ${OUTPUT}
mkdir -p ${OUTPUT}

make clean
make HOST_CC="gcc -m64"

cp -R src/jit ${OUTPUT}
cp src/luajit.exe ${OUTPUT}
cp src/lua51.dll ${OUTPUT}
make clean