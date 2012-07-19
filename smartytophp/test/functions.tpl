{* Functions *}
{*{config_load file="colors.conf"}*}

{include file="header.tpl"}
{insert file="banner_ads.tpl" title="My Site"}

{if $logged_in}
   Welcome, <span style="color:{#fontColor#}">{$name}!</span>
{else}
   hi, {$name}
{/if}

{include file="footer.tpl"}

{* Attributes *}
{include file="header.tpl"}

{include file="header.tpl" nocache}  // is equivalent to nocache=true

{include file="header.tpl" attrib_name="attrib value"}

{include file=$includeFile}

{include file=#includeFile# title="My Title"}

{assign var=foo value={counter}}  // plugin result

{assign var=foo value=substr($bar,2,5)}  // PHP function result

{assign var=foo value=$bar|strlen}  // using modifier

{assign var=foo value=$buh+$bar|strlen}  // more complex expression

{html_select_date display_days=true}

{mailto address="smarty@example.com"}

<select name="company_id">
     {html_options options=$companies selected=$company_id}
  </select>

{* Syntax Quotes *}

{** Examples **}
{* will replace $tpl_name with value *}
{include file="subdir/$tpl_name.tpl"}

{* does NOT replace $tpl_name *}
{include file='subdir/$tpl_name.tpl'} // vars require double quotes!

{* must have backticks as it contains a dot "." *}
{cycle values="one,two,`$smarty.config.myval`"}

{* must have backticks as it contains a dot "." *}
{include file="`$module.contact`.tpl"}

{* can use variable with dot syntax *}
{include file="`$module.$view`.tpl"}



