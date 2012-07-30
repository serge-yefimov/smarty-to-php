{assign var="siteTitle"
 value=$static->call('ServerConstants', 'getSetting', 'site-title')|escape}
{assign var="topicNamePlural"
 value=$static->call('ServerConstants', 'getSetting', 'topic-name-plural')}

<h1>{t}Questions? Answers!{/t}</h1>

<div class="aboutGroup">
   <h2>{t 1=$siteTitle 2=&amp;}%1 Answers is free community Q%2A.{/t}</h2>
   <p>{t 1=&mdash;}We are a community of people helping each other with problems. Come hang out with us %1 you'll find a friendly, helpful bunch of people who care and want to help find solutions.{/t}</p>
</div>

<div class="aboutGroup">
   <h2>{t}We know stuff.{/t}</h2>
   <p>
      {t}We would love to help you with your questions. You can ask anything you like, as long as it's about this site.{/t}
      {t}When crafting your question, we suggest making it as detailed and specific as possible.{/t}
      {t}The better you describe your problem and the more research you do before you ask, the better the answer you're likely to receive.{/t}
   </p>
</div>

<div class="aboutGroup">
   <h2>{t}Share!{/t}</h2>
   <p>{t}When you answer a question:{/t}</p>
   <ul>
      <li>{t}You help someone.{/t}</li>
      <li>{t}You help our community's knowledege grow.{/t}</a></li>
      <li>{t}You share your knowledge with people all over the world.{/t}</li>
   </ul>
</div>

<div class="aboutGroup">
   <h2>{t}Community.{/t}</h2>
   <p>{t 1=<strong> 2=</strong>}We don't run Answers. You do. %1The community has complete control over the content on Answers%2. Answers is collaboratively managed by people just like you.{/t}</p>
   <p>{t}Community members ask questions, answer questions, select the best solutions, and prune out unnecessary commentary. With your help, we can start solving some of the world's problems.{/t}</p>
</div>

<div class="aboutGroup">
   <h2>{t}Never stop learning.{/t}</h2>
   <p>{t 1=<strong> 2=</strong>}%1All information here is collaboratively edited%2. If you ask an interesting question or write a useful answer, other people may come along and categorize it with tags or edit the text. That's OK! In fact, we encourage making posts better over time.{/t}</p>
   <p>{t 1="<a href=/Help/Answers>" 2=</a>}Our goal is to build a database of solutions that is useful for years to come. For more information on asking and answering questions, %1visit our Answers Help Page%2.{/t}</p>
</div>
