{$Name}
{$product.part_no} <b>{$product.description}</b>
{$Contacts[row].Phone}

Hello {$firstname} {$lastname}, glad to see you can make it.
<br />
{* this will not work as $variables are case sensitive *}
This weeks meeting is in {$meetingplace}.
{* this will work *}
This weeks meeting is in {$meetingPlace}.

{$Contacts.fax}<br />
{$Contacts.email}<br />
{* you can print arrays of arrays as well *}
{$Contacts.phone.home}<br />
{$Contacts.phone.cell}<br />
{$Contacts.phone->cell()}

{$Contacts.phone.cell.iphone|default:false}<br />
{$Contacts.phone.cell.iphone|escape:'html'}<br />

<input type="text" name="search" value="{$aConf->search|escape}" />
