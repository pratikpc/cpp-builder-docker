FROM fedora
RUN dnf -y --enablerepo=updates-testing install git && dnf clean all
VOLUME /vcpkg
WORKDIR /vcpkg-check
COPY entrypoint.sh /vcpkg-check 
RUN chmod +x /vcpkg-check/entrypoint.sh

ENTRYPOINT [ "/vcpkg-check/entrypoint.sh"]