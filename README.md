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

## Fondations Démonia (0.2.0)

- Styles : `themes/demonia/_dev/demonia/` (Tailwind 4, classes préfixées `tw:`, sans preflight), compilés vers `assets/css/demonia.css` par `npm install && npm run build`. Polices Grenze Gotisch et Sora auto-hébergées dans `assets/fonts/`.
- Interactions : `assets/js/demonia.js` (en-tête au défilement, grand menu, tiroir mobile), sans dépendance.
- En-tête : `templates/_partials/header.tpl` ; recherche et panier : `modules/ps_searchbar/`, `modules/ps_shoppingcart/`.
- Pied de page : `templates/_partials/footer.tpl`.
- Pictos provisoires dans `assets/img/pictos/` (voir son README) : à remplacer par les originaux Lovable.

### Réglages back-office attendus

| Zone | Où la régler |
| --- | --- |
| Menu et grand menu | Modules > Menu principal (ps_mainmenu) : catégories et liens |
| Bandeau noir des pratiques | Apparence > Liste de liens : un bloc accroché à `displayNavFullWidth` |
| Bande des promesses | Modules > Réassurance : titre, description, picto PNG monochrome |
| Téléphone, e-mail | Paramètres boutique > Contact > Coordonnées |
| Réseaux sociaux | Modules > Suivez-nous (ps_socialfollow) |
| « Le site » (pied de page) | Apparence > Liste de liens : blocs sur `displayFooter` |
| Liens légaux | Apparence > Liste de liens : bloc sur `displayFooterAfter` |
| Horaires, accroche « Votre boutique fetish préférée » | International > Traductions > thème |

### Écarts connus avec la maquette

- Favoris : lien vers la liste du module blockwishlist, sans compteur dans l'en-tête.
- Panier : la fenêtre de confirmation de PrestaShop est conservée (pas le tiroir Lovable, qui était fictif).
- Tumblr : non proposé par ps_socialfollow.
- Lien « Blog » : absent tant que la solution de blog n'est pas choisie.
- Tunnel de commande : garde l'en-tête et le pied de page de Classic pour l'instant.

## Historique de vérification

- 0.1.0 : rendu identique à Classic 3.1.2 (0 pixel de différence, accueil desktop et mobile, fiche produit), ajout au panier fonctionnel.
- 0.2.0 : polices, couleurs, en-tête et pied de page Démonia. Vérifié sur le banc : desktop 1440 px et mobile 390 px, défilement (barre noire puis retour beige), grand menu, tiroir mobile (onglets, accordéon), catégorie, fiche produit, ajout au panier (fenêtre + compteur), panier, commande, connexion, recherche, ordre de tabulation. Aucune erreur JS, PHP ou HTTP.
