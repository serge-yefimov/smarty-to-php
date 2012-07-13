#!/usr/bin/env python
#from distutils.core import setup
from setuptools import setup, find_packages
import ConfigParser, os

# Read version.conf and use the version #.
config = ConfigParser.ConfigParser()
config.readfp(open('version.conf'))

setup(name="smartytophp",
      version=config.get('app:main', 'version'),
      description="Converts Smarty templates into PHP templates.",
      author="Modified By: Timothy Asp Authored By: Ben Coe",
      author_email="tim@ifixit.com",
      entry_points={
          'console_scripts': [
              'smartytotwig = smartytotwig.main:main'
          ]
      },
      url="git@github.com:ifixit/smartytophp.git",
      packages = find_packages(),
      include_package_data=True,
      setup_requires=['setuptools-git'],
      install_requires = ['simplejson==2.1.1'],
      tests_require=['nose', 'coverage'],
)
