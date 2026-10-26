{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{* Rendu aussi hors de la page (rafraîchissement AJAX) : on charge les icônes ici. *}
{include file='_partials/dm-icons.tpl'}
{* Démonia : champ de recherche de l'en-tête (maquette Lovable). L'id #search_widget,
   l'attribut data-search-controller-url et le champ « s » sont requis par ps_searchbar.js
   (autocomplétion). Les classes de chaque état de l'en-tête sont portées par data-cls-*. *}
<div id="search_widget" class="search-widgets tw:mx-auto tw:hidden tw:max-w-lg tw:flex-1 tw:md:block" data-search-controller-url="{$search_controller_url}">
  <form method="get" action="{$search_controller_url}" role="search"
    class="tw:flex tw:items-center tw:gap-2 tw:rounded-lg tw:px-4 tw:py-1.5 tw:transition-colors tw:focus-within:border-label"
    data-cls-light="tw:border tw:border-label/50 tw:bg-card" data-cls-dark="tw:border tw:border-foreground/20 tw:bg-foreground/10">
    <input type="hidden" name="controller" value="search">
    <span data-cls-light="tw:text-label" data-cls-dark="tw:text-caramel">{dmIcon icon='search' class='tw:size-4'}</span>
    <input type="text" name="s" value="{$search_string}" placeholder="{l s='Corde, menottes, latex…' d='Shop.Theme.Global'}" aria-label="{l s='Search' d='Shop.Theme.Catalog'}"
      class="tw:w-full tw:bg-transparent tw:text-sm tw:outline-none"
      data-cls-light="tw:placeholder:text-label/70" data-cls-dark="tw:text-foreground tw:placeholder:text-muted-foreground">
  </form>
</div>
