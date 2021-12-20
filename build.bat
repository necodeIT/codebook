call git pull --recurse-submodules
cd nekolib 
call git reset --hard origin/flutter
cd ../web
call flutter pub get
call flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true --base-href="/codebook/" --web-renderer html
cd build/web
call xcopy *.* "../../../docs" /i /s /y
cd ../../../
call git add docs/*.*
call git commit -m "new web build"
call git push
