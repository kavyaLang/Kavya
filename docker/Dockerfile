#use of ubuntu:latest as base image
FROM ubuntu:22.04

#Set working directory

#Required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    llvm \
    clang \
    flex \
    bison \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /Kavya

COPY . .

#Create build directory and build the project
RUN  mkdir build \
    && cd build \
    && cmake .. \
    && make

#Run the executable
CMD [ "./build/kavya" ]