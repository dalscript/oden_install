#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

# Test that we can install the latest version at the default location.
Remove-Item "~\.oden" -Recurse -Force -ErrorAction SilentlyContinue
$env:ODEN_INSTALL = ""
$v = $null; .\install.ps1
~\.oden\bin\oden.exe --version

# Test that we can install a specific version at a custom location.
Remove-Item "~\oden-0.0.1" -Recurse -Force -ErrorAction SilentlyContinue
$env:ODEN_INSTALL = "$Home\oden-0.0.1"
$v = "0.0.1"; .\install.ps1
$OdenVersion = ~\oden-0.0.1\bin\oden.exe --version
if (!($OdenVersion -like '*0.0.1*')) {
  throw $OdenVersion
}

# Test that we can install at a relative custom location.
Remove-Item "bin" -Recurse -Force -ErrorAction SilentlyContinue
$env:ODEN_INSTALL = "."
$v = "0.0.2"; .\install.ps1
$OdenVersion = bin\oden.exe --version
if (!($OdenVersion -like '*0.0.2*')) {
  throw $OdenVersion
}

# Test that the old temp file installer still works.
Remove-Item "~\oden-0.0.3" -Recurse -Force -ErrorAction SilentlyContinue
$env:ODEN_INSTALL = "$Home\oden-0.0.3"
$v = $null; .\install.ps1 v0.0.3
$OdenVersion = ~\oden-0.0.3\bin\oden.exe --version
if (!($OdenVersion -like '*0.0.3*')) {
  throw $OdenVersion
}
