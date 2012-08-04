<li>{strip}
{if !$static->call('ServerConstants', 'getSetting', 'answers-tag-only-navigation')}
      {if $question->device}
         <a class="muted" href="{GURI viewAnswersDevice=$question->device}"
          >{$question->device|wordbreak:15}</a>
      {else}
         <span>{t 1=$objectName.upperSingular}[No %1]{/t}</span>
      {/if}
   {/if}
   {if $static->call('ServerConstants', 'getSetting', 'feature-answers-is-discussion') && $question->is_discussion}
      <span>{t}Discussion Topic{/t}</span>
   {/if}
{/strip}</li>
