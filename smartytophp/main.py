"""
The MIT License

Copyright (c) 2010 FreshBooks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
"""
import optparse, sys, fileinput
from tree_walker import TreeWalker
from smarty_grammer import smarty_language
from pyPEG import parse, parseLine, parser

"""
Parse a smarty template file.
"""
def parse_file(file_name, language=smarty_language):
    file_input = fileinput.FileInput(file_name)
    return parse(language, file_input, False)

"""
Parse a Smarty template string.
"""
def parse_string(text, language=smarty_language):
    p = parser()
    result, text = p.parseLine(text, language, [], False)
    return result[0][1] # Don't return the 'smarty_language' match.

def main():

    opt1 = optparse.make_option(
        "-s",
        "--smarty-file",
        action="store",
        dest="smarty",
        help="Path to the source Smarty file."
    )

    opt2 = optparse.make_option(
        "-p",
        "--phtml-file",
        action="store",
        dest="phtml",
        help="Location of the PHTML output file."
    )

    parser = optparse.OptionParser(usage='smartytophp --smarty-file=<SOURCE TEMPLATE> --phtml-file=<OUTPUT TEMPLATE>')
    parser.add_option(opt1)
    parser.add_option(opt2)
    (options, args) = parser.parse_args(sys.argv)

    print options, args

    if options.smarty and options.phtml:

        ast = parse_file(options.smarty)
        tree_walker = TreeWalker(ast)

        # Open the target phtml file and write to it
        f = open(options.phtml, 'w+')
        f.write(tree_walker.code)
        f.close()

        print 'Template outputted to %s' % options.phtml

if __name__ == "__main__":
   main()
