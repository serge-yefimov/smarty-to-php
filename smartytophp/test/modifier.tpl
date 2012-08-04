{$blurb->text|truncate:80:"..."} 
{$ad->title|truncate:60|escape}
{$blurb->title|truncate:28:"..."}
{$result->mini|regex_replace:"/^http:/i":"https:"}
{$username|regex_replace:"/ .*/":""|truncate:12:"..."}
{$info.date|local_date|regex_replace:"/(.*) @ (.*)/":"\$1<br />\$2"}
<td>{$item->action|regex_replace:"/_/":" "|lower|capitalize}
{$item|lower}
{$item|lower|capitalize}
{$item|escape:'html'}
<span class="blurbImageStatNum">{$bData.stats.topics.total|nice_number}</span>
