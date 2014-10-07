#!/usr/local/bin/python
import logging, sys, argparse, gzip, os, datetime, socket
'''
userid = raw_input('What is your username: ')
archivePath = raw_input('What is the Path of the archive to encrypt: ')
email = raw_input('What is your email: ')
key = raw_input('What key / passphrase you want to use: ')

print "You have selected:"

print userid
print archivePath
print email
print key
'''
for f in  os.listdir('/Users/em/dev/'):
  if os.path.isfile(f):
    print f
