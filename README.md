# C++ Docker Builder

# Uses

1. [CMake](https://cmake.org/)
2. [VCPKG](https://github.com/microsoft/vcpkg)
3. [Ninja](https://ninja-build.org/)
4. [GCC](https://gcc.gnu.org/)
5. [Clang](https://clang.llvm.org/) (installed already. User can configure using CMake)

# What you need to install?

1. Docker alone  
   Using Docker, the rest of the process is handled by the image.

# I know it works on Linux. But does it work on Windows?
Yes it does work on Windows  
All you need to do is install [Docker Desktop](https://www.docker.com/products/docker-desktop)  
The generated items are Linux based.  
So for quite a few projects, this could replace your need for VMs.  

# Simplest usage sample

1. For this, we recommend using a docker-compose file.
2. Using Docker Compose, we can create a volume
3. To store
   - build data
   - VCPKG
4. Run commands easily
5. Share data easily

# Docker-Compose usage

## Downloading VCPKG/Updating it

By default, our images don't ship with VCPKG  
This is because by the time you use it, you might want newer, more updated vcpkg  
Hence, run this very simple command.  
This command installs VCPKG if absent, or updates it.  
Run `docker compose run --rm vcpkg`

---
## Run CMake

If you just want to run CMake and find out the version  
Run `docker compose run --rm cmake --version`

---
## Generate CMake

To generate CMake Ninja build,
Run `docker compose run gen`  
To pass commands to CMake Generator,  
(Like variables)  
Run `docker compose run gen -DENABLE_TEST=""`  
You can add configuration options to select C++ Compilers etc.
``

---
## Build

To build,  
Run `docker compose run build`

---
## VCPKG

To run VCPKG,  
And view the version  
Run `docker compose run --rm run-vcpkg version`

---
## Run tests

To run CTests,  
Run `docker compose run --rm ctest`

---
## Run generated Code

To run your generated code  
You can  
Run `docker compose run --rm execute /build/sample/sample`  
To make it even easier,  
You can make a small configuration in your Docker Compose
```yaml
  run-sample:
    image: fedora
    entrypoint: /build/sample/sample
    volumes:
      - vcpkg:/vcpkg
      - build:/build
```
After adding this configuration,  
You can run it simply with  
Run `docker compose run --rm run-sample-parser`

# [Docker-Compose file](sample/docker-compose.yml)

```yaml
version: "3.7"
services:
  cmake:
    image: ghcr.io/pratikpc/cpp-builder-docker/cmake:latest
  vcpkg:
    image: ghcr.io/pratikpc/cpp-builder-docker/vcpkg:latest
    volumes:
      - vcpkg:/vcpkg
  gen:
    image: ghcr.io/pratikpc/cpp-builder-docker/gen:latest
    volumes:
      - vcpkg:/vcpkg
      - build:/build
      - ./:/source
  build:
    image: ghcr.io/pratikpc/cpp-builder-docker/build:latest
    volumes:
      - vcpkg:/vcpkg
      - build:/build
      - ./:/source
  ctest:
    image: ghcr.io/pratikpc/cpp-builder-docker/ctest:latest
    volumes:
      - build:/build
  execute:
    image: fedora
    volumes:
      - vcpkg:/vcpkg
      - build:/build
  run-vcpkg:
    image: fedora
    entrypoint: vcpkg/vcpkg
    volumes:
      - vcpkg:/vcpkg
volumes:
  vcpkg: {}
  build: {}
```

# Why Fedora?

1. We have quite a few dependencies
2. They are fairly popular
3. Ubuntu packages are usually not up to date.
4. Installing without Package Manager might require manual intervention.
5. So it was noticed that it would be far easier to
6. Rely on a distro known to update their packages
7. The newer compilers come with newer features, newer updates etc.

# Deployment

1. The images are deployed on GitHub Container Registry
2. The deployment process is automated using GitHub Actions and runs every month
3. If you seek an update more quickly, you can always create a PR or contact me

# Recommended usage

1. We would recommend you to
2. Follow Modern CMake Practices
3. Use VCPKG.json to manage your packages.
4. As we already set the project to use VCPKG toolchain file
5. Using vcpkg.json would allow vcpkg to
   1. Respect your configuration settings
   2. Make it easy for you to set your own configuration
   3. Make distribution easy
   4. Make project versioning easy
   5. For further details, check VCPKG website

# I want to install additional packages to the base (CMake) image
1. I expect the need would not be felt when it comes to VCPKG based packages
2. In such a scenario as this when you wish to modify the CMake package,  

Use Dockerfile to attain that
```Dockerfile
FROM ghcr.io/pratikpc/cpp-builder-docker/cmake:latest
RUN dnf install <package-names>
```
And then update the rest of the packages in your fork because all images except VCPKG ones depend on the CMake base image

# I want to install additional packages to the Build image
Use Dockerfile to attain that
```Dockerfile
FROM ghcr.io/pratikpc/cpp-builder-docker/build:latest
RUN dnf install <package-names>
```
And then in your Docker Compose file, replace our build image with yours

# Contact me
You can contact me [via LinkedIn](https://www.linkedin.com/in/pratik-chowdhury-889bb2183/)  
Or you can create a GitHub Issue!

# [Sample C++ Library with implementation](/pratikpc/rss-parser-cxx)
I have created a simple C++ RSS Parser header only library.  
The library contains a sample file and a CTest Unit test sample.  
I have added a Docker Compose file there  
You can [check it out](/pratikpc/rss-parser-cxx)