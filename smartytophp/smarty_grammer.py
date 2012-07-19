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
def content():                  return re.compile(r'[^{]+')

def comment():                  return re.compile("{\*.*?\*}", re.S)

def literal():                  return re.compile("{literal}.*?{/literal}", re.S)

def junk():                     return -1, [' ', '\n', '\t']

def quotes():                   return 0, ['"', '\'']

def equals():                   return '='

"""
Logical operators.
"""
def and_operator():             return [keyword('and'), '&&']

def or_operator():              return [keyword('or'), '||']

def equals_operator():          return ['==', keyword('eq')]

def ne_operator():              return ['!=', keyword('ne'), keyword('neq')]

def gt_operator():              return ['>', 'gt']

def lt_operator():              return ['<', 'gt']

def lte_operator():             return ['<=']

def gte_operator():             return ['>=']

def right_paren():              return junk, ')'

def left_paren():               return junk, '('

def operator():                 return 0, ' ', [and_operator, equals_operator, gte_operator, lte_operator, lt_operator, gt_operator, ne_operator, or_operator]

"""
Smarty variables.
"""
def string():                   return 0, ' ', [(re.compile(r'"'), -1, [re.compile(r'[^$`"\\]'), re.compile(r'\\.')], re.compile(r'"')), (re.compile(r'\''), -1, [re.compile(r'[^\'\\]'), re.compile(r'\\.')], re.compile(r'\''))]

def text():                     return -2, [re.compile(r'[^$`"\\]'), re.compile(r'\\.')]

def variable_string():          return '"', -2, [text, ('`', expression, '`'), ('$', expression)], '"'

def false():                    return 'false'

def true():                     return 'true'

def boolean():                  return [false, true]

def dollar():                   return '$'

def not_operator():             return '!'

def at_operator():              return '@'

def symbol():                   return -1, [' ', '\n', '\t'], 0, [not_operator, at_operator], 0, dollar, re.compile(r'[\w\-\+]+')

def array():                    return symbol, "[", 0, expression, "]"

def modifier():                 return [object_dereference, array, symbol, variable_string, string], -2, modifier_right, 0, ' '

def modifier_right():           return ('|', [default, escape, symbol], -1, (':', exp_no_modifier),)

def expression():               return [modifier, object_dereference, array, symbol, string, variable_string, php_fun]

def dereference():              return '.', [symbol, array, object_dereference, string, variable_string]

def object_dereference():       return [array, symbol], -2, dereference

def exp_no_modifier():          return [object_dereference, boolean, array, symbol, variable_string, string]

def default():                  return keyword('default'), ':', [variable_string, boolean]

def escape():                   return keyword('escape'), ':', [expression]

def static_param():             return re.compile(r'[\'A-Za-z\-,\' ]+')

def static_call():              return re.compile(r'\$static->call\('), static_param ,re.compile(r'\)')

def php_fun():                  return re.compile(r'\$\w+->\w+'), 0, re.compile(r'\(\)')

"""
Smarty statements.
"""
def else_statement():           return '{', keyword('else'), '}', -1, smarty_language

def for_from():                 return junk, keyword('from'), equals, quotes, expression, quotes, junk

def for_item():                 return junk, keyword('item'), equals, quotes, symbol, quotes, junk

def for_name():                 return junk, keyword('name'), equals, quotes, symbol, quotes, junk

def for_key():                  return junk, keyword('key'), equals, quotes, symbol, quotes, junk

def for_statement():            return '{', keyword('foreach'), -2, [for_from, for_item, for_name, for_key], '}', -1, smarty_language, 0, foreachelse_statement, '{/', keyword('foreach'), '}'

def foreachelse_statement():    return '{', keyword('foreachelse'), '}', -1, smarty_language

def print_statement():          return '{', 0, 'e ', -2, expression, '}'

def elseif_statement():         return '{', keyword('elseif'), -1, left_paren, expression, -1, right_paren, -1, (operator, -1, left_paren, expression, -1, right_paren), '}', -1, smarty_language

def if_statement():             return '{', keyword('if'), -1, left_paren, expression, -1, right_paren, -1, (operator, -1, left_paren, expression, -1, right_paren), '}', -1, smarty_language, -1, [else_statement, elseif_statement], '{/', keyword('if'), '}'

def assign_var():               return junk, keyword('var'), 0, equals, quotes, symbol, quotes, junk

def assign_value():             return junk, keyword('value'), 0, equals, quotes, [static_call, php_fun], quotes, junk

def assign_statement():         return '{', keyword('assign'), assign_var, assign_value, '}'

def capture_name():             return junk, keyword('name'), equals, quotes, symbol, quotes, junk

def capture_assign():           return junk, keyword('assign'), equals, quotes, symbol, quotes, junk

def capture_statement():        return '{', keyword('capture'), -1, [capture_name, capture_assign], '}', -1, smarty_language, '{/', keyword('capture'), '}'

def include_params():           return junk, 0, symbol, 0, equals, expression, junk

def include_statement():        return '{', keyword('include'), -2, include_params, '}'

"""
def math_operators():           return ['*', '+', '/', '-', '%']

def math_expression():          return junk, expression, 0, math_operators, junk

def math_statement():           return '{', -2, math_expression, '}'
"""

"""
iFixit specific statements
"""
def uri_params():               return junk, 0, symbol, 0, equals, expression, junk

def guri_statement():           return '{', keyword('GURI'), symbol, equals, expression, -2, uri_params, '}'

"""
Finally, the actual language description.
"""
def smarty_language():      return -2, [literal, if_statement, for_statement, comment, include_statement, capture_statement, print_statement, assign_statement, content]

"""
print_trace = True

files = fileinput.input()
result = parse(smarty_language(), files, True, comment)
print result
"""
