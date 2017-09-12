import sys

filename = sys.argv[1]

with open(filename) as myfile:
    data = myfile.read()

items = str.split(data,"<body>")
data = items[1]
items = str.split(data,"</body>")
data = items[0]

data = str.replace(data,"</h1>","</h4>")
data = str.replace(data,"</h2>","</h5>")
data = str.replace(data,"<h1","<h4")
data = str.replace(data,"<h2","<h5 class=\"indent\" ")
data = str.replace(data,"<table","<table class=\"table-hover\"")

indexfile = open("index.md",'w')
print>> indexfile, "---"
print>> indexfile, "layout: blank"
print>> indexfile, "banner: Welcome"
print>> indexfile, "title: Curriculum Vitae"
print>> indexfile, "---"
print>> indexfile, " "
print>> indexfile, "A pdf version is available [here](cv.pdf)."
print>> indexfile, " "
print>> indexfile, data
