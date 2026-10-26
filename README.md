# demonia-theme

Thème PrestaShop 9.1.4 de la refonte de demonia.com, adapté de la maquette Lovable « midnight-platform-boutique ».

- Cible : PrestaShop 9.1.4, préprod mydivorceparty.fr (OVH), thème de départ Classic 3.1.2.
- Les sources Lovable restent dans leur propre dépôt : ce dépôt ne contient que le thème et ses outils.

## Contenu

- `banc/` : installation et relance de la boutique de test (PrestaShop 9.1.4 + Classic 3.1.2).
- `themes/demonia/` : le thème. Point de départ : copie de Classic 3.1.2 (commit b296487 de PrestaShop/classic-theme), renommée « demonia », version 0.1.0. Sources CSS/JS dans `_dev/`, fichiers compilés dans `assets/`.

## Choix d'architecture

Thème autonome issu de Classic 3.1.2 (validé le 26/10/2026), restylé à partir de la maquette Lovable. Classic reste installé sur la boutique pour revenir en arrière.
Conséquence : les correctifs de Classic ne sont pas hérités automatiquement ; à chaque nouvelle version de Classic, comparer et reporter ce qui concerne la sécurité ou la compatibilité.

## Installer le thème sur le banc

```
ln -sfn "$PWD/themes/demonia" /home/claude/ps914/themes/demonia
chown -R www-data:www-data themes/demonia
```
puis l'activer dans Apparence > Thème et logo.

## Historique de vérification

- 0.1.0 : rendu identique à Classic 3.1.2 (0 pixel de différence, accueil desktop et mobile, fiche produit), ajout au panier fonctionnel.
