# ============================================================
# ~/.zshrc — untuk Codespace pakai zsh
# ============================================================

# ── NVM / Node 20 ───────────────────────────────────────────
export NVM_DIR="${NVM_DIR:-/usr/local/share/nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use
[ -s "$HOME/.nvm/nvm.sh" ] && export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh" --no-use

nvm use default 2>/dev/null || nvm use 20 2>/dev/null || true

# ── PATH guard ──────────────────────────────────────────────
NODE20_BIN=$(ls -d "$NVM_DIR/versions/node/v20"*/bin 2>/dev/null | tail -1)
[ -n "$NODE20_BIN" ] && export PATH="$NODE20_BIN:$PATH"
