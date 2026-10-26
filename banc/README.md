# Banc de test PrestaShop

Boutique de test isolée pour développer et vérifier le thème avant toute installation sur mydivorceparty.fr.

| Élément | Valeur |
| --- | --- |
| PrestaShop | 9.1.4 (tag officiel, commit 4f76530) |
| Thème de référence | Classic 3.1.2 |
| Pile | PHP 8.3, MariaDB 10.11, Apache, port 8080 |
| Langue / pays | Français, France, Europe/Paris, euros |
| Données | Produits de démonstration PrestaShop |

## Installer

`sudo ./installer.sh`, puis activer Classic dans le back-office (Apparence > Thème et logo).

## Relancer après une mise en veille

`sudo ./demarrer.sh`

## Écarts connus avec la préprod

- Le flux des taux de change (api.prestashop.com) est remplacé par un flux local vide : boutique en euros uniquement, aucun taux inventé.
- Les identifiants du back-office de test sont générés à l'installation et ne sont jamais versionnés.
- Modules et configuration de mydivorceparty.fr non répliqués : à comparer quand l'accès à la préprod sera en place.
