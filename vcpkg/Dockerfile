FROM fedora
RUN dnf -y --enablerepo=updates-testing install git && dnf clean all
VOLUME /vcpkg
WORKDIR /vcpkg-check
COPY entrypoint.sh /vcpkg-check 
ENTRYPOINT [ "/vcpkg-check/entrypoint.sh"]