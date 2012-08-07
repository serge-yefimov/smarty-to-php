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

Testing
=======

Tests are located in smartytophp/test.  Each test consists of a `.tpl` and a
`.phtml` file and the contents of each `.tpl` file are fed to the parser and
the output is diffed against the `.phtml` file which is the expected output
from the input.  

Running the tests
=================

   ./runtests

Generating tests
================
To generate tests for a part of the smarty grammar, add whatever the the failing piece of code into a seperate file in
`./smartytophp/tests`.  For example `mv template_from_hell.tpl ~/path/to/smarty-to-php/smartytophp/tests`. 

Then run `./convert template_from_hell` which converts file, or will try to, and generates a broken `.phtml`.  But
that's ok. We can fix it. Just convert the rest by hand and start fiddling with
the grammar and tree walker (lexer(?) sort of?) till your tests pass. 
