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
        self.maxDiff = 20000

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
            print("in: ", fn) 
            statement = open(filename)

            output_file = os.path.splitext(fn)[0] + self.outputFiletype
            print("out:", output_file)
            output = open(self.testDir + '/' + output_file)

            # Test an if statement (no else or elseif)
            try:
                ast = parse_string(statement.read())
                tree_walker = TreeWalker(ast)
                testOutput = tree_walker.code
                self.assertEqual(testOutput, output.read())
            finally:
                statement.close()
                output.close()

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

