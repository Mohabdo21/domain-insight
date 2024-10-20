#!/bin/bash

# Function to check for required commands
check_dependencies() {
	for cmd in whois dig getent openssl; do
		if ! command -v "$cmd" >/dev/null 2>&1; then
			echo "Error: '$cmd' is not installed. Please install it to use this script."
			exit 1
		fi
	done
}

# Function to display the menu
display_menu() {
	echo -e "\n========================================"
	echo -e "        Domain Information Menu: $1"
	echo -e "========================================"
	echo -e "Select the information you want to retrieve:"
	echo -e "[1] WHOIS Information"
	echo -e "[2] DNS Information"
	echo -e "[3] IP Address"
	echo -e "[4] SSL Certificate"
	echo -e "[5] All Information"
	echo -e "[6] Exit"
	echo -e "========================================"
}

# Function to get WHOIS information
get_whois_info() {
	echo -e "\nWHOIS Information for $1:\n"
	if whois "$1"; then
		echo -e "\nWHOIS information retrieved successfully."
	else
		echo "Error retrieving WHOIS information for $1."
	fi
}

# Function to get DNS information
get_dns_info() {
	echo -e "\nDNS Information for $1:\n"
	for record in A AAAA MX NS TXT; do
		echo -e "$record Records:"
		if output=$(dig "$1" "$record" +short); then
			if [[ -z "$output" ]]; then
				echo "No $record records found."
			else
				echo "$output"
			fi
		else
			echo "Error retrieving $record records for $1."
		fi
		echo
	done
}

# Function to get IP address
get_ip_address() {
	echo -e "\nIP Address for $1:"
	if ip=$(getent hosts "$1" | awk '{ print $1 }'); then
		if [[ -z "$ip" ]]; then
			echo "No IP address found for $1."
		else
			echo "$ip"
		fi
	else
		echo "Error retrieving IP address for $1."
	fi
}

# Function to get SSL certificate information
get_ssl_certificate() {
	echo -e "\nSSL Certificate for $1:\n"
	if echo | openssl s_client -connect "$1:443" -servername "$1" 2>/dev/null | openssl x509 -text -noout; then
		echo "SSL certificate retrieved successfully."
	else
		echo "Error retrieving SSL certificate for $1."
	fi
}

# Function to gather all information
gather_all_info() {
	get_whois_info "$1"
	get_dns_info "$1"
	get_ip_address "$1"
	get_ssl_certificate "$1"
}

# Function to confirm exit
confirm_exit() {
	while true; do
		read -r -p "Are you sure you want to exit? (Y/n): " confirmation
		case "$confirmation" in
		[Yy]*) return 0 ;; # Yes: exit
		[Nn]*) return 1 ;; # No: continue
		*) echo "Invalid input. Please enter Y or N." ;;
		esac
	done
}

# Trap to handle Ctrl+C (SIGINT) gracefully
trap "echo -e '\nScript interrupted. Exiting...'; exit 1" SIGINT

# Check for required argument
if [[ $# -lt 1 ]]; then
	echo -e "Usage: $0 <domain>"
	exit 1
fi

domain="$1"

# Validate domain format using a regex
if ! [[ "$domain" =~ ^([a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]]; then
	echo "Error: Invalid domain format. Please provide a valid domain (e.g., example.com)."
	exit 1
fi

# Check for required commands
check_dependencies

# Main loop for the menu
while true; do
	display_menu "$domain"
	read -r -p "Enter your choice (1-6): " choice

	# Ensure valid numeric input between 1-6
	if ! [[ "$choice" =~ ^[1-6]$ ]]; then
		echo "Invalid choice, please enter a valid option (1-6)."
		continue
	fi

	case "$choice" in
	1) get_whois_info "$domain" ;;
	2) get_dns_info "$domain" ;;
	3) get_ip_address "$domain" ;;
	4) get_ssl_certificate "$domain" ;;
	5) gather_all_info "$domain" ;;
	6)
		if confirm_exit; then
			echo "Exiting... Goodbye!"
			exit 0
		fi
		;;
	esac
done
