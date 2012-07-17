{assign var="which" value=$static->call('SiteSpecific', 'which')} 
{assign var="socialButtonsEnabled" value=$static->call('ServerConstants', 'getSetting', 'social-buttons-enabled')}

{if $socialButtonsEnabled}
   {if $which == 'make'}
      <script type='text/javascript'>
      {literal}
         var addthis_config = { 
            pubid: "ra-4f9ec68233e19b4b", 
            "data_track_addressbar":true 
         };
      {/literal}
      </script>
   {else}
      <script type='text/javascript'>
      {literal}
         var addthis_config = { 
            pubid: "ra-4f3ec37d0f5c020f", 
            data_track_addressbar: false
         };
      {/literal}
      </script>
   {/if}

   <!-- AddThis Button BEGIN -->
   <div class="socialMediaLinks {if $pinterest|default:false}large{/if} addthis_toolbox addthis_default_style addthis_seperator {if $where != 'guide'|default:false} cart-horizontal {/if}">
      <a class="addthis_button_tweet" tw:count="none"></a>
      <a class="addthis_button_google_plusone" g:plusone:size="medium" g:plusone:count="false"></a>
      {* The 'send' button doesn't load / work on cart pages, most likely
         because we don't have open graph tags set on Cart pages. So we use the 'like' button instead *}
      {if $where != 'guide'|default:false}
         <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
      {else}
         <a class="addthis_button_facebook_send {if !$pinterest|default:true}lastChild{/if}"></a>
      {/if}

      {if $pinterest|default:false}
      <a class="addthis_button_pinterest_pinit lastChild"
         pi:pinit:media="{$pinterest.image}"
         pi:pinit:layout="horizontal"
         count-layout="none"></a>
      {/if}
   </div>
   <!-- AddThis Button END -->
{/if}
