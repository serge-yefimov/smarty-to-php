{$Name}
{$product.part_no} <b>{$product.description}</b>
{$Contacts[row].Phone}
<body bgcolor="{#bgcolor#}">

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

{$Contacts[0]}<br />
{$Contacts[1]}<br />
{* you can print arrays of arrays as well *}
{$Contacts[2][0]}<br />
{$Contacts[2][1]}<br />

name:  {$person->name}<br />
email: {$person->email}<br />


