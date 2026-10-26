{**
 * Icônes Démonia : géométrie Lucide 0.575 (celle de la maquette Lovable) et
 * silhouettes pleines de l'en-tête (cœur, sac). Usage : {dmIcon icon='search' class='tw:size-4'}
 *}
{function name=dmIcon icon='' class='tw:size-4'}
  {if $icon == 'heart-solid'}
    <svg viewBox="0 0 16 16" fill="currentColor" aria-hidden="true" class="{$class}"><path d="M8 14.6C2.4 10.6.4 7.7.4 5.3.4 3 2.2 1.2 4.5 1.2c1.5 0 2.8.8 3.5 2 .7-1.2 2-2 3.5-2 2.3 0 4.1 1.8 4.1 4.1 0 2.4-2 5.3-7.6 9.3z"/></svg>
  {elseif $icon == 'bag-solid'}
    <svg viewBox="0 0 16 16" fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" aria-hidden="true" class="{$class}"><path d="M5.8 5.5V4.2a2.2 2.2 0 0 1 4.4 0v1.3h2.3a1.8 1.8 0 0 1 1.8 1.8v6.4a1.8 1.8 0 0 1-1.8 1.8H3.5a1.8 1.8 0 0 1-1.8-1.8V7.3a1.8 1.8 0 0 1 1.8-1.8h2.3Z"/><path d="M7 5.5V4.3a1 1 0 0 1 2 0v1.2H7Z"/></svg>
  {else}
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" class="{$class}">
      {if $icon == 'search'}<path d="m21 21-4.34-4.34"/><circle cx="11" cy="11" r="8"/>
      {elseif $icon == 'chevron-down'}<path d="m6 9 6 6 6-6"/>
      {elseif $icon == 'chevron-right'}<path d="m9 18 6-6-6-6"/>
      {elseif $icon == 'chevron-left'}<path d="m15 18-6-6 6-6"/>
      {elseif $icon == 'arrow-right'}<path d="M5 12h14"/><path d="m12 5 7 7-7 7"/>
      {elseif $icon == 'menu'}<path d="M4 5h16"/><path d="M4 12h16"/><path d="M4 19h16"/>
      {elseif $icon == 'x'}<path d="M18 6 6 18"/><path d="m6 6 12 12"/>
      {elseif $icon == 'mail'}<path d="m22 7-8.991 5.727a2 2 0 0 1-2.009 0L2 7"/><rect x="2" y="4" width="20" height="16" rx="2"/>
      {elseif $icon == 'facebook'}<path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/>
      {elseif $icon == 'instagram'}<rect width="20" height="20" x="2" y="2" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" x2="17.51" y1="6.5" y2="6.5"/>
      {/if}
    </svg>
  {/if}
{/function}
