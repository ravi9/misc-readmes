### Fix the install_openvino_dependencies.sh
Change `/opt/intel/openvino_2025.3/install_dependencies/install_openvino_dependencies.sh` to

```bash
if [ "$os" == "auto" ] ; then
    # shellcheck source=/dev/null
    os=$( . /etc/os-release ; echo "${ID}${VERSION_ID}" )
        # Temporary compatibility: map Ubuntu 25.04 to 24.04 logic until officially supported
    if [ "$os" = "ubuntu25.04" ]; then
        echo "Notice: treating unsupported OS ubuntu25.04 as ubuntu24.04 (experimental)" >&2
        os="ubuntu24.04"
    fi
    if [[ "$os" =~ "rhel8".* ]] ; then
      os="rhel8"
    fi
    case $os in
        centos7|centos8|centos9|\
        rhel8|rhel9.1|rhel9.2|rhel9.3|rhel9.4|\
        opencloudos8.5|opencloudos8.6|opencloudos8.8|opencloudos9.0|opencloudos9.2|\
        tencentos3.1|tencentos3.2|tencentos3.3|tencentos4.0|tencentos4.2|\
        anolis8.6|anolis8.8|\
        openEuler20.03|openEuler22.03|openEuler23.03|openEuler24.03|\
        almalinux8.7|almalinux8.8|almalinux9.2|almalinux9.3|almalinux9.4|\
        amzn2|amzn2022|amzn2023|\
        ol8.7|ol8.8|ol9.2|ol9.3|ol9.4|\
        rocky8.7|rocky8.8|rocky9.2|rocky9.3|rocky9.4|\
        fedora29|fedora30|fedora31|fedora32|fedora33|fedora34|fedora35|fedora36|\
        fedora37|fedora38|fedora39|fedora40|fedora41|\
        opensuse-leap15.3|\
        raspbian9|debian9|ubuntu18.04|\
        raspbian10|debian10|ubuntu20.04|ubuntu20.10|ubuntu21.04|\
        raspbian11|debian11|ubuntu21.10|ubuntu22.04|\
        raspbian12|debian12|ubuntu22.10:ubuntu23.04|ubuntu23.10|ubuntu24.04) [ -z "$print" ] && echo "Detected OS: ${os}" ;;
        *) echo "Unsupported OS: ${os:-detection failed}" >&2 ; exit 1 ;;
    esac
fi
```


### Patch logic for automatic edit.
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
