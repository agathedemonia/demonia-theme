{**
 * Pied de page Démonia, repris de la maquette Lovable (site-footer.tsx, reassurance-band.tsx).
 * Données réelles, modifiables dans le back-office :
 * - promesses : module « Réassurance » (blockreassurance) : titre, description, picto ;
 * - téléphone et e-mail : Paramètres de la boutique > Contact (ps_contactinfo) ;
 * - réseaux : module « Suivez-nous » (ps_socialfollow) ;
 * - « Le site » : blocs ps_linklist accrochés à displayFooter ;
 * - liens légaux : blocs ps_linklist accrochés à displayFooterAfter.
 * Les autres modules accrochés aux mêmes hooks restent affichés (paramètre excl).
 *}
<div class="dm-scope dm-footer">
  {block name='hook_footer_before'}
    {hook h='displayFooterBefore' excl='ps_emailsubscription,ps_socialfollow,blockreassurance'}
  {/block}

  <div class="tw:h-px tw:bg-primary/50"></div>

  {* Bande des promesses (pictos teintés par masque CSS) *}
  {widget_block name='blockreassurance'}
    {if $elements|count}
      <section class="tw:band-dark tw:bg-night" aria-label="{l s='Nos engagements' d='Shop.Theme.Global'}">
        <div class="tw:mx-auto tw:grid tw:max-w-7xl tw:grid-cols-2 tw:gap-x-5 tw:gap-y-8 tw:px-4 tw:pb-16 tw:pt-16 tw:md:grid-cols-4 tw:md:px-8 tw:md:pb-20 tw:md:pt-20">
          {foreach from=$elements item=dmPromise}
            <div class="tw:flex tw:min-w-0 tw:items-center tw:gap-3">
              {if $dmPromise.image}
                <span aria-hidden="true" class="tw:h-10 tw:w-11 tw:shrink-0 tw:bg-label tw:mask-contain"
                  style="-webkit-mask-image:url('{$dmPromise.image}');mask-image:url('{$dmPromise.image}')"></span>
              {/if}
              <div>
                <p class="tw:text-sm tw:font-semibold">{$dmPromise.title}</p>
                {if $dmPromise.description}<p class="tw:text-xs tw:leading-relaxed tw:text-muted-foreground">{$dmPromise.description}</p>{/if}
              </div>
            </div>
          {/foreach}
        </div>
      </section>
    {/if}
  {/widget_block}

  <footer class="tw:band-dark tw:bg-night">
    <div class="tw:mx-auto tw:grid tw:max-w-7xl tw:gap-12 tw:px-4 tw:py-16 tw:text-center tw:md:grid-cols-2 tw:md:px-8 tw:md:py-20 tw:md:text-left">
      <div>
        {widget_block name='ps_contactinfo'}
          <p class="tw:font-display tw:text-2xl">{l s='Contactez-nous' d='Shop.Theme.Global'}</p>
          {if $contact_infos.phone}
            <p class="tw:mt-3 tw:text-sm tw:text-muted-foreground">
              {l s='Lun–ven, 9h–19h' d='Shop.Theme.Global'} ·
              <a href="tel:{$contact_infos.phone|regex_replace:'/[^0-9+]/':''}" class="tw:hover:text-label">{$contact_infos.phone}</a>
            </p>
          {/if}
          {if $contact_infos.email && $display_email}
            <a href="mailto:{$contact_infos.email}" class="tw:mt-5 tw:inline-flex tw:items-center tw:gap-2 tw:font-cta tw:text-xs tw:font-medium tw:uppercase tw:tracking-[0.18em] tw:text-label tw:underline-offset-[6px] tw:decoration-1 tw:transition-colors tw:hover:underline">
              {dmIcon icon='mail' class='tw:size-4'} {l s='Envoyer un mail' d='Shop.Theme.Global'}
            </a>
          {/if}
        {/widget_block}

        {widget_block name='ps_socialfollow'}
          {if $social_links|count}
            <p class="tw:mt-8 tw:font-display tw:text-2xl">{l s='Restons connectés !' d='Shop.Theme.Global'}</p>
            <div class="tw:mt-6 tw:flex tw:justify-center tw:gap-3 tw:md:justify-start">
              {foreach from=$social_links item=dmSocial}
                <a href="{$dmSocial.url}" target="_blank" rel="noopener noreferrer" aria-label="{$dmSocial.label}"
                  class="tw:grid tw:size-12 tw:place-items-center tw:border tw:border-primary/60 tw:bg-primary tw:text-primary-foreground tw:hover:bg-primary/85">
                  {if $dmSocial.class == 'facebook' || $dmSocial.class == 'instagram'}
                    {dmIcon icon=$dmSocial.class class='tw:size-5'}
                  {else}
                    <span class="tw:font-display tw:text-2xl" aria-hidden="true">{$dmSocial.label|truncate:1:''}</span>
                  {/if}
                </a>
              {/foreach}
            </div>
          {/if}
        {/widget_block}
      </div>

      <div class="tw:flex tw:flex-col tw:gap-12">
      {widget_block name='ps_linklist' hook='displayFooter'}
        {foreach from=$linkBlocks item=dmBlock}
          <nav aria-label="{$dmBlock.title}">
            <p class="tw:font-display tw:text-2xl">{$dmBlock.title}</p>
            <ul class="tw:mt-6 tw:grid tw:grid-cols-2 tw:gap-x-6 tw:gap-y-3 tw:text-sm tw:text-muted-foreground">
              {foreach from=$dmBlock.links item=dmLink}
                <li><a href="{$dmLink.url}" class="tw:hover:text-label">{$dmLink.title}</a></li>
              {/foreach}
            </ul>
          </nav>
        {/foreach}
      {/widget_block}
      </div>
    </div>

    <div class="tw:mx-auto tw:max-w-7xl tw:px-4 tw:pb-10 tw:text-center tw:md:px-8">
      <img src="{$urls.theme_assets}img/demonia-logo.svg" alt="{$shop.name}" width="202" height="43" class="tw:mx-auto tw:h-auto tw:w-40">
      <p class="tw:mt-3 tw:font-cta tw:text-xs tw:uppercase tw:tracking-[0.18em] tw:text-muted-foreground">{l s='Votre boutique fetish préférée' d='Shop.Theme.Global'}</p>
    </div>

    {widget_block name='ps_linklist' hook='displayFooterAfter'}
      {if $linkBlocks|count}
        <nav aria-label="{l s='Informations légales' d='Shop.Theme.Global'}" class="tw:border-t tw:border-border">
          <ul class="tw:mx-auto tw:flex tw:max-w-7xl tw:flex-wrap tw:justify-center tw:gap-x-5 tw:gap-y-2 tw:px-4 tw:py-6 tw:text-xs tw:text-muted-foreground tw:md:px-8">
            {foreach from=$linkBlocks item=dmBlock}
              {foreach from=$dmBlock.links item=dmLink}
                <li><a href="{$dmLink.url}" class="tw:hover:text-label">{$dmLink.title}</a></li>
              {/foreach}
            {/foreach}
          </ul>
        </nav>
      {/if}
    {/widget_block}

    {block name='copyright_link'}
      <p class="tw:border-t tw:border-border tw:py-4 tw:text-center tw:text-xs tw:text-muted-foreground">
        © {'Y'|date} {$shop.name} · {l s='Site réservé aux personnes majeures' d='Shop.Theme.Global'}
      </p>
    {/block}

    {block name='hook_footer'}
      {hook h='displayFooter' excl='ps_linklist,ps_customeraccountlinks,ps_contactinfo,blockwishlist'}
    {/block}
    {block name='hook_footer_after'}
      {hook h='displayFooterAfter' excl='blockreassurance,ps_linklist'}
    {/block}
  </footer>
</div>
