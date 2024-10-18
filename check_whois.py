#!/usr/bin/env python3

import os
import socket
import ssl
import sys

import dns.resolver
from colorama import Fore, Style, init
from prettytable import PrettyTable

import whois

# Initialize colorama
init(autoreset=True)


class DomainInfo:
    def __init__(self, domain):
        self.domain = domain

    def get_whois_info(self):
        """Retrieve WHOIS information."""
        try:
            w = whois.whois(self.domain)
            return w
        except Exception as e:
            return f"Error retrieving WHOIS data: {e}"

    def get_dns_info(self):
        """Retrieve DNS information."""
        dns_records = {}
        record_types = ["A", "AAAA", "MX", "NS", "TXT"]
        for record_type in record_types:
            try:
                answers = dns.resolver.resolve(self.domain, record_type)
                dns_records[record_type] = [rdata.to_text() for rdata in answers]
            except Exception as e:
                dns_records[record_type] = f"Error: {e}"
        return dns_records

    def get_ip_address(self):
        """Retrieve IP address."""
        try:
            return socket.gethostbyname(self.domain)
        except socket.error as e:
            return f"Error retrieving IP: {e}"

    def get_ssl_certificate(self):
        """Retrieve SSL certificate details."""
        try:
            context = ssl.create_default_context()
            with socket.create_connection((self.domain, 443)) as sock:
                with context.wrap_socket(sock, server_hostname=self.domain) as ssock:
                    cert = ssock.getpeercert()
                    return cert
        except Exception as e:
            return f"Error retrieving SSL certificate: {e}"


class Menu:
    def __init__(self, domain_info, output_to_file=False, file_name="domain_info.txt"):
        self.domain_info = domain_info
        self.output_to_file = output_to_file
        self.file_name = file_name

    def display_menu(self):
        """Display the main menu."""
        menu = f"""
{Fore.CYAN + Style.BRIGHT}{'=' * 40}
{Fore.YELLOW + Style.BRIGHT} Domain Information Menu: {self.domain_info.domain}
{Fore.CYAN + Style.BRIGHT}{'=' * 40}
{Fore.GREEN} Select the information you want to retrieve:
{Fore.BLUE}[1] WHOIS Information
{Fore.BLUE}[2] DNS Information
{Fore.BLUE}[3] IP Address
{Fore.BLUE}[4] SSL Certificate
{Fore.BLUE}[5] All Information
{Fore.RED}[6] Exit
{Fore.CYAN}{'=' * 40}
"""
        print(menu)
        choice = input(Fore.YELLOW + "Enter your choice (1-6): ").strip()
        return choice

    def confirm_exit(self):
        """Prompt user for exit confirmation."""
        confirmation = (
            input(Fore.RED + "Are you sure you want to exit? (Y/n): ").strip().lower()
        )
        return confirmation == "" or confirmation == "y"

    def display_information(self, info_type, info):
        """Format and display the information."""
        table = PrettyTable()
        table.field_names = ["Type", "Details"]

        if isinstance(info, dict):
            for key, value in info.items():
                table.add_row([key, value])
        else:
            table.add_row([info_type, info])

        output = table.get_string()

        # Print to stdout
        print(Fore.GREEN + output)

        # Output to file if specified
        if self.output_to_file:
            with open(self.file_name, "a") as f:
                f.write(output + "\n\n")
                print(Fore.CYAN + f"Output saved to {self.file_name}")

    def handle_choice(self, choice):
        """Handle menu choices."""
        if choice == "1":
            whois_info = self.domain_info.get_whois_info()
            self.display_information("WHOIS Information", whois_info)

        elif choice == "2":
            dns_info = self.domain_info.get_dns_info()
            self.display_information("DNS Information", dns_info)

        elif choice == "3":
            ip_address = self.domain_info.get_ip_address()
            self.display_information("IP Address", ip_address)

        elif choice == "4":
            ssl_info = self.domain_info.get_ssl_certificate()
            self.display_information("SSL Certificate", ssl_info)

        elif choice == "5":
            print(Fore.BLUE + "\nGathering all information...\n")
            whois_info = self.domain_info.get_whois_info()
            dns_info = self.domain_info.get_dns_info()
            ip_address = self.domain_info.get_ip_address()
            ssl_info = self.domain_info.get_ssl_certificate()

            self.display_information("WHOIS Information", whois_info)
            self.display_information("DNS Information", dns_info)
            self.display_information("IP Address", ip_address)
            self.display_information("SSL Certificate", ssl_info)

        elif choice == "6":
            if self.confirm_exit():
                print(Fore.YELLOW + "Exiting... Goodbye!")
                sys.exit(0)
        else:
            print(Fore.RED + "Invalid choice, please enter a valid option (1-6).")

    def run(self):
        """Main menu loop."""
        while True:
            choice = self.display_menu()
            self.handle_choice(choice)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(Fore.RED + "Usage: ./check_whois.py <domain> [--output-to-file]")
        sys.exit(1)

    domain = sys.argv[1]
    output_to_file = "--output-to-file" in sys.argv

    # Create DomainInfo instance
    domain_info = DomainInfo(domain)

    # Create Menu instance and start
    menu = Menu(domain_info, output_to_file)
    menu.run()
