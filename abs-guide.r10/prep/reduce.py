#! /usr/bin/env python

from bs4 import BeautifulSoup
from bs4 import Tag
import os

def reduceit(fname):
    """ saves html file f with reduced html contents.
        The main purpose of this function is to remove all those
        unwanted tables. It will replace them by """
    print("Reducing %s"%fname)
    f = open(fname, "r")
    html = f.read()
    f.close()
    soup = BeautifulSoup(html)

    # remove header and footer navigation
    try:
        navh = soup.findAll('div', { "class":"NAVHEADER" })
    except AttributeError:
        navh = []
    try:
        navf = soup.findAll('div', { "class":"NAVFOOTER" })
    except AttributeError:
        navf = []

    for div in navh + navf:
        div.extract()

    # remove tables
    for table in soup.find_all('table'):
        div = soup.new_tag('div')
        try:
            trs = table.find_all('tr')
        except AttributeError:
            trs = []
        for row in trs:
            if row == None:
                print "XXX row == None"
            else:
                try:
                    ths = row.find_all('th')
                except AttributeError:
                    ths = []
                try:
                    tds = row.find_all('td')
                except AttributeError:
                    tds = []
                cells = ([] if ths == None else ths) + ([] if tds == None else tds)
                for cell in cells:
                    p = soup.new_tag('p')
                    p.contents.extend(cell.contents)
                    div.append(p)
        table.replaceWith(div)

    f = open(fname, "w")
    f.write(soup.prettify("utf-8"))
    f.close()
    print("Done on %s"%fname)

for f in os.listdir("."):
    n,e=os.path.splitext(f)
    if e == ".html":
        reduceit(f)

#reduceit("aboutauthor.html")
