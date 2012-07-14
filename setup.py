#!/usr/bin/env python
from distutils.core import setup
#from setuptools import setup, find_packages
import ConfigParser, os

# Read version.conf and use the version #.
config = ConfigParser.ConfigParser()
config.readfp(open('version.conf'))

setup(
    name="smartytophp",
    version=config.get('app:main', 'version'),
    author="Timothy Asp",
    author_email="tim@ifixit.com",
    description="Converts Smarty templates into PHP templates. Heavily modified fork of FreshBooks SmartyToTwig.",
    long_description=open('README.md').read(),
    entry_points={
        'console_scripts': [
            'smartytotwig = smartytotwig.main:main'
        ]
    },
    url="git@github.com:ifixit/smartytophp.git",
    packages = ['smartytophp', 'smartytophp.test'],
    include_package_data=True,
    install_requires = ['simplejson==2.1.1'],
)
