name := `grep name typst.toml | grep -Po '(?<== ).*'`
version := `grep version typst.toml | grep -Po '(?<== ).*'`

pkgdir := name / version
localdir := "$HOME/.local/share/typst/packages/local"
fulldir := localdir / pkgdir

install:
    @rm -rf .temp
    @rsync -a . .temp \
        --filter=':- .gitignore' \
        --exclude='tests' \
        --exclude='.*' \
        --exclude='justfile' \
        --exclude='assets' \
        --exclude='*.pdf' \

    @sed -i '/<!-- exclude -->/Q' .temp/README.md

    @rm -rf {{ fulldir }}
    @mv -Tf .temp {{ fulldir }}
    @echo "installed to {{ fulldir }}"
