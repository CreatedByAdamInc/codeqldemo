#/usr/bin/python2
import os

def add(a, b):
    return eval("%s + %s" % (a,b))

a = input()
b = input()
r = add(a,b)
print "Hey i am rocking python2.7 and here's an RCE for you :)"
print r
