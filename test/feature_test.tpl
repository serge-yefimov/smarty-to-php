
{* If there is a Facebook app, set the app_id and admins, along with
   whatever else is passed *}
{if $fbSettings|default:false}
   {foreach from=$fbSettings item=value key=key}
      <meta property="fb:{$key}" content="{$value|escape:'html'}" /> 
   {/foreach}
{/if}

{if $static->call('ServerConstants', 'useCustomCSS') && !$onManage|default:false}
   {if $static->call('ServerConstants', 'getValue', 'CUSTOM_CSS_SERVED_FROM_S3')}
      <link rel="stylesheet" type="text/css" href="{BURI customCSS=''}" />
   {else}
      <style type="text/css">
         {$static->call('ServerConstants', 'getSetting', 'appearance-css')}
      </style>
   {/if}
{/if}

{literal}
{/literal}

{foreach from=$top item=template}
   {include file=$template}
{/foreach}
