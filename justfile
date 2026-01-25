name := `grep name typst.toml | grep -Po '(?<== ).*'`
version := `grep version typst.toml | grep -Po '(?<== ).*'`

pkgdir := name / version
localdir := "$HOME/.local/share/typst/packages/local"
fulldir := localdir / pkgdir

ignore := '{"test*","justfile","assets","*.pdf"}'

install:
    @rm -rf .temp
    @mkdir .temp
    @for file in `ls --ignore={{ ignore }}`; do \
        cp -r $file .temp; \
    done

    @sed -i '/<!-- exclude -->/Q' .temp/README.md
    
    @rm -rf {{ fulldir }}
    @mv -Tf .temp {{ fulldir }}
    @echo "installed to {{ fulldir }}"
   
