#!/usr/bin/env sh
# Arma dist/dardos-con-viento-itch.zip con index.html en la raíz, listo para subir a itch.io como juego HTML.
set -e
cd "$(dirname "$0")"
mkdir -p dist
rm -f dist/dardos-con-viento-itch.zip
zip -rq dist/dardos-con-viento-itch.zip index.html icon.png lib fonts cartas dardos sobre sonidos vfx fx fondo
echo "Listo: dist/dardos-con-viento-itch.zip"
