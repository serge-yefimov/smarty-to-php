
<title>{$title|escape:'html'}</title>
<meta name="description" content="{$metaDescription|escape:'html'}" />
<meta name="title" content="{$title|escape:'html'}" />
<meta name="keywords" content="{$metaKeywords|escape:'html'}" />

{if $fbSettings|default:false}
   {foreach from=$fbSettings item=value key=key}
      <meta property="fb:{$key}" content="{$value|escape:'html'}" /> 
   {/foreach}
{/if}
