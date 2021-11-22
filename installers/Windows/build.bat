cd ..\codebook
call git pull --recurse-submodules
call flutter pub get
call flutter build windows
cd "..\url protocol handler"
call dotnet publish -c Release --self-contained true -r win-x86
cd ..\installers\Windows
call iscc windows_setup.iss