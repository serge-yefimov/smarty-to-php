{if $foo|default:false}
   {$red}
{elseif !$bar|default:true}
   {$green}
{/if}

{!$articleTitle|default:0}
{$articleTitle|default:0}
{$articleTitle|default:''}
{$articleTitle|default:'no title'}
{$myTitle|default:'no title'}
{$email|default:'No email address available'}
