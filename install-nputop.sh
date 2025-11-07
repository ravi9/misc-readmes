#!/usr/bin/env bash
set -e

# --- Step 1: Install prerequisites ---
sudo apt update
sudo apt install -y curl build-essential pkg-config libssl-dev rustup

# --- Step 2: Initialize rustup and install latest stable Rust ---
rustup install stable
rustup default stable

# --- Step 3: Verify Rust installation ---
rustc --version
cargo --version

# --- Step 4: Clone the nputop repository ---
git clone https://github.com/ZoLArk173/nputop.git
cd nputop

# --- Step 5: Clean any old build artifacts (optional but safe) ---
cargo clean

# --- Step 6: Build and install the tool ---
cargo install --path .

# --- Step 7: Ensure Cargo's bin directory is in PATH ---
if ! echo "$PATH" | grep -q "$HOME/.cargo/bin"; then
  echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
  source ~/.bashrc
fi

# --- Step 8: Confirm installation ---
echo "✅ nputop successfully installed to: $(which nputop)"
nputop --help || echo "Run 'source ~/.bashrc' and then 'nputop --help' to start using it."
