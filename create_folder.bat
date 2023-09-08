cd lib

data tetap di utama
mkdir data 2>nul
cd data
mkdir datasources 2>nul
cd datasources
mkdir db
cd ..
mkdir models 2>nul
mkdir repositories 2>nul
cd ..

mkdir domain 2>nul
cd domain
mkdir entities 2>nul
mkdir repositories 2>nul
mkdir usecases 2>nul
cd ..

mkdir presentation 2>nul
cd presentation
mkdir bloc 2>nul
mkdir pages 2>nul
mkdir provider 2>nul
mkdir widgets 2>nul
cd ..
cd ..

cd test

@REM test data tetap di utama
@REM mkdir data 2>nul
@REM cd data
@REM mkdir datasources 2>nul
@REM mkdir models 2>nul
@REM mkdir repositories 2>nul
@REM cd ..

mkdir domain 2>nul
cd domain
mkdir usecases 2>nul
cd ..
mkdir dummy_data 2>nul

mkdir presentation 2>nul
cd presentation
mkdir bloc 2>nul
mkdir pages 2>nul
mkdir provider 2>nul
cd ..


