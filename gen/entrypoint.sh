#! /bin/sh

cmake "-G" "Ninja" "-DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake" "$@" "-S" "/source" "-B" "/build" 