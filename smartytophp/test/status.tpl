{if $conflict}
{status type="bad" id="conflictMessage"}
{t 1='<strong>' 2='<a href="#currentPostView">' 3='</a>' 4='</strong>'}%1Sorry,
another
user saved a %2newer version%3 of this post%4 while you were editing it.{/t}
{t}Your changes have not been saved.{/t} {t}If you're sure you want to make
this
change, click the Submit button again to overwrite the newer version of this
post.{/t}
{/status}
{/if}

{include file="statuses.tpl"}
