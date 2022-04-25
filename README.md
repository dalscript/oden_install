# oden_install

**One-line commands to install Oden on your system.**

[![Build Status](https://github.com/dalscript/oden_install/workflows/ci/badge.svg?branch=master)](https://github.com/dalscript/oden_install/actions)

## Install Latest Version

**With Shell:**

```sh
curl -fsSL https://oden.dallin.pro/install.sh | sh
```

**With PowerShell:**

```powershell
iwr https://oden.dallin.pro/install.ps1 -useb | iex
```

## Install Specific Version

**With Shell:**

```sh
curl -fsSL https://oden.dallin.pro/install.sh | sh -s v1.0.0
```

**With PowerShell:**

```powershell
$v="1.0.0"; iwr https://oden.dallin.pro/install.ps1 -useb | iex
```

## Environment Variables

- `ODEN_INSTALL` - The directory in which to install Oden. This defaults to
  `$HOME/.oden`. The executable is placed in `$ODEN_INSTALL/bin`. One
  application of this is a system-wide installation:

  **With Shell (`/usr/local`):**

  ```sh
  curl -fsSL https://oden.dallin.pro/install.sh | sudo ODEN_INSTALL=/usr/local sh
  ```

  **With PowerShell (`C:\Program Files\oden`):**

  ```powershell
  # Run as administrator:
  $env:ODEN_INSTALL = "C:\Program Files\oden"
  iwr https://oden.dallin.pro/install.ps1 -useb | iex
  ```

## Compatibility

- The Shell installer can be used on Windows with [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about), [MSYS](https://www.msys2.org) or equivalent set of tools.

## Known Issues

### unzip is required

The program [`unzip`](https://linux.die.net/man/1/unzip) is a requirement for the Shell installer.

```sh
$ curl -fsSL https://oden.dallin.pro/install.sh | sh
Error: unzip is required to install Oden (see: https://github.com/dalscript/oden_install#unzip-is-required).
```

**When does this issue occur?**

During the `install.sh` process, `unzip` is used to extract the zip archive.

**How can this issue be fixed?**

You can install unzip via `brew install unzip` on MacOS or `apt-get install unzip -y` on Linux.
