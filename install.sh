#!/usr/bin/env bash
# ============================================================
# Dotfiles bootstrap - runs ONCE on every new Codespace
# Repo: arcxteam/dotfiles
# Set di: github.com/settings/codespaces → Dotfiles
# ============================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo ""
echo "=== [dotfiles] Bootstrap starting from $DOTFILES_DIR ==="

# ── 1. Force Node 20 via NVM ─────────────────────────────────
NVM_DIR_PATHS=(
  "/usr/local/share/nvm"
  "$HOME/.nvm"
  "/home/codespace/.nvm"
)
for NVM_PATH in "${NVM_DIR_PATHS[@]}"; do
  if [ -s "$NVM_PATH/nvm.sh" ]; then
    export NVM_DIR="$NVM_PATH"
    # shellcheck disable=SC1091
    . "$NVM_DIR/nvm.sh"
    echo "[nvm] Found at $NVM_DIR"
    nvm install 20 --no-progress 2>/dev/null || nvm install 20 || true
    nvm alias default 20
    nvm use default
    echo "[nvm] Active: $(node -v)"
    break
  fi
done

# ── 2. Force Node 20 via NVS (universal image pakai ini) ─────
if command -v nvs &>/dev/null; then
  nvs add 20 2>/dev/null || true
  nvs link 20 2>/dev/null || true
  echo "[nvs] Active: $(node -v 2>/dev/null || echo 'nvs set')"
fi

# ── 3. Set .nvmrc global ─────────────────────────────────────
echo "20" > "$HOME/.nvmrc"
echo "[nvmrc] Set $HOME/.nvmrc = 20"

# ── 4. Symlink dotfiles ke HOME ──────────────────────────────
# File-file yang di-symlink otomatis ke $HOME
DOTFILES=(
  ".bashrc"
  ".zshrc"
  ".npmrc"
  ".gitconfig"
  ".gitignore_global"
)
for f in "${DOTFILES[@]}"; do
  src="$DOTFILES_DIR/$f"
  dst="$HOME/$f"
  if [ -f "$src" ]; then
    # Backup file lama jika ada dan bukan symlink
    if [ -f "$dst" ] && [ ! -L "$dst" ]; then
      cp "$dst" "${dst}.bak.$(date +%s)" 2>/dev/null || true
    fi
    ln -sf "$src" "$dst"
    echo "[symlink] $dst → $src"
  fi
done

# ── 5. Setup npm global cache dir ────────────────────────────
mkdir -p "$HOME/.npm-cache"
if command -v npm &>/dev/null; then
  npm config set cache "$HOME/.npm-cache" --global 2>/dev/null || true
  echo "[npm] Cache: $HOME/.npm-cache"
fi

# ── 6. Bersihkan cache extension VS Code yang korup ──────────
echo "[cache] Clearing VS Code extension caches..."
rm -rf "$HOME/.vscode-remote/extensionsCache"            2>/dev/null || true
rm -rf "$HOME/.vscode-server/extensionsCache"            2>/dev/null || true
rm -rf "$HOME/.vscode-remote/data/CachedExtensionVSIXs" 2>/dev/null || true
rm -rf "$HOME/.vscode-server/data/CachedExtensionVSIXs" 2>/dev/null || true
echo "[cache] Done."

# ── 7. Unset proxy yang bisa memblok download extension ──────
unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy 2>/dev/null || true
echo "[proxy] Cleared."

# ── 8. Setup git global gitignore ────────────────────────────
if command -v git &>/dev/null && [ -f "$HOME/.gitconfig" ]; then
  git config --global core.excludesfile "$HOME/.gitignore_global" 2>/dev/null || true
  echo "[git] Global gitignore set."
fi

echo ""
echo "=== [dotfiles] Bootstrap complete ==="
echo "    Node: $(node -v 2>/dev/null || echo 'not resolved yet - reload shell')"
echo "    npm : $(npm -v  2>/dev/null || echo 'not resolved yet')"
echo ""
