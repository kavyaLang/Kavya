#!/bin/bash

# Kavya Project Dependency Installer
# Installs all required development dependencies on Debian/Ubuntu systems
sudo apt-get update
sudo apt-get install -y build-essential cmake git llvm clang flex bison

echo "Dependencies installed successfully"
