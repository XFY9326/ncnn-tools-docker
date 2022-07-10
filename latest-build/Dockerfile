FROM ubuntu:22.04

LABEL maintainer="XFY9326@xfy9326.github.io"

# Workspace
ENV DEBIAN_FRONTEND noninteractive
ENV WORK_SPACE /ncnn-tools
ENV NCNN_HOME="${WORK_SPACE}/ncnn"
ENV PATH ${PATH}:${NCNN_HOME}/bin
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${NCNN_HOME}/lib

RUN mkdir -p /ncnn-tools/build && \
mkdir -p "${NCNN_HOME}/bin" && \
mkdir -p "${NCNN_HOME}/lib"

WORKDIR /ncnn-tools

# Environment
RUN apt-get update && \
# Tools
apt install -y --fix-missing wget unzip git && \
# Build
apt install -y --fix-missing cmake build-essential protobuf-compiler && \
# Requirements
apt install -y --fix-missing libgomp1 libvulkan-dev libprotobuf-dev

# Download ncnn
RUN git clone --depth=1 https://github.com/Tencent/ncnn.git "${WORK_SPACE}/build/ncnn"

# Build ncnn tools
RUN mkdir -p "${WORK_SPACE}/build/ncnn/build-tools" && \
cd "${WORK_SPACE}/build/ncnn/build-tools" && \
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchains/host.gcc.toolchain.cmake -DNCNN_BUILD_TOOLS=ON .. && \
cd "${WORK_SPACE}/build/ncnn/build-tools" && \
make -j4 && \
make install

# Download libtorch
RUN wget --no-check-certificate -O "${WORK_SPACE}/build/libtorch.zip" https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.12.0%2Bcpu.zip && \
unzip -d "${WORK_SPACE}/build/" "${WORK_SPACE}/build/libtorch.zip" && \
rm -rf "${WORK_SPACE}/build/libtorch.zip"

# Build pnnx
RUN mkdir -p "${WORK_SPACE}/build/ncnn/tools/pnnx/build" && \
cd "${WORK_SPACE}/build/ncnn/tools/pnnx/build" && \
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=install -DTorch_INSTALL_DIR="${WORK_SPACE}/build/libtorch" .. && \
cd "${WORK_SPACE}/build/ncnn/tools/pnnx/build" && \
cmake --build . -j 4 && \
cmake --build . --config Release --target install

# Deploy tools
RUN cp -r "${WORK_SPACE}/build/ncnn/build-tools/install/bin/." "${NCNN_HOME}/bin/" && \
find "${WORK_SPACE}/build/ncnn/build-tools/install/lib" -name "lib*.so*" -exec cp {} "${NCNN_HOME}/lib/" \;  && \
cp -r "${WORK_SPACE}/build/ncnn/tools/pnnx/build/install/bin/." "${NCNN_HOME}/bin/"  && \
find "${WORK_SPACE}/build/libtorch/lib" -name "lib*.so*" -exec cp {} "${NCNN_HOME}/lib/" \;

# Clean build
RUN rm -rf "${WORK_SPACE}/build" && \
apt-get remove -y --auto-remove cmake build-essential wget unzip git protobuf-compiler && \
apt-get clean  

WORKDIR /