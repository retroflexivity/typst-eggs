name := `grep name typst.toml | grep -Po '(?<== ).*'`
version := `grep version typst.toml | grep -Po '(?<== ).*'`

localdir := "$HOME/.local/share/typst/packages/local"
pkgdir := localdir / name
fulldir := pkgdir / version

install:
    @rm -rf .temp
    @mkdir -p {{ pkgdir }}
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
