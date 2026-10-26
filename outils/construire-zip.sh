#!/bin/bash
# Construit le ZIP installable du thème (Apparence > Thème et logo > Ajouter un thème).
# PrestaShop attend config/theme.yml À LA RACINE du ZIP (pas de dossier englobant).
# Usage : ./outils/construire-zip.sh [dossier_de_sortie]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-$ROOT/dist}"
VERSION="$(sed -n 's/^version: //p' "$ROOT/themes/demonia/config/theme.yml")"
mkdir -p "$OUT"
ZIP="$OUT/demonia-$VERSION.zip"
rm -f "$ZIP"
cd "$ROOT/themes/demonia"
zip -qr "$ZIP" . -x "_dev/*" "assets/cache/*" ".gitignore"
unzip -l "$ZIP" | grep -q " config/theme.yml$" || { echo "config/theme.yml absent de la racine du ZIP"; exit 1; }
echo "$ZIP"
