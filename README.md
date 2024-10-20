# 🕵️ Check WHOIS Script

## 🚀 Overview

The `check_whois.py`, `check_whois.sh`, and `check_whois.bat` scripts are robust command-line tools designed to retrieve **comprehensive information** about a domain. Whether you're a web admin, security enthusiast, or simply curious, these scripts provide insights into **WHOIS data**, **DNS records**, **IP addresses**, and **SSL certificate details**. Choose the tool that fits your workflow—be it Python, Bash, or Windows Batch!

## 🎯 Purpose

Easily gather detailed domain information with these scripts. Whether troubleshooting, conducting security assessments, or managing domains, this suite equips you with the tools to get the job done **quickly and efficiently**.

## ✨ Features

### **Python Script (`check_whois.py`)**:

- 🔍 Retrieve WHOIS details of any domain.
- 🌐 Display DNS records: A, AAAA, MX, NS, TXT.
- 🖥️ Fetch associated IP addresses.
- 🔐 Retrieve SSL certificate information.
- 📂 Flexible output options: view in terminal or save to a file.

### **Bash Script (`check_whois.sh`)**:

- 🛠️ Interactive menu for streamlined info retrieval.
- ⛔ Exit confirmation for safe termination.
- 💻 Suitable for shell scripting pros.

### **Batch Script (`check_whois.bat`)** (Windows):

- 🖱️ Interactive Windows-style menu.
- ✅ Supports WHOIS, DNS, IP Address, and SSL retrieval.
- 🔗 Ensures required tools (`whois`, `nslookup`, `openssl`) are in your system path.

## 🖥️ Setup on Windows (WHOIS and OpenSSL)

### 📦 Setting Up WHOIS:

1. Download the WHOIS tool from [Microsoft Sysinternals](https://learn.microsoft.com/en-us/sysinternals/downloads/whois).
2. Extract and place `whois64.exe` in a directory of your choice.
3. Add this directory to your system's environment `Path` variables.

### 🔒 Setting Up OpenSSL:

OpenSSL binaries are included with **Git for Windows**. Locate it in `C:\Program Files\Git\usr\bin\openssl.exe` and add this path to your system environment variables.

## 📦 Installation

### Python Script:

Ensure you have **Python 3** installed. Install the necessary libraries with:

```bash
# Optionally create a virtual environment
python3 -m venv .venv
source .venv/bin/activate
# Install dependencies
pip install -r requirements.txt
```

For **Bash**, ensure you have `whois`, `dig`, `getent`, and `openssl` installed.

## 🛠️ Usage

### Python Script

```bash
./check_whois.py <domain> [--output-to-file]
```

#### Parameters:

- `<domain>`: Domain name to retrieve information for (e.g., example.com).
- `--output-to-file`: Optional flag to save the result to `domain_info.txt`.

#### Example:

```bash
./check_whois.py example.com
./check_whois.py example.com --output-to-file
```

### Bash Script:

```bash
./check_whois.sh <domain>
```

#### Example:

```bash
./check_whois.sh example.com
```

### Windows Batch Script:

```cmd
check_whois.bat <domain>
```

#### Example:

```cmd
check_whois.bat example.com
```

## ⚙️ How It Works

### Python Script:

- **DomainInfo Class**: Handles WHOIS, DNS, IP, and SSL retrieval.
- **Menu Class**: An interactive interface guiding the user through options.
- **Main Loop**: Accepts a domain as input, processes requests, and outputs results.

Formatted with the `prettytable` library for readability and styled using `colorama` for colored output.

### Bash and Batch Scripts:

Both scripts feature an **interactive menu** for retrieving specific domain info and prompt for confirmation before exiting.

## 📋 Conclusion

Choose your weapon—Python, Bash, or Windows Batch! These scripts provide versatile tools for retrieving essential domain data, tailored for different environments. Whether you prefer the versatility of Python, the power of Bash, or the familiarity of Windows, these scripts have you covered.
