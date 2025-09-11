

```bash
# --- APPLY UBUNTU 24.10 COMPAT PATCH (idempotent) ---
echo "🩹 Ensuring ubuntu24.10 compatibility patch in dependency script (if present)..."
DEPS_SCRIPT="$OPENVINO_INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh"
if [ -f "$DEPS_SCRIPT" ]; then
    if grep -q 'ubuntu24.10' "$DEPS_SCRIPT"; then
        echo "   Patch already present."
    else
        # Insert mapping after the os= detection assignment line.
        insertion_pattern='os=$( \\. /etc/os-release ; echo "${ID}${VERSION_ID}" )'
        if grep -Fq "$insertion_pattern" "$DEPS_SCRIPT"; then
            echo "   Applying inline sed insertion..."
            # Use a temporary file to avoid sed portability quirks.
            tmp_file=$(mktemp)
            awk -v pat="$insertion_pattern" '{
                print $0;
                if ($0==pat) {
                    print "    # Temporary compatibility: map Ubuntu 24.10 to 24.04 logic until officially supported";
                    print "    if [ \"$os\" = \"ubuntu24.10\" ]; then";
                    print "        echo \"Notice: treating unsupported OS ubuntu24.10 as ubuntu24.04 (experimental)\" >&2";
                    print "        os=\"ubuntu24.04\"";
                    print "    fi";
                }
            }' "$DEPS_SCRIPT" > "$tmp_file" && sudo tee "$DEPS_SCRIPT" > /dev/null < "$tmp_file" && rm -f "$tmp_file"
            if grep -q 'ubuntu24.10' "$DEPS_SCRIPT"; then
                echo "   Patch applied successfully."
            else
                echo "   Failed to apply patch (ubuntu24.10 string not found after insertion)." >&2
            fi
        else
            echo "   Could not find insertion point in dependency script; skipping." >&2
        fi
    fi
else
    echo "   Dependency script not found yet (will skip patch)."
fi

```
