from __future__ import print_function
from __future__ import absolute_import
from tree_walker import TreeWalker
from smarty_grammer import smarty_language
import unittest, time, os

from main import parse_file, parse_string

class TestSmartyGrammar(unittest.TestCase):
    """
    It's easy to screw up other rules when modifying the underlying grammar.
    These unit tests test various smarty statements, to make refactoring the grammar more sane.
    """

    def setUp(self):
        self.outputFiletype = '.phtml'
        self.inputFiletype = '.tpl'
        self.testDir = 'test'
        self.input_files = self.output_files = []

        for dirname, dirnames, filenames in os.walk(self.testDir):
            for filename in filenames:
                if filename.endswith(self.inputFiletype):
                    self.input_files.append(self.testDir + '/' + filename)
                if filename.endswith(self.outputFiletype):
                    self.output_files.append(self.testDir + '/' + filename)


    def test_statement(self):
        """
        Test several different types of if statements.
        """
        print(self.input_files)
        for filename in self.input_files:
            fn = os.path.basename(filename)
            output_file = os.path.splitext(fn)[0] + self.outputFiletype
            print(("outputfile: ",output_file))
            output = open(self.testDir + '/' + output_file)

            print(("inputfile: ",filename)) 
            statement = open(filename)

            # Test an if statement (no else or elseif)
            ast = parse_string(statement.read())
            tree_walker = TreeWalker(ast)
            testOutput = tree_walker.code
            self.assertEqual(testOutput, output.read())


def suite():
    suite = unittest.TestSuite()
    suite.addTest(unittest.makeSuite(TestSmartyGrammer))
    return suite
        
if __name__ == '__main__':
    unittest.main()
    """
    suiteFew = unittest.TestSuite()
    suiteFew.addTest(TestSmartyGrammer("test_statement"))
    unittest.TextTestRunner(verbosity=2).run(suite())
    """

