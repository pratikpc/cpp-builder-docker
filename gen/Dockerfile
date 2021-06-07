FROM ghcr.io/pratikpc/cpp-builder-docker/cmake

VOLUME /source
VOLUME /build
VOLUME /vcpkg
WORKDIR /gen-entrypoint
COPY entrypoint.sh /gen-entrypoint
RUN chmod +x /gen-entrypoint/entrypoint.sh

ENTRYPOINT [ "/gen-entrypoint/entrypoint.sh"]