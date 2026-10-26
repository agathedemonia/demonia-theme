{**
 * En-tête Démonia, reprise de la maquette Lovable (site-header.tsx, mega-menu.tsx,
 * mobile-nav.tsx). Données réelles : menu = ps_mainmenu, pratiques = bloc ps_linklist
 * accroché à displayNavFullWidth, recherche = ps_searchbar, panier = ps_shoppingcart.
 *
 * États (gérés par assets/js/demonia.js) :
 * - haut de page / remontée : barre beige, menu et bandeau des pratiques visibles ;
 * - descente : barre noire (classe header-scrolled), menu et pratiques repliés ;
 * - mobile (< 768 px) : barre noire en permanence (header-mobile-dark).
 * Les attributs data-cls-light / data-cls-dark portent les classes de chaque état.
 *}
{block name='header_banner'}
  <div class="header-banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}{/block}

{block name='header_top'}
<header id="dm-header" data-dm-header data-scrolled="false"
  class="dm-scope tw:sticky tw:top-0 tw:z-30 tw:text-foreground tw:backdrop-blur tw:shadow-velvet tw:transition-colors tw:duration-300"
  data-cls-light="header-mobile-dark tw:bg-secondary/95" data-cls-dark="header-scrolled">
  <div class="tw:mx-auto tw:flex tw:max-w-7xl tw:items-center tw:gap-4 tw:px-4 tw:py-4 tw:md:px-8">

    {* Bouton du menu mobile *}
    <button type="button" data-dm-drawer-open aria-controls="dm-drawer" aria-expanded="false" aria-label="{l s='Ouvrir le menu' d='Shop.Theme.Global'}"
      class="tw:-ml-2 tw:grid tw:size-10 tw:shrink-0 tw:place-items-center tw:md:hidden">
      {dmIcon icon='menu' class='tw:size-6'}
    </button>

    {* Logo (fichier d'origine, teinté par masque : suit la couleur du texte) *}
    <a href="{$urls.pages.index}" aria-label="{$shop.name}, {l s='accueil' d='Shop.Theme.Global'}" class="tw:shrink-0 tw:md:mr-auto">
      <span role="img" aria-label="{$shop.name}" class="tw:block tw:aspect-[202/43] tw:bg-current tw:mask-contain tw:w-32 tw:md:w-48"
        style="-webkit-mask-image:url('{$urls.theme_assets}img/demonia-logo.svg');mask-image:url('{$urls.theme_assets}img/demonia-logo.svg')"></span>
    </a>

    {* Recherche (ps_searchbar, gabarit surchargé dans modules/ps_searchbar) *}
    {widget name='ps_searchbar'}

    <nav class="tw:ml-auto tw:flex tw:gap-0 tw:md:gap-4" aria-label="{l s='Mon compte et panier' d='Shop.Theme.Global'}">
      {assign var='dmIconBtn' value='tw:relative tw:inline-flex tw:items-center tw:justify-center tw:transition-colors tw:hover:text-label tw:size-10'}
      <a href="{$urls.pages.my_account}" class="{$dmIconBtn}" rel="nofollow"
        aria-label="{if $customer.is_logged}{l s='Mon compte' d='Shop.Theme.Global'}{else}{l s='Compte' d='Shop.Theme.Global'}{/if}">
        <span class="tw:block tw:aspect-[104/68] tw:bg-current tw:mask-contain tw:size-10" aria-hidden="true"
          style="-webkit-mask-image:url('{$urls.theme_assets}img/pictos/lapin-seul.png');mask-image:url('{$urls.theme_assets}img/pictos/lapin-seul.png')"></span>
      </a>
      <a href="{url entity='module' name='blockwishlist' controller='lists'}" class="{$dmIconBtn}" rel="nofollow" aria-label="{l s='Favoris' d='Shop.Theme.Global'}">
        {dmIcon icon='heart-solid' class='tw:size-7'}
      </a>
      {widget name='ps_shoppingcart'}
    </nav>
  </div>

  {* ===== Ordinateur : menu principal beige + grand menu déroulant ===== *}
  <div class="tw:relative">
    <div class="tw:relative tw:max-md:hidden" data-dm-mega-zone>
      <div data-dm-collapsible class="tw:overflow-hidden tw:transition-[max-height] tw:duration-300 tw:max-h-16">
        {widget_block name='ps_mainmenu'}
          <nav aria-label="{l s='Menu principal' d='Shop.Theme.Global'}"
            class="tw:mx-auto tw:hidden tw:max-w-7xl tw:flex-row tw:items-center tw:gap-x-5 tw:px-8 tw:py-2 tw:font-cta tw:text-sm tw:font-medium tw:text-label tw:md:flex">
            {foreach from=$children item=node}
              {if $node.children|count}
                <div data-dm-mega-trigger="dm-mega-{$node.page_identifier|escape:'html'}" class="tw:flex tw:items-center tw:gap-1 tw:whitespace-nowrap tw:transition-colors tw:hover:text-label-deep">
                  <a href="{$node.url}" data-dm-focusable>{$node.label}</a>
                  <button type="button" data-dm-focusable aria-label="{l s='Afficher %s' sprintf=[$node.label] d='Shop.Theme.Global'}" aria-expanded="false" aria-controls="dm-mega-{$node.page_identifier|escape:'html'}" class="tw:grid tw:size-8 tw:place-items-center">
                    {dmIcon icon='chevron-down' class='tw:size-4 tw:transition-transform'}
                  </button>
                </div>
              {else}
                <a href="{$node.url}" data-dm-focusable data-dm-mega-close class="tw:whitespace-nowrap tw:transition-colors tw:hover:text-label-deep">{$node.label}</a>
              {/if}
            {/foreach}
          </nav>
        {/widget_block}
      </div>

      {widget_block name='ps_mainmenu'}
        {foreach from=$children item=node}
          {if $node.children|count}
            {* Colonnes : une par sous-rubrique qui a ses propres sous-rubriques, sinon une seule liste *}
            {assign var='dmHasGrandChildren' value=false}
            {foreach from=$node.children item=child}{if $child.children|count}{assign var='dmHasGrandChildren' value=true}{/if}{/foreach}
            <div id="dm-mega-{$node.page_identifier|escape:'html'}" hidden data-dm-mega
              class="tw:max-md:hidden tw:border-t tw:border-border tw:md:absolute tw:md:inset-x-0 tw:md:top-full tw:md:z-40 tw:md:shadow-velvet"
              data-cls-light="tw:bg-card" data-cls-dark="tw:bg-night">
              <div class="tw:mx-auto tw:grid tw:max-w-7xl tw:gap-10 tw:px-8 tw:py-10 tw:md:grid-cols-4">
                {if $dmHasGrandChildren}
                  {foreach from=$node.children item=child}
                    <div class="tw:flex tw:flex-col">
                      <p class="tw:mb-5 tw:font-cta tw:text-xs tw:uppercase tw:tracking-[0.18em] tw:text-muted-foreground"><a href="{$child.url}" class="tw:hover:text-label">{$child.label}</a></p>
                      <ul class="tw:space-y-3">
                        {foreach from=$child.children item=leaf}
                          <li><a href="{$leaf.url}" class="tw:hover:text-label">{$leaf.label}</a></li>
                        {/foreach}
                      </ul>
                    </div>
                  {/foreach}
                {else}
                  <div class="tw:flex tw:flex-col">
                    <p class="tw:mb-5 tw:font-cta tw:text-xs tw:uppercase tw:tracking-[0.18em] tw:text-muted-foreground">{$node.label}</p>
                    <ul class="tw:space-y-3">
                      {foreach from=$node.children item=child}
                        <li><a href="{$child.url}" class="tw:hover:text-label">{$child.label}</a></li>
                      {/foreach}
                    </ul>
                  </div>
                {/if}
                <div class="tw:flex tw:flex-col">
                  <p class="tw:mb-5 tw:font-cta tw:text-xs tw:uppercase tw:tracking-[0.18em] tw:text-muted-foreground">{l s='Sélections' d='Shop.Theme.Global'}</p>
                  <ul class="tw:space-y-3">
                    <li><a href="{$urls.pages.new_products}" class="tw:font-semibold tw:text-label tw:hover:opacity-80">{l s='Nouveautés' d='Shop.Theme.Global'}</a></li>
                    <li><a href="{$urls.pages.prices_drop}" class="tw:font-semibold tw:text-label tw:hover:opacity-80">{l s='En promotion' d='Shop.Theme.Global'}</a></li>
                    <li><a href="{$link->getPageLink('best-sales')}" class="tw:font-semibold tw:text-label tw:hover:opacity-80">{l s='Meilleures ventes' d='Shop.Theme.Global'}</a></li>
                  </ul>
                  <a href="{$node.url}" class="tw:mt-auto tw:inline-flex tw:items-center tw:gap-2 tw:pt-8 tw:font-cta tw:text-xs tw:font-medium tw:uppercase tw:tracking-[0.18em] tw:text-label tw:underline tw:decoration-primary/50 tw:decoration-1 tw:underline-offset-[6px] tw:transition-colors tw:hover:decoration-2 tw:hover:decoration-label">
                    {l s='Tout voir : %s' sprintf=[$node.label] d='Shop.Theme.Global'} {dmIcon icon='arrow-right' class='tw:size-4'}
                  </a>
                </div>
              </div>
            </div>
          {/if}
        {/foreach}
      {/widget_block}
    </div>

    {* Bandeau noir des pratiques : bloc de liens « ps_linklist » accroché à displayNavFullWidth *}
    {widget_block name='ps_linklist' hook='displayNavFullWidth'}
      {foreach from=$linkBlocks item=dmBlock}
        <nav aria-label="{$dmBlock.title}" data-dm-collapsible
          class="tw:hidden tw:overflow-hidden tw:bg-night tw:text-xs tw:text-primary-foreground tw:transition-[max-height] tw:duration-300 tw:md:block tw:max-h-16">
          <div class="tw:mx-auto tw:flex tw:max-w-7xl tw:flex-row tw:items-center tw:gap-x-10 tw:px-8 tw:py-4">
            {foreach from=$dmBlock.links item=dmLink}
              <a href="{$dmLink.url}" data-dm-focusable class="tw:whitespace-nowrap tw:underline-offset-4 tw:transition-opacity tw:hover:underline">{$dmLink.title}</a>
            {/foreach}
          </div>
        </nav>
      {/foreach}
    {/widget_block}
  </div>
</header>

{* ===== Mobile : tiroir du menu (onglets Produits / Pratiques, accordéon) ===== *}
<div id="dm-drawer" data-dm-drawer hidden class="dm-scope tw:fixed tw:inset-0 tw:z-50 tw:md:hidden">
  <div data-dm-drawer-close class="tw:absolute tw:inset-0 tw:bg-black/80"></div>
  <div role="dialog" aria-modal="true" tabindex="-1" data-dm-drawer-panel aria-label="{l s='Menu' d='Shop.Theme.Global'}"
    class="tw:outline-none tw:absolute tw:inset-y-0 tw:left-0 tw:w-[80%] tw:overflow-y-auto tw:bg-background tw:text-night tw:shadow-lg">
    <div class="tw:sticky tw:top-0 tw:z-10 tw:bg-background">
      <div class="tw:flex tw:items-stretch tw:border-b tw:border-night/15" role="tablist">
        <button type="button" role="tab" aria-selected="true" data-dm-tab="produits" class="tw:flex-1 tw:border-b-2 tw:py-4 tw:font-cta tw:text-sm tw:font-bold tw:tracking-[0.1em] tw:border-label tw:text-label">{l s='Produits' d='Shop.Theme.Global'}</button>
        <button type="button" role="tab" aria-selected="false" data-dm-tab="pratiques" class="tw:flex-1 tw:border-b-2 tw:py-4 tw:font-cta tw:text-sm tw:font-bold tw:tracking-[0.1em] tw:border-transparent tw:text-night/50">{l s='Pratiques' d='Shop.Theme.Global'}</button>
        <button type="button" data-dm-drawer-close aria-label="{l s='Fermer le menu' d='Shop.Theme.Global'}" class="tw:grid tw:w-14 tw:place-items-center tw:border-l tw:border-night/15">{dmIcon icon='x' class='tw:size-5'}</button>
      </div>
    </div>

    {assign var='dmRow' value='tw:flex tw:min-h-14 tw:w-full tw:items-center tw:justify-between tw:border-b tw:border-night/10 tw:px-4 tw:text-left tw:font-cta tw:text-sm tw:font-semibold tw:tracking-[0.06em] tw:text-night'}
    <div data-dm-panel="produits" class="tw:pb-4">
      {widget_block name='ps_mainmenu'}
        {foreach from=$children item=node name=dmNodes}
          {if $smarty.foreach.dmNodes.first}
            <a href="{$node.url}" class="tw:flex tw:min-h-16 tw:w-full tw:items-center tw:justify-between tw:bg-primary tw:px-4 tw:font-cta tw:text-sm tw:font-bold tw:tracking-[0.08em] tw:text-primary-foreground">
              {$node.label} {dmIcon icon='chevron-right' class='tw:size-5 tw:text-primary-foreground/80'}
            </a>
            {foreach from=$node.children item=child}
              <div class="tw:border-b tw:border-night/10">
                {if $child.children|count}
                  <button type="button" aria-expanded="false" data-dm-accordion class="tw:flex tw:min-h-14 tw:w-full tw:items-center tw:justify-between tw:px-4 tw:text-left tw:font-cta tw:text-sm tw:font-semibold tw:tracking-[0.06em] tw:text-night">
                    {$child.label} {dmIcon icon='chevron-down' class='tw:size-4 tw:shrink-0 tw:text-foreground/40 tw:transition-transform tw:duration-200'}
                  </button>
                  <div hidden class="tw:border-t tw:border-night/10 tw:bg-night/[0.03] tw:pb-2">
                    <a href="{$child.url}" class="tw:flex tw:min-h-12 tw:w-full tw:items-center tw:px-8 tw:text-left tw:font-cta tw:text-sm tw:font-semibold tw:tracking-[0.06em] tw:text-label">{l s='Tout voir' d='Shop.Theme.Global'}</a>
                    {foreach from=$child.children item=leaf}
                      <a href="{$leaf.url}" class="tw:flex tw:min-h-12 tw:w-full tw:items-center tw:px-8 tw:text-left tw:font-cta tw:text-sm tw:font-normal tw:tracking-[0.04em] tw:text-night/80">{$leaf.label}</a>
                    {/foreach}
                  </div>
                {else}
                  <a href="{$child.url}" class="tw:flex tw:min-h-14 tw:w-full tw:items-center tw:justify-between tw:px-4 tw:text-left tw:font-cta tw:text-sm tw:font-semibold tw:tracking-[0.06em] tw:text-night">{$child.label} {dmIcon icon='chevron-right' class='tw:size-4 tw:shrink-0 tw:text-foreground/40'}</a>
                {/if}
              </div>
            {/foreach}
            <a href="{$urls.pages.new_products}" class="{$dmRow} tw:text-label">{l s='Nouveautés' d='Shop.Theme.Global'} {dmIcon icon='chevron-right' class='tw:size-4 tw:shrink-0 tw:text-foreground/40'}</a>
            <a href="{$urls.pages.prices_drop}" class="{$dmRow} tw:text-label">{l s='En promotion' d='Shop.Theme.Global'} {dmIcon icon='chevron-right' class='tw:size-4 tw:shrink-0 tw:text-foreground/40'}</a>
            <a href="{$link->getPageLink('best-sales')}" class="{$dmRow} tw:text-label">{l s='Meilleures ventes' d='Shop.Theme.Global'} {dmIcon icon='chevron-right' class='tw:size-4 tw:shrink-0 tw:text-foreground/40'}</a>
          {else}
            <a href="{$node.url}" class="{$dmRow}">{$node.label} {dmIcon icon='chevron-right' class='tw:size-4 tw:shrink-0 tw:text-foreground/40'}</a>
          {/if}
        {/foreach}
      {/widget_block}
    </div>

    <div data-dm-panel="pratiques" hidden class="tw:pb-4">
      {widget_block name='ps_linklist' hook='displayNavFullWidth'}
        {foreach from=$linkBlocks item=dmBlock}
          {foreach from=$dmBlock.links item=dmLink}
            <a href="{$dmLink.url}" class="{$dmRow}">{$dmLink.title} {dmIcon icon='chevron-right' class='tw:size-4 tw:shrink-0 tw:text-foreground/40'}</a>
          {/foreach}
        {/foreach}
      {/widget_block}
    </div>
  </div>
</div>

{* Recherche mobile discrète, fixée en bas de l'écran (hors de l'en-tête : son
   backdrop-blur créerait un repère qui bloque position: fixed). *}
<form method="get" action="{$urls.pages.search}" role="search"
  class="dm-scope tw:fixed tw:bottom-0 tw:left-0 tw:right-0 tw:z-20 tw:mx-3 tw:mb-3 tw:flex tw:items-center tw:gap-2 tw:border tw:border-label/40 tw:bg-background/95 tw:px-3 tw:py-1.5 tw:backdrop-blur tw:md:hidden">
  <input type="hidden" name="controller" value="search">
  {dmIcon icon='search' class='tw:size-3.5 tw:shrink-0 tw:text-label'}
  <input type="search" name="s" placeholder="{l s='Rechercher' d='Shop.Theme.Global'}" aria-label="{l s='Rechercher' d='Shop.Theme.Global'}"
    class="tw:w-full tw:bg-transparent tw:text-xs tw:outline-none tw:placeholder:text-label/60">
</form>
{* displayNavFullWidth n'est pas rendu tel quel : ses liens ps_linklist alimentent le bandeau des pratiques. *}
{/block}
