<!DOCTYPE html>

<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if lt IE 7 ]><html class="ie6" lang="en"><![endif]-->
<!--[if IE 7 ]><html class="ie7" lang="en"><![endif]-->
<!--[if IE 8 ]><html class="ie8" lang="en"><![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en" xmlns:fb="http://www.facebook.com/2008/fbml"><!--<![endif]-->
   <head{if $showSocial|default:false && $openGraph.prefix|default:false} prefix="{$openGraph.prefix}" {/if}>
      <title>{$title|escape:'html'}</title>

      {if $ie7mode|default:false}
         <meta http-equiv="X-UA-Compatible" content="IE=7" />
      {/if}

      <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
      <meta name="viewport" content="width=1029, maximum-scale=10.0" />
      <meta name="description" content="{$metaDescription|escape:'html'}" />
      <meta name="title" content="{$title|escape:'html'}" />
      <meta name="keywords" content="{$metaKeywords|escape:'html'}" />

      {* Dear Robots,
         Please don't slurp up anything if this flag is set.
         Sincerely, iFixit. *}
      {if $restrictRobots|default:false}
         <meta name="robots" content="noindex, nofollow, nosnippet, noarchive, noimageindex" />
      {else}
         <meta name="robots" content="index, follow" />
      {/if}

      {if $canonical|default:false}
      <link rel="canonical" href="{$canonical|escape}" />
      {/if}

      {* If there is a Facebook app, set the app_id and admins, along with
         whatever else is passed *}
      {if $fbSettings|default:false}
         {foreach from=$fbSettings item=value key=key}
            <meta property="fb:{$key}" content="{$value|escape:'html'}" /> 
         {/foreach}
      {/if}

      {* OpenGraph is facebook's way to parse pages. *}
      {if $openGraph|default:false}
         {foreach from=$openGraph item=value key=key}
           <meta property="og:{$key}" content="{$value|escape:'html'}" />
         {/foreach}
      {/if}

      {* Google Webmaster Verification *}
      <meta name="verify-v1" content="jw37yaG9O4vmztqkH8xsZEeQtGHqzC3GZXfwk5xUCeM=" />
      
      {* Favicon. *}
      <link rel="shortcut icon" type="image/vnd.microsoft.icon" href="{$favicon}" />
      <link rel="apple-touch-icon" href="{$touchIcon}" />
      
      {* For Facebook / Digg *}
      {if $image_src|default:false}
      <link rel="image_src" href="{$image_src}" />
      {/if}
      
      {* RSS and Atom feeds *}
      {foreach from=$feeds item=feed}
      <link rel="alternate" type="application/rss+xml" title="{$feed.title|escape}" href="{$feed.url}" />
      {/foreach}

      {* CSS *}

      {* For site-specific custom fonts *}
      {include file="Shared/font_includes.tpl"}

      {foreach from=$stylesheets item=stylesheet}
         <link rel="stylesheet" type="text/css" href="{GURI css=$stylesheet}" />
      {/foreach}

      {if $static->call('ServerConstants', 'useCustomCSS')}{/if}
      {if $static->call('ServerConstants', 'useCustomCSS') && !$onManage|default:false}
         {if $static->call('ServerConstants', 'getValue', 'CUSTOM_CSS_SERVED_FROM_S3')}
            <link rel="stylesheet" type="text/css" href="{BURI customCSS=''}" />
         {else}
            <style type="text/css">
               {$static->call('ServerConstants', 'getSetting', 'appearance-css')}
            </style>
         {/if}
      {/if}

      {* COOLIRIS *}
      {if isset($guideid) && isset($langid)}
         <link rel="coolirisfeed" href="{GURI viewGuideInCooliris=$guideid 
          langid=$langid}" type="application/rss+xml" title="Cooliris Gallery" 
          id="gallery" />
      {elseif isset($cooliris)}
         <link rel="coolirisfeed" href="{$cooliris}"
          type="application/rss+xml" title="Cooliris Gallery" 
          id="gallery" />
      {/if}

      {* oEmbed *}
      {if isset($guideid) && isset($langid)}
         <link rel="alternate" type="application/json+oembed" 
          href="{GURI oembed=$guideid}" title="iFixit Guide Embed" />
      {/if}

      {* Javascript App variables *}
      {include file="Shared/javascript_app_variables.tpl"}

      {include file="Shared/google_analytics.tpl"}
   </head>

   <body{if $bodyClasses} class="{$bodyClasses}"{/if}>
      <!-- ClickTale Top part -->
      <script type="text/javascript">
      var WRInitTime=(new Date()).getTime();
      </script>
      <!-- ClickTale end of Top part -->

      
      {if $showSocial|default:false}
         <!-- Facebook -->
         <div id="fb-root"></div>
         <script src='http://connect.facebook.net/en_US/all.js'></script>
         <script>
         {if $fbAppId|default:false}
            var fbAppId = {$fbAppId};
         {else}
            var fbAppId = '';
         {/if}
         {literal}
            FB.init({
               appId  : fbAppId, // App ID
               status : true,   // check login status 
               cookie : true,   // enable cookies to allow the server to access the session
               xfbml  : true,   // Parse XFBML
               oauth  : true
            });
         </script>
         {/literal}
      {/if}

      <div id="hiddenTimezone" style="display:none">
         <form action="">
            <div><input id="timezone" type="hidden" value="{$timezone}"/></div>
         </form>
      </div>

      {if !$simplePageLayout && isset($top) && !empty($top)}
      <div id="topContainer">
         {foreach from=$top item=template}
            {include file=$template}
         {/foreach}
      </div>
      {else}
      <div id="topContainer" style="display:none">
      </div>
      {/if}

      {if $csrf_fail}
      <div id="csrfFail">
         <p>{t}Your data did not transmit correctly. Please note your changes, log out, back in and try again.{/t}</p>
      </div>
      {/if}

      <div id="background">
         {if !$simplePageLayout}
            {if $static->call('ServerConstants', 'useCustomHeader') && !$onManage|default:false}
               {$static->call('ServerConstants', 'getSetting', 'appearance-header')}
            {else}
               {if $displayAds}
               <div class="adBlocks">
                  {$googleAdSenseCodes.leader|default:''}
                  {$googleAdSenseCodes.corner|default:''}
                  <div class="clearer"></div>
               </div>
               {/if}

               {include file="Shared/header.tpl"}
            {/if}
         {/if}

         <div id="main">
            {if $mainSideNav|default:false}
            {include file='Manage/sidebar_index.tpl'}
            {/if}

            {if isset($helpLink)}
               <a id="helptab" href="{$helpLink}" target="_blank">
                  <div class="helptabbg">
                     <span class="helptext">{t}Help{/t}</span>
                  </div>
                  <div class="tabshadow"></div>
               </a>

               {* Not sure if we'll use these yet.
               <a id="manageLink" href="#" class="helpSlider manageLink" target="_blank">
                  <span class="helpSliderIcon manage"></span>
                  <span class="helpSliderText">Manage</span>
                  <div class="group"></div>
               </a>
               <a id="addLink" href="#" class="helpSlider addLink" target="_blank">
                  <span class="helpSliderIcon add"></span>
                  <span class="helpSliderText">Add Guides</span>
                  <div class="group"></div>
               </a>
               *}
            {/if}

            <div id="mainBody">
               {if $static->call('ServerConstants', 'useCustomHeader') && !$onManage|default:false && !$simplePageLayout}
                  {include file="Shared/header.tpl"}
               {/if}

               <!-- MAIN BODY -->
               {if !$altBanner|default:false}
                  {* Gather all of the banner content into a capture buffer so
                  that we can check to see if there's actually anything to
                  display. Otherwise, empty templates (specifically in site
                  overrides) would default the usual empty($banner) check to add
                  the "empty" class. *}
                  {capture name="banner"}
                     {foreach from=$banner item=template}
                        {include file=$template}
                     {/foreach}
                  {/capture}
                  <div id="banner"{if $smarty.capture.banner|strip:"" eq ""} class="empty"{/if}>
                     {$smarty.capture.banner}
                  </div>
               {/if}

               {* $mainTop contains full-width content that goes in "mainBody",
               but which isn't a banner. *}
               {if count($mainTop)}
               <div id="bodyTop" class="fullWidth">
                  {foreach from=$mainTop item=template}
                     {include file=$template}
                  {/foreach}
               </div>
               {/if}

               {* Sidebar *}
               {if !isset($fullWidth) && count($sidebar)}
               <div id="sidebarFloat">
                  <div id="sidebar">
                     {foreach from=$sidebar item=template}
                        {include file=$template}
                     {/foreach}
                  </div>
               </div>
               {/if}

               {* Content *}
               <div id="contentFloat">
                  <div id="content">
                     {foreach from=$flash item="notice"}
                        <h2>{$notice.class}</h2>
                        {foreach from=$notice.message item="message"}
                           <p>{$message}</p>
                        {/foreach}
                     {/foreach}
                     {foreach from=$main item=template}
                        {include file=$template}
                     {/foreach}
                  </div>
               </div>
               <div class="clearer"></div>
            </div> <!-- /mainBody -->
            <div class="clearer"></div>
         </div> <!-- /main -->
      </div> <!-- /background -->
      {if !$hideFooter|default:false}
         {if $static->call('ServerConstants', 'useCustomFooter') && !$onManage|default:false}
            {$static->call('ServerConstants', 'getSetting', 'appearance-footer')}
         {/if}
         {include file="Shared/footer.tpl"}
      {/if}

      {* END OF VISIBLE CONTENT *}

      {* JS *}

      {* AJAX IO *}
      {if isset($ajaxio_js)}
      {$ajaxio_js}
      {/if}

      {* EXTERNAL JS *}
      {foreach from=$scripts item=script}
      <script type="text/javascript" src="{GURI js=$script}"></script>
      {/foreach}

      <!--[if IE 6]>
      {foreach from=$conditionalScripts item=script}
      {*{if strpos($script, 'ie6') !== false}
         <script type="text/javascript" src="{GURI js=$script}"></script>
         {/if}*}
      {/foreach}
      <![endif]-->

      <!--[if IE 7]>
      {foreach from=$conditionalScripts item=script}
      {*
      {if strpos($script, 'ie7') !== false}
         <script type="text/javascript" src="{GURI js=$script}"></script>
         {/if}*}
      {/foreach}
      <![endif]-->

      {* A place to put modal dialogs via FrameModules *}
      {if isset($modal) && !empty($modal)}
         {foreach from=$modal item=template}
            {include file=$template}
         {/foreach}
      {/if}

      {* A place to put stuff at the very end of the page, but still before
      superfluous stuff like analytics. *}
      {include file="bottom.tpl"}

      {* COOLIRIS NOTE: <link> is in <head> *}
      {if isset($guideid) && isset($langid) || isset($cooliris)}
         <script type="text/javascript" 
          src="/static/piclens/lite/piclens_optimized.js"></script>
      {/if}

      {* USER VOICE *}
      {*
      {if $activeHeaderIcon eq 'answers'}
         {literal}
         <script type="text/javascript">
         /* <![CDATA[ */
            var uservoiceJsHost = ("https:" == document.location.protocol) ? "https://uservoice.com" : "http://cdn.uservoice.com";
            document.write(unescape("%3Cscript src='" + uservoiceJsHost + "/javascripts/widgets/tab.js' type='text/javascript'%3E%3C/script%3E"));
         /* ]]> */
         </script>
         <script type="text/javascript">
         /* <![CDATA[ */
            UserVoice.Tab.show({ 
              key: 'ifixit',
              host: 'ifixit.uservoice.com', 
              forum: 'beta', 
              alignment: 'left', /* 'left', 'right' */
              background_color:'#3361ad', 
              text_color: 'white', /* 'white', 'black' */
              hover_color: '#f47d16',
              lang: 'en' /* 'en', 'de', 'nl', 'es', 'fr' */
            })
         /* ]]> */
         </script>
         {/literal}
      {/if}
      *}

      {* PAGE TIMER *}
      {if false && $static->call('ServerConstants', 'getValue', 'ON_LIVE_SITE') && !empty($time) && $profile}
      <div id="pageTimer" style="position:fixed;top:-1000px;left:-1000px;background-color:gray">
         <div style="background-color:white">
            {$time->getOutput()}
         </div>
      </div>
      {literal}
      <script type="text/javascript">
      /* <![CDATA[ */
         window.addEvent('load', function() {
            var pageTimer = $('pageTimer');
            var coords = pageTimer.getCoordinates();
            var left = -1 * (coords.width - 100);
            var top = -1 * (coords.height - 10);
            pageTimer.setStyles({left: left, top: top});
            pageTimer.addEvents({
               'mouseenter': function() {pageTimer.setStyles({left: 0, top: 0});},
               'mouseleave': function() {pageTimer.setStyles({left: left, top: top});}
            });
         });
      /* ]]> */
      </script>
      {/literal}
      {/if}

      {* QUERY LOG *}
      {if $showQueryLog|default:false}
         {include file="Shared/querylog.tpl"}
      {/if}

      {if isset($doClickTale) && $doClickTale}
         <!-- ClickTale Bottom part -->
         <div id="ClickTaleDiv" style="display: none;"></div>
         <script type='text/javascript'>
         document.write(unescape("%3Cscript%20src='"+
                  (document.location.protocol=='https:'?
                   'https://clicktale.pantherssl.com/':
                   'http://s.clicktale.net/')+
                  "WRc9.js'%20type='text/javascript'%3E%3C/script%3E"));
         </script>
         <script type="text/javascript">
         var ClickTaleSSL=1;
         if(typeof ClickTale=='function') ClickTale(21187,1,"www02");
         </script>
         <!-- ClickTale end of Bottom part -->
      {/if}

      {assign var="socialButtonsEnabled" value=$static->call('ServerConstants', 'getSetting', 'social-buttons-enabled')}
      {if $socialButtonsEnabled}
         {include file="Shared/social_includes.tpl" where="guide"}
      {/if}

   </body>
</html>
