$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
$App = Join-Path $Root "app"
$Build = Join-Path $Root "build"
$MainClasses = Join-Path $Build "classes-main"
$TestClasses = Join-Path $Build "classes-test"
$Jar = Join-Path $Root "lib/junit-platform-console-standalone-1.10.2.jar"

if (!(Test-Path $Jar)) {
    Write-Error "Не найден JUnit jar: $Jar"
}

Remove-Item -Recurse -Force $Build -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $MainClasses | Out-Null
New-Item -ItemType Directory -Force -Path $TestClasses | Out-Null

$MainSources = Get-ChildItem -Recurse -Path (Join-Path $App "src/main/java") -Filter "*.java" | ForEach-Object { $_.FullName }
$TestSources = Get-ChildItem -Recurse -Path (Join-Path $App "src/test/java") -Filter "*.java" | ForEach-Object { $_.FullName }

javac -encoding UTF-8 -d $MainClasses $MainSources
javac -encoding UTF-8 -cp "$Jar;$MainClasses" -d $TestClasses $TestSources
java -jar $Jar execute --class-path "$MainClasses;$TestClasses" --scan-class-path
exit $LASTEXITCODE
