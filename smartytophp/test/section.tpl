{section name=colLoop start=0 loop=$listDiv->cols}
   <ul class="contributeList">
      {foreach from=$listDiv->getColLinks($smarty.section.colLoop.index) key=name item=data}
         {if $name != 'viewMore'}
            <li><a href="{$data.url}">{$name}</a></li>
         {/if}
      {/foreach}
   </ul>
{/section}
