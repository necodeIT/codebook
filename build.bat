cd web
call flutter pub get
call flutter build web --release --base-href="/codebook/"
cd build/web
call xcopy *.* "../../../docs" /i /s /y
cd "../../../docs"
call powershell -Command "(gc flutter_service_worker.js) -replace '(.*)\"\/\",', '//\"/\",' | Out-File -encoding ASCII flutter_service_worker.js"
cd ../
call git add docs/*.*
call git commit -m "new web build"
call git push
