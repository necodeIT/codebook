import requests as r;
import re
import os
from progress.bar import ChargingBar

url = "https://raw.githubusercontent.com/git-touch/highlight.dart/master/highlight/lib/languages/all.dart";
language_pattern = r"'(.*)':(.*),"
import_pattern = r"import '(.*)';"
aliases_pattern = r"aliases: \[(.*)\],"

response = r.get(url)

lines = response.content.decode().splitlines();

languages = list()
def fetch_aliases(file: str) -> list:
    # print(f"Looking up aliases for '{file.split('.')[0]}'")
    url = f"https://raw.githubusercontent.com/git-touch/highlight.dart/master/highlight/lib/languages/{file}"
    response = r.get(url)
    
    catgirl = re.findall(aliases_pattern, response.content.decode())
    
    aliases = list()
        
    for girl in catgirl:
        aliases.extend(girl.replace('"','').replace(" ", "").split(","))

            
        
    return aliases

bar = ChargingBar('Scanning Lines', max=len(lines))

for line in lines:
    bar.next()
    if re.match(language_pattern, line.strip()):
        languages.append(line.split("'")[1])
    if re.match(import_pattern, line):
        languages.extend(fetch_aliases(line.split("'")[1]))
        
bar.finish()


variable_name = "kSupportedLanguages"
data_type = "List<String>"
filename = "supported_languages"
path = f"../codebook/lib/{filename}.dart"

print(f"Writing file at '{path}' ...")

code = f'const {data_type} {variable_name} = {languages};'

if os.path.isfile(path):
    print("Removing old files...")
    os.remove(path)

f = open(path, "a+")
f.write(code);
f.close();

print("Done")
