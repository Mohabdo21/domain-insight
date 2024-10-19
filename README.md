# Check WHOIS Script

## Overview

The `check_whois.py`, `check_whois.sh`, and `check_whois.bat` scripts are command-line tools designed to retrieve and display various information about a specified domain. They provide users with insights into WHOIS data, DNS records, IP addresses, and SSL certificate details. These scripts can be particularly useful for web administrators, security professionals, or anyone interested in obtaining detailed domain information.

## Purpose

The primary purpose of these scripts is to allow users to gather comprehensive information about a domain, which can assist in tasks such as troubleshooting, security assessments, and domain management.

## Features

- **Python Script (`check_whois.py`)**:

  - Retrieve WHOIS information of a domain.
  - Display DNS records (A, AAAA, MX, NS, TXT).
  - Obtain the IP address associated with the domain.
  - Fetch SSL certificate details.
  - Output options for displaying information directly in the terminal or saving it to a file.

- **Bash Script (`check_whois.sh`)**:

  - Interactive menu for selecting information retrieval.
  - Confirm exit before terminating the script.
  - Provides a command-line interface for users familiar with shell scripting.

- **Batch Script (`check_whois.bat`)** (for Windows):
  - Interactive menu for retrieving domain information.
  - Supports WHOIS, DNS, IP Address, and SSL Certificate retrieval.
  - Verifies that required commands (`whois`, `nslookup`, and `openssl`) are available in the system path.

## Windows Setup (WHOIS and OpenSSL)

If you're using Windows, you'll need to ensure that both WHOIS and OpenSSL are properly configured in your system path. Here's how to set them up:

### Setup WHOIS for Windows:

1. Download the WHOIS binaries from the [Microsoft Sysinternals website](https://learn.microsoft.com/en-us/sysinternals/downloads/whois).
2. Extract the compressed file, and copy the `whois64.exe` file to a directory of your choice.
3. Add the directory path to your system's environment variables:
   - Launch "Control Panel".
   - Go to "System" > "Advanced system settings".
   - Switch to the "Advanced" tab.
   - Click on "Environment variables".
   - Under "System Variables", locate `Path` and select "Edit".
   - Add the directory path where `whois64.exe` is located and save the changes.

### Setup OpenSSL for Windows:

While a secure resource for downloading OpenSSL binaries directly is not readily available, you can use the OpenSSL binary included with Git for Windows:

1. If you have Git installed, the OpenSSL binary is located in `C:\Program Files\Git\usr\bin\openssl.exe`.
2. Add this path to your system's environment variables, just like with the WHOIS binary:
   - Launch "Control Panel".
   - Go to "System" > "Advanced system settings".
   - Switch to the "Advanced" tab.
   - Click on "Environment variables".
   - Under "System Variables", locate `Path` and select "Edit".
   - Add the directory path where `openssl.exe` is located and save the changes.

## Installation

To use the Python script, ensure you have Python 3 installed on your system. Additionally, you will need to install the required libraries. You can do this by running the following command:

```bash
# Create a virtual environment (optional)
python3 -m venv .venv
source env/bin/activate
# Install the required libraries
pip install -r requirements.txt
```

For the Bash script, no additional installation is necessary, but ensure that the required command-line tools are installed (`whois`, `dig`, `getent`, and `openssl`).

## Usage

### Python Script

To run the Python script, use the following command in your terminal:

```bash
./check_whois.py <domain> [--output-to-file]
```

#### Parameters

- `<domain>`: The domain name you want to check (e.g., example.com).
- `--output-to-file`: Optional flag that, when included, saves the output to a file named `domain_info.txt`.

#### Example

```bash
./check_whois.py example.com
```

To save the output to a file:

```bash
./check_whois.py example.com --output-to-file
```

### Bash Script

To run the Bash script, use the following command:

```bash
./check_whois.sh <domain>
```

#### Example

```bash
./check_whois.sh example.com
```

### Batch Script (Windows)

To run the Batch script on Windows, use the following command:

```cmd
check_whois.bat <domain>
```

#### Example

```cmd
check_whois.bat example.com
```

## How It Works

1. **DomainInfo Class** (Python Script):

   - The script defines a `DomainInfo` class that initializes with a domain name and contains methods to retrieve WHOIS data, DNS records, the IP address, and SSL certificate details.

2. **Menu Class** (Python Script):

   - The `Menu` class provides a user interface to interact with the script. It displays a menu of options for users to choose what information they wish to retrieve and handles user input.

3. **Main Loop** (Both Scripts):

   - When executed, the scripts check for the required domain argument (for Python), create instances of the necessary classes (for Python), and enter a loop allowing the user to select options until they choose to exit.

4. **Output Formatting** (Python Script):

   - Information is formatted in a readable manner using the `prettytable` library, and color-coded output is provided using `colorama`.

5. **Interactive Interface** (Bash and Batch Scripts):
   - The Bash and Batch scripts provide an interactive menu for users to select the type of information they wish to retrieve about the specified domain. It also confirms user intentions before exiting.

## Conclusion

All three scripts serve the same purpose but cater to different user preferences: one for those who prefer a Python environment, another for users comfortable with shell scripting, and the Batch script for Windows users. Users can choose the tool that best fits their workflow.
