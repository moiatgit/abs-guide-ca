#! /usr/bin/env python

from bs4 import BeautifulSoup
import os

def makeitpretty(fname):
    """ saves html file f with prettified contents """
    print("Prettifying %s"%fname)
    f = open(fname, "r")
    html = f.read()
    f.close()
    f = open(fname, "w")
    soup = BeautifulSoup(html)
    f.write(soup.prettify("utf-8"))
    f.close()
    print("Done on %s"%fname)

for f in os.listdir("."):
    n,e=os.path.splitext(f)
    if e == ".html":
        makeitpretty(f)

