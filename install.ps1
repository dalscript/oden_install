#!/usr/bin/env pwsh
# Copyright 2018 the Deno authors. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

$ErrorActionPreference = 'Stop'

if ($v) {
  $Version = "v${v}"
}
if ($args.Length -eq 1) {
  $Version = $args.Get(0)
}

$OdenInstall = $env:ODEN_INSTALL
$BinDir = if ($OdenInstall) {
  "$OdenInstall\bin"
} else {
  "$Home\.oden\bin"
}

$OdenZip = "$BinDir\oden.zip"
$OdenExe = "$BinDir\oden.exe"
$Target = 'x86_64-pc-windows-msvc'

# GitHub requires TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$OdenUri = if (!$Version) {
  "https://github.com/odenlang/oden-alphas/releases/latest/download/oden-${Target}.zip"
} else {
  "https://github.com/odenlang/oden-alphas/releases/download/${Version}/oden-${Target}.zip"
}

if (!(Test-Path $BinDir)) {
  New-Item $BinDir -ItemType Directory | Out-Null
}

Invoke-WebRequest $OdenUri -OutFile $OdenZip -UseBasicParsing

if (Get-Command Expand-Archive -ErrorAction SilentlyContinue) {
  Expand-Archive $OdenZip -Destination $BinDir -Force
} else {
  if (Test-Path $OdenExe) {
    Remove-Item $OdenExe
  }
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [IO.Compression.ZipFile]::ExtractToDirectory($OdenZip, $BinDir)
}

Remove-Item $OdenZip

$User = [EnvironmentVariableTarget]::User
$Path = [Environment]::GetEnvironmentVariable('Path', $User)
if (!(";$Path;".ToLower() -like "*;$BinDir;*".ToLower())) {
  [Environment]::SetEnvironmentVariable('Path', "$Path;$BinDir", $User)
  $Env:Path += ";$BinDir"
}

Write-Output "Oden was installed successfully to $OdenExe"
Write-Output "Run 'oden --help' to get started"
