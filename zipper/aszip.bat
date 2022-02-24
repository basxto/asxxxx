del as*.zip
del as*.exe
cd ..
cd ..
\asxxxx\zipper\pkzip.exe -rP \asxxxx\zipper\asx.zip asxxxx\*.*
cd asxxxx
cd zipper
zip2exe.exe asx.zip

