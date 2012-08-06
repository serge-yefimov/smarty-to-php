{foreach from=$data.modes key=modeId item=modeData name=slideshowModes}
   <li class="muted"><a 
    href="{GURI viewAnswersTag=$questionTag}" 
    class="muted">{$questionTag|wordbreak:15}</a></li>
{foreachelse}
{/foreach}

{foreach from=$question->separatedTags item=questionTag}
   <li class="muted"><a 
    href="{GURI viewAnswersTag=$questionTag}" 
    class="muted">{$questionTag|wordbreak:15}</a></li>
{foreachelse}
   <li style="display:none">&nbsp;</li> {* Placeholder so that <ul> does't break *}
{/foreach}

{*
   <div id="wikiTitleTip">
      <p>foo</p>
   </div>
*}

