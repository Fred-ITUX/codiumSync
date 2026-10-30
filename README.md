# 🧩 codiumSync

![VSCodium](https://img.shields.io/badge/editor-VSCodium-2F80ED?logo=vscodium&logoColor=white)
![Install](https://img.shields.io/badge/install-flatpak-4A90D9?logo=flatpak&logoColor=white)

**Date**: 2026_10_29

VSCodium user settings and snippets, so a new install starts with the same editor setup.

```text
codiumSync/
├── ⚙️ settings.json      user settings
├── 📄 latex.json         LaTeX snippets
├── 🐍 python.json        Python snippets
└── 🐚 shellscript.json   shell snippets
```

## ✂️ Snippets

| File | Count | Snippets |
|---|---|---|
| `latex.json` | 16 | Doc template, Itemize, Enumerate, Center, Section / Subsection / Sub-subsection, Clearpage, Space, code boxes |
| `shellscript.json` | 4 | If, Elif, Echo, Modules import |
| `python.json` | 1 | Print |

## 📥 Restore

Copy the files into the flatpak's user folder:

```bash
userDir="$HOME/.var/app/com.vscodium.codium/config/VSCodium/User"
mkdir -p "$userDir/snippets"
cp settings.json "$userDir/"
cp latex.json python.json shellscript.json "$userDir/snippets/"
```
