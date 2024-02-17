import os
import re

def find_reports(directoryname):
    files=[]
    for (dirpath, dirnames, filenames) in os.walk(directoryname):
        for filename in filenames:
            m=re.match(r"^report-.*\.txt$",filename)
            if m is not None:
                files.append(os.path.join(dirpath,filename))
    return files
    