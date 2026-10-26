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
{* Démonia : icône panier de l'en-tête (silhouette pleine de la maquette Lovable).
   ps_shoppingcart.js remplace .blockcart après chaque ajout : la classe et
   data-refresh-url doivent rester sur cet élément. *}
<div id="_desktop_cart">
  <div class="blockcart cart-preview {if $cart.products_count > 0}active{else}inactive{/if}" data-refresh-url="{$refresh_url}">
    <a href="{$cart_url}" rel="nofollow"
      aria-label="{l s='Panier, %nb% article(s)' sprintf=['%nb%' => $cart.products_count] d='Shop.Theme.Checkout'}"
      class="tw:relative tw:inline-flex tw:size-10 tw:items-center tw:justify-center tw:transition-colors tw:hover:text-label">
      {dmIcon icon='bag-solid' class='tw:size-7'}
      {if $cart.products_count > 0}
        <span class="cart-products-count tw:absolute tw:-right-1 tw:-top-1 tw:flex tw:size-5 tw:items-center tw:justify-center tw:rounded-full tw:text-[10px] tw:tracking-normal" data-cls-light="tw:bg-primary tw:text-primary-foreground" data-cls-dark="tw:bg-label tw:text-night">{$cart.products_count}</span>
      {/if}
    </a>
  </div>
</div>
