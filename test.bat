@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM Check if we're in the root of the repo
if not exist .git (
    echo Error: not in root of repo
    exit /b 1
)

REM Run unit and widget tests
:runTests
cd %1
if exist pubspec.yaml (
    echo running tests in %1
    flutter pub get
    flutter clean  REM <-- Added this line for cleaning
    if exist test\all_tests.dart (
        flutter test --coverage test\all_tests.dart
        if errorlevel 1 set error=true
    ) else (
        flutter test --coverage
        if errorlevel 1 set error=true
    )
    REM Combine coverage (might need additional adjustments for Windows)
    if exist coverage (
        type coverage\lcov.info >> %2\coverage\lcov.info
    )
)
cd ..

REM Run report (might need adjustments based on your needs in Windows)
:runReport
if exist coverage\lcov.info (
    REM Assuming lcov or equivalent tool is available
    REM This will likely need to be adjusted based on your needs in Windows
    genhtml coverage\lcov.info -o coverage
    start coverage\index.html
)

REM Main
if "%1"=="" (
    del /f coverage\lcov.info
    for /D %%i in (*) do (
        call :runTests %%i
    )
) else (
    if exist %1 (
        call :runTests %1
    ) else (
        echo Error: not a directory: %1
        exit /b 1
    )
)
call :runReport

REM Fail the build if there was an error
if "%error%"=="true" (
    exit /b -1
)

ENDLOCAL
