FROM ubuntu:20.04

LABEL maintainer="XFY9326@xfy9326.github.io"

# Environment
ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN apt install -y --fix-missing wget unzip

# ncnn-tools requirements
RUN apt install -y --fix-missing libgomp1 libvulkan-dev libprotobuf-dev

# Workspace
RUN mkdir -p /ncnn-tools
ENV WORK_SPACE /ncnn-tools
WORKDIR /ncnn-tools

# Download tools
ARG NCNN_VERSION=20220420
RUN wget --no-check-certificate -O "${WORK_SPACE}/ncnn.zip" "https://github.com/Tencent/ncnn/releases/download/${NCNN_VERSION}/ncnn-${NCNN_VERSION}-ubuntu-2004-shared.zip"

# Deploy tools
ENV NCNN_HOME="${WORK_SPACE}/ncnn"
RUN unzip -d "${WORK_SPACE}" "${WORK_SPACE}/ncnn.zip" && mv $(ls -d ${WORK_SPACE}/ncnn-*-shared) "${NCNN_HOME}"
RUN rm -rf ncnn.zip "${NCNN_HOME}/include" "${NCNN_HOME}/lib/cmake" 
RUN echo "${NCNN_VERSION}" > "${NCNN_HOME}/VERSION.txt"

# Create link
ENV PATH ${PATH}:${NCNN_HOME}/bin
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${NCNN_HOME}/lib
