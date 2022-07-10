FROM ubuntu:22.04

LABEL maintainer="XFY9326@xfy9326.github.io"

ARG NCNN_VERSION=20220701

# Workspace
ENV DEBIAN_FRONTEND noninteractive
ENV WORK_SPACE /ncnn-tools
ENV NCNN_HOME="${WORK_SPACE}/ncnn"
ENV PATH ${PATH}:${NCNN_HOME}/bin
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${NCNN_HOME}/lib

RUN mkdir -p /ncnn-tools

WORKDIR /ncnn-tools

# Environment
RUN apt-get update && \
# Tools
apt install -y --fix-missing wget unzip && \
# Requirements
apt install -y --fix-missing libgomp1 libvulkan-dev libprotobuf-dev


# Deploy tools
RUN wget --no-check-certificate -O "${WORK_SPACE}/ncnn.zip" "https://github.com/Tencent/ncnn/releases/download/${NCNN_VERSION}/ncnn-${NCNN_VERSION}-ubuntu-2204-shared.zip" && \
unzip -d "${WORK_SPACE}" "${WORK_SPACE}/ncnn.zip" && \
mv $(ls -d ${WORK_SPACE}/ncnn-*-shared) "${NCNN_HOME}" && \
rm -rf ncnn.zip "${NCNN_HOME}/include" "${NCNN_HOME}/lib/cmake" && \
echo "${NCNN_VERSION}" > "${NCNN_HOME}/VERSION.txt"

# Clean build
RUN apt-get remove -y --auto-remove wget unzip
WORKDIR /