FROM ghcr.io/pratikpc/cpp-builder-docker/cmake

VOLUME /source
VOLUME /build
VOLUME /vcpkg
WORKDIR /gen-entrypoint
COPY entrypoint.sh /gen-entrypoint
ENTRYPOINT [ "/gen-entrypoint/entrypoint.sh"]