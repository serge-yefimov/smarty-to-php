{assign var=tag value=Row/yourboat.png}
{assign var=sizeClass value=largeImageLinkDiv}
{assign var=tip value=$aConf->getTip()}
{assign var='tag' value=$aConf->getTag('normal')}
{assign var='search' value=$aConf->search}
{assign var="which" value=$static->call('SiteSpecific', 'which')} 
{assign var="socialButtonsEnabled" value=$static->call('ServerConstants', 'getSetting', 'social-buttons-enabled')}
{assign var="siteTitle" value=$static->call('ServerConstants', 'getSetting', 'site-title')|escape}
{assign var='search' value=$aConf->search}
{assign var=creating value=$creating|default:false}
{assign var=simplePageLayout value=false}
{assign var="imageHeight" value="225"}
{assign var=firstDiv value=true}
{assign var="data" value=$newAugs.slideshow_banner->getData()}
{assign var=cellStyleClear value="clear:both;float:left;width:112px;margin:10px 10px 0px 10px;text-align:center"}
{assign var=groupDate value=$snapshot->date}
{assign var=date value=$smarty.now}
{assign var='adText' value=$static->call('GuideWikiLib', 'fetchRemoteContent', 'http://makezine.com/facebook/weekendprojects/head.csp')}
