#! /bin/sh

if [ "$(ls -A /vcpkg)" ]; then
     git -C /vcpkg pull
else
    git clone --depth=1 https://github.com/microsoft/vcpkg /vcpkg
fi