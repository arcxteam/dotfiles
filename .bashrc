# ============================================================
# ~/.bashrc tambahan dari dotfiles
# File ini di-source otomatis di setiap shell baru
# ============================================================

# ── Force Node 20 via nvm di setiap shell ───────────────────
export NVM_DIR="${NVM_DIR:-/usr/local/share/nvm}"
_NVM_FALLBACK="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh" --no-use
  nvm use default 2>/dev/null || nvm use 20 2>/dev/null || true
elif [ -s "$_NVM_FALLBACK/nvm.sh" ]; then
  export NVM_DIR="$_NVM_FALLBACK"
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh" --no-use
  nvm use default 2>/dev/null || nvm use 20 2>/dev/null || true
fi

# ── Pastikan node 20 di PATH paling depan ───────────────────
if [ -d "$NVM_DIR/versions/node/v20"* ] 2>/dev/null; then
  NODE20=$(ls -d "$NVM_DIR/versions/node/v20"* 2>/dev/null | tail -1)
  [ -n "$NODE20" ] && export PATH="$NODE20/bin:$PATH"
fi
