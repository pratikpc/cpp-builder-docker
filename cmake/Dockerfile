FROM fedora
RUN dnf -y --enablerepo=updates-testing install git clang gcc wget ninja-build cmake curl zip unzip tar && dnf clean all
ENTRYPOINT [ "cmake" ]