// Copie les polices auto-hébergées (mêmes graisses que la maquette Lovable,
// qui chargeait Google Fonts : Grenze Gotisch 300-700, Sora 300-600).
import { mkdirSync, copyFileSync } from "node:fs";
const out = new URL("../../assets/fonts/", import.meta.url);
mkdirSync(out, { recursive: true });
const sets = [
  ["grenze-gotisch", [300, 400, 500, 600, 700]],
  ["sora", [300, 400, 500, 600]],
];
for (const [family, weights] of sets) {
  for (const w of weights) for (const subset of ["latin", "latin-ext"]) {
    const f = `${family}-${subset}-${w}-normal.woff2`;
    copyFileSync(new URL(`./node_modules/@fontsource/${family}/files/${f}`, import.meta.url), new URL(f, out));
  }
}
console.log("Polices copiées dans assets/fonts/");
