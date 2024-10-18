# Check WHOIS Script

## Overview

The `check_whois.py` script is a command-line tool designed to retrieve and display various information about a specified domain. It provides users with insights into WHOIS data, DNS records, IP addresses, and SSL certificate details. This script can be particularly useful for web administrators, security professionals, or anyone interested in obtaining detailed domain information.

## Purpose

The primary purpose of this script is to allow users to gather comprehensive information about a domain, which can assist in tasks such as troubleshooting, security assessments, and domain management.

## Features

- Retrieve WHOIS information of a domain.
- Display DNS records (A, AAAA, MX, NS, TXT).
- Obtain the IP address associated with the domain.
- Fetch SSL certificate details.
- Output options for displaying information directly in the terminal or saving it to a file.

## Libraries and Modules Used

The script utilizes the following libraries and modules:

- **os**: Provides a way of using operating system-dependent functionality.
- **socket**: Provides access to the BSD socket interface for network communication.
- **ssl**: Implements TLS/SSL socket support.
- **sys**: Provides access to some variables used or maintained by the interpreter.
- **dns.resolver**: Part of the dnspython library, used for DNS resolution.
- **colorama**: Allows for colored terminal text and styles, enhancing the user interface.
- **prettytable**: A library for creating ASCII tables, making output more readable.
- **whois**: A Python package for retrieving WHOIS data from various domain registrars.

## Installation

To use this script, ensure you have Python 3 installed on your system. Additionally, you will need to install the required libraries. You can do this by running the following command:

```bash
# Create a virtual environment (optional)
python3 -m venv env
source env/bin/activate
# Install the required libraries
pip install -r requirements.txt
```

````

## Usage

To run the script, use the following command in your terminal:

```bash
./check_whois.py <domain> [--output-to-file]
```

### Parameters

- `<domain>`: The domain name you want to check (e.g., example.com).
- `--output-to-file`: Optional flag that, when included, saves the output to a file named `domain_info.txt`.

### Example

```bash
./check_whois.py example.com
```

To save the output to a file:

```bash
./check_whois.py example.com --output-to-file
```

## How It Works

1. **DomainInfo Class**:
   - The script defines a `DomainInfo` class that initializes with a domain name and contains methods to retrieve WHOIS data, DNS records, the IP address, and SSL certificate details.
2. **Menu Class**:

   - The `Menu` class provides a user interface to interact with the script. It displays a menu of options for users to choose what information they wish to retrieve and handles user input.

3. **Main Loop**:

   - When the script is executed, it checks for the required domain argument, creates instances of the `DomainInfo` and `Menu` classes, and enters a loop allowing the user to select options until they choose to exit.

4. **Output Formatting**:
   - Information is formatted in a readable manner using the `prettytable` library, and color-coded output is provided using `colorama`.
````
