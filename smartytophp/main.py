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
import os, optparse, sys, fileinput
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
    output_file_type = '.phtml'
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

    opt3 = optparse.make_option(
        "-d",
        "--directory",
        action="store",
        dest="directory",
        help="Directory to scan and parse the templates."
    )

    parser = optparse.OptionParser(usage='smartytophp --smarty-file=<SOURCE TEMPLATE> --phtml-file=<OUTPUT TEMPLATE> OR --directory=<SOURCE / OUTPUT DIRECTORY>')
    parser.add_option(opt1)
    parser.add_option(opt2)
    parser.add_option(opt3)
    (options, args) = parser.parse_args(sys.argv)

    print options, args

    if options.smarty and options.phtml:
        convert(options.smarty, options.phtml)
    elif options.directory:
        for dirname, dirnames, filenames in os.walk(options.directory):
            for subdirname in dirnames:
                print os.path.join(dirname, subdirname)
            for filename in filenames:
                if filename.endswith('.tpl'):
                    output_filename = filename.rstrip('.tpl')+output_file_type
                    print output_filename
                    #print filename, output_filename
                    convert(os.path.join(dirname, filename), os.path.join(dirname, output_filename))
                    #print os.path.join(dirname, filename)

def convert(input_file, output_file):
    # Parse the file into tokens
    ast = parse_file(input_file)

    # Walk through those tokens, converting Smarty to PHP/HTML
    tree_walker = TreeWalker(ast)

    # Open the target phtml file and write to it the syntax generated by
    # TreeWalker
    f = open(output_file, 'w+')
    f.write(tree_walker.code.encode('ascii', 'replace'))
    f.close()

    # Give some feedback
    print 'Template outputted to %s' % output_file

if __name__ == "__main__":
    main()
