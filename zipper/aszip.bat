del as*.zip
del as*.exe
cd ..
cd ..
.\asxv4pxx\zipper\pkzip.exe -rP .\asxv4pxx\zipper\asxv4pxx.zip asxv4pxx\*.*
.\asxv4pxx\zipper\pkzip.exe -d  .\asxv4pxx\zipper\asxv4pxx.zip asxv4pxx\zipper\pkzip.exe
.\asxv4pxx\zipper\pkzip.exe -d  .\asxv4pxx\zipper\asxv4pxx.zip asxv4pxx\zipper\zip2exe.exe
.\asxv4pxx\zipper\pkzip.exe -a  .\asxv4pxx\zipper\asxv4pxx.zip asxv4pxx\readme.txt
cd asxv4pxx
cd zipper
zip2exe.exe asxv4pxx.zip

