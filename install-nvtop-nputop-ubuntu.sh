#!/usr/bin/env bash
set -e

# ============================================================
# Combined Installation Script: nputop + nvtop in one directory
# ============================================================

# Directory to hold both repositories
TOOLS_DIR="$HOME/projects/gpu-tools"
mkdir -p "$TOOLS_DIR"
cd "$TOOLS_DIR"

echo "🔹 Updating system packages..."
sudo apt update

# --- Install common dependencies ---
sudo apt install -y \
    curl build-essential pkg-config libssl-dev \
    git cmake libncursesw5-dev libudev-dev \
    libsystemd-dev libdrm-dev intel-gpu-tools mesa-utils

# ============================================================
# Install nputop (Rust-based)
# ============================================================

echo "🔹 Installing Rust via rustup..."
if ! command -v rustc >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

rustup install stable
rustup default stable

echo "🔹 Verifying Rust installation..."
rustc --version
cargo --version

echo "🔹 Cloning nputop repository..."
if [ ! -d "$TOOLS_DIR/nputop" ]; then
    git clone https://github.com/ZoLArk173/nputop.git
fi
cd "$TOOLS_DIR/nputop"

echo "🔹 Cleaning previous build artifacts..."
cargo clean

echo "🔹 Building and installing nputop..."
cargo install --path .

# Ensure Cargo bin directory is in PATH
if ! echo "$PATH" | grep -q "$HOME/.cargo/bin"; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
    export PATH="$HOME/.cargo/bin:$PATH"
fi

echo "✅ nputop successfully installed: $(which nputop)"
nputop --help || echo "Run 'source ~/.bashrc' and then 'nputop --help' to start using it."

# ============================================================
# Install nvtop (CMake-based)
# ============================================================

echo "🔹 Cloning nvtop repository..."
if [ ! -d "$TOOLS_DIR/nvtop" ]; then
    git clone https://github.com/Syllo/nvtop.git
fi
cd "$TOOLS_DIR/nvtop"

echo "🔹 Creating build directory..."
mkdir -p build && cd build

echo "🔹 Configuring build with Intel GPU support..."
cmake .. -DINTEL_SUPPORT=ON

echo "🔹 Building nvtop..."
make -j"$(nproc)"

echo "🔹 Installing nvtop..."
sudo make install

echo "✅ nvtop installation complete!"
echo "You can now run 'nvtop' to monitor your Intel GPU."
echo
echo "Check installation:"
echo "  which nvtop"
echo "  nvtop --version"
