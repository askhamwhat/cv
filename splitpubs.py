import sys

filename = sys.argv[1]

with open(filename) as myfile:
    data = myfile.read()

items = str.split(data,"@")
items = items[1:]

cvpub = []
cvpre = []

for item in items:
    if "preprint" not in str.lower(item):
        cvpub.append("@"+item)
    else:
        cvpre.append("@"+item)

cvpubfile = open("cvpub.bib",'w')
for item in cvpub:
    print>> cvpubfile, item
cvpubfile.close()

cvprefile = open("cvpre.bib",'w')
for item in cvpre:
    print>> cvprefile, item
cvprefile.close()
