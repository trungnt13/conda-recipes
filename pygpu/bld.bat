mkdir build
cd build

REM Configure step
REM set CMAKE_CUSTOM=
set CMAKE_GENERATOR=NMake Makefiles
cmake -G "%CMAKE_GENERATOR%" ^
-DCMAKE_BUILD_TYPE=Release ^
-DHDF5_BUILD_HL_LIB=ON ^
-DBUILD_SHARED_LIBS=ON ^
-DHDF5_BUILD_CPP_LIB=ON ^
-DHDF5_ENABLE_Z_LIB_SUPPORT=ON ^
-DZLIB_LIBRARY=%LIBRARY_LIB%\zlibstatic.lib ^
-DZLIB_INCLUDE_DIR=%LIBRARY_INC% ^
-DCMAKE_PREFIX_PATH=%PREFIX% ^
-DCMAKE_INSTALL_PREFIX:PATH=%PREFIX% %CMAKE_CUSTOM% %SRC_DIR%
if errorlevel 1 exit 1

REM Build step
nmake
if errorlevel 1 exit 1

REM Install step
nmake install
if errorlevel 1 exit 1

move %PREFIX%\bin\*.* %PREFIX%
if errorlevel 1 exit 1

