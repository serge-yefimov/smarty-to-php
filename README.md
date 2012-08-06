smarty-to-php
=============

Kill Smarty. 

First, log in to cominor and make sure everything is fetched and up-to-date.
Then check out the `smarty-to-php` branch which is where we will be working on
the conversion.

Begin the process with:
   
   git clone git@github.com:iFixit/smarty-to-php.git
   cd smart-to-php
   sudo python26 setup.py install

Example run: `python smartytophp/main.py --smarty-file=smartytophp/test/vars.tpl --phtml-file=vars.phtml`
