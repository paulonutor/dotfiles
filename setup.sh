#!/bin/bash
set -eufo pipefail

echo "🚀 Setting up @paulonutor dotfiles."

if xcode-select -p &> /dev/null; then
  echo "✅ Xcode command line tools are already installed."
else
  echo "🔧 Installing Xcode command line tools..."
  xcode-select --install &> /dev/null

  while ! xcode-select -p &> /dev/null; do
    sleep 5
  done
  echo "✅ Xcode command line tools installed successfully."
fi

if which -s "brew"; then
  echo "✅ Homebrew is already installed."
else
  echo "🍺 Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "✅ Homebrew installed successfully."
fi

eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)"

if which -s "chezmoi"; then
  echo "✅ Chezmoi is already installed."
else
  echo "⚪️ Installing Chezmoi"
  brew install chezmoi
fi

if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
  echo "ℹ️ Chezmoi already initialized, pulling latest changes..."
  chezmoi update
  echo "✅ Chezmoi updated"
else
  chezmoi init paulonutor
  chezmoi apply
  echo "✅ Chezmoi initialized"
fi
