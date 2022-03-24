import requests as r;
import re
import os
from progress.bar import ChargingBar

url = "https://github.com/git-touch/highlight.dart/tree/master/flutter_highlight/lib/themes"

themeFileRegex = r'title="(.*).dart"'
themeVarRegex = r'const (.*) = {'
blacklist = ["highlight.dart"]

response = r.get(url);

lines = response.content.decode().splitlines();

themeFiles = []
themes = {}

bar = ChargingBar('Scanning Lines', max=len(lines))

for line in lines:
    bar.next()
    catgirl = re.findall(themeFileRegex, line)
    if not len(catgirl) > 0:
        continue
    
    theme:str = catgirl[0].split(" ")[0].replace('"','')
    
    if theme in blacklist :
        continue
    
    themeFile = r.get(f"https://raw.githubusercontent.com/git-touch/highlight.dart/master/flutter_highlight/lib/themes/{theme}")
    catgirls = re.findall(themeVarRegex, themeFile.content.decode())
    
    themeFiles.append(theme)
    
    themeVar:str = catgirls[0]
    themeName = re.sub("([a-z])([A-Z])","\g<1> \g<2>",themeVar.replace("Theme", "")).title()
    
    themes[themeName] = themeVar
    

print("")  

variable_name = "kCodeThemes"
data_type = "Map<String, Map<String, TextStyle>>"
filename = "code_themes"
path = f"../codebook/lib/{filename}.dart"

print(f"Writing file at '{path}' ...")

code = "// GENERATED CODE - DO NOT MODIFY BY HAND\n\n"
code += "import 'package:flutter/material.dart';\n"

for file in themeFiles:
    code += f"import 'package:flutter_highlight/themes/{file}';\n"

code += f'\n/// A list of all code themes.\nconst {data_type} {variable_name} = '
code += "{\n"

for key, value in themes.items():
    code += f"'{key}': {value},\n"

code += "};"

if os.path.isfile(path):
    print("Removing old files...")
    os.remove(path)

f = open(path, "a+")
f.write(code);
f.close();

print("Done")