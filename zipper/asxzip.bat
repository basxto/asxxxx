del as*.zip
del as*.exe
cd ..
cd ..
.\asxxxx\zipper\pkzip.exe -rP .\asxxxx\zipper\asx.zip asxxxx\*.*
.\asxxxx\zipper\pkzip.exe -a  .\asxxxx\zipper\asx.zip asxxxx\readme.txt
cd asxxxx
cd zipper
zip2exe.exe asx.zip

