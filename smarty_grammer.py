"""
Inspired by FreshBooks https://github.com/freshbooks/smartytotwig
Hacked to convert to PHP
"""

import re, fileinput
from pyPEG import *
from pyPEG import parse, keyword, _and, _not, ignore

"""
Misc.
"""
def content():              return re.compile(r'[^{]+')

def comment():              return re.compile("{\*.*?\*}", re.S)

def literal():              return re.compile("{literal}.*?{/literal}", re.S)

def junk():                 return -1, [' ', '\n', '\t']

"""
Logical operators.
"""
def and_operator():         return [keyword('and'), '&&']

def or_operator():          return [keyword('or'), '||']

def equals_operator():      return ['==', keyword('eq')]

def ne_operator():          return ['!=', keyword('ne'), keyword('neq')]

def gt_operator():          return ['>', 'gt']

def lt_operator():          return ['<', 'gt']

def lte_operator():         return ['<=']

def gte_operator():         return ['>=']

def right_paren():          return junk, ')'

def left_paren():           return junk, '('

def operator():             return 0, ' ', [and_operator, equals_operator, gte_operator, lte_operator, lt_operator, gt_operator, ne_operator, or_operator]

"""
Smarty variables.
"""
def string():               return 0, ' ', [(re.compile(r'"'), -1, [re.compile(r'[^$`"\\]'), re.compile(r'\\.')], re.compile(r'"')), (re.compile(r'\''), -1, [re.compile(r'[^\'\\]'), re.compile(r'\\.')], re.compile(r'\''))]

def text():                 return -2, [re.compile(r'[^$`"\\]'), re.compile(r'\\.')]

def variable_string():      return '"', -2, [text, ('`', expression, '`'), ('$', expression)], '"'

def dollar():               return '$'

def not_operator():         return '!'

def at_operator():          return '@'

def symbol():               return -1, [' ', '\n', '\t'], 0, [not_operator, at_operator], 0, dollar, re.compile(r'[\w\-\+]+')

def array():                return symbol, "[", 0, expression, "]"

def modifier():             return [object_dereference, array, symbol, variable_string, string], -2, modifier_right, 0, ' '

def expression():           return [modifier, object_dereference, array, symbol, string, variable_string]

def object_dereference():   return [array, symbol], '.', expression

def exp_no_modifier():      return [object_dereference, array, symbol, variable_string, string]

def modifier_right():       return ('|', symbol, -1, (':', exp_no_modifier),)

"""
Smarty statements.
"""
def else_statement():       return '{', keyword('else'), '}', -1, smarty_language

def foreachelse_statement():return '{', keyword('foreachelse'), '}', -1, smarty_language

def print_statement():      return '{', 0, 'e ', expression, '}'

def function_parameter():   return symbol, '=', expression, junk

def function_statement():   return '{', symbol, -2, function_parameter, '}'

def for_from():             return junk, keyword('from'), '=', 0, ['"', '\''], expression, 0, ['"', '\''], junk

def for_item():             return junk, keyword('item'), '=', 0, ['"', '\''], symbol, 0, ['"', '\''], junk

def for_name():             return junk, keyword('name'), '=', 0, ['"', '\''], symbol, 0, ['"', '\''], junk

def for_key():              return junk, keyword('key'), '=', 0, ['"', '\''], symbol, 0, ['"', '\''], junk

def elseif_statement():     return '{', keyword('elseif'), -1, left_paren, expression, -1, right_paren, -1, (operator, -1, left_paren, expression, -1, right_paren), '}', -1, smarty_language

def if_statement():         return '{', keyword('if'), -1, left_paren, expression, -1, right_paren, -1, (operator, -1, left_paren, expression, -1, right_paren), '}', -1, smarty_language, -1, [else_statement, elseif_statement], '{/', keyword('if'), '}'

def for_statement():        return '{', keyword('foreach'), -1, [for_from, for_item, for_name, for_key], '}', -1, smarty_language, 0, foreachelse_statement, '{/', keyword('foreach'), '}'

"""
Finally, the actual language description.
"""
def smarty_language():      return -2, [literal, if_statement, for_statement, function_statement, comment, print_statement, content]

print_trace = True

files = fileinput.input()
result = parse(smarty_language(), files, True, comment)
print result
