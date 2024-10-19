@echo off
setlocal

:: Function to check for required commands
call :check_dependencies

:: Check for a valid argument (domain name)
if "%~1"=="" (
        echo Usage: %~nx0 ^<domain^>
        exit /b 1
)

set "domain=%~1"

:: Main loop for the menu
:menu
cls
echo ========================================
echo         Domain Information Menu: %domain%
echo ========================================
echo Select the information you want to retrieve:
echo [1] WHOIS Information
echo [2] DNS Information
echo [3] IP Address
echo [4] SSL Certificate
echo [5] All Information
echo [6] Exit
echo [7] Help
echo ========================================
set /p choice=Enter choice [1-7]:

if "%choice%"=="1" call :get_whois_info %domain%
if "%choice%"=="2" call :get_dns_info %domain%
if "%choice%"=="3" call :get_ip_address %domain%
if "%choice%"=="4" call :get_ssl_certificate %domain%
if "%choice%"=="5" call :gather_all_info %domain%
if "%choice%"=="6" goto :confirm_exit
if "%choice%"=="7" goto :help

goto :menu

:: Function to check dependencies
:check_dependencies
for %%C in (whois nslookup openssl) do (
        where %%C >nul 2>nul
        if errorlevel 1 (
                echo Error: Required command %%C not found.
                exit /b 1
        )
)
exit /b

:: Function to get WHOIS information
:get_whois_info
cls
echo ========================================
echo WHOIS Information for %1:
echo ========================================
whois %1
if errorlevel 1 (
    echo Error retrieving WHOIS information for %1.
) else (
    echo WHOIS information retrieved successfully.
)
pause
goto :menu

:: Function to get DNS information
:get_dns_info
cls
echo ========================================
echo DNS Information for %1:
echo ========================================
for %%R in (A AAAA MX NS TXT) do (
    echo %%R Records:
    nslookup -type=%%R %1
)
pause
goto :menu

:: Function to get IP Address
:get_ip_address
cls
echo ========================================
echo IP Address for %1:
echo ========================================
nslookup %1 | findstr /i "Address:"
pause
goto :menu

:: Function to get SSL Certificate
:get_ssl_certificate
cls
echo ========================================
echo SSL Certificate for %1:
echo ========================================
openssl s_client -connect %1:443 -servername %1 2>nul | openssl x509 -text -noout
if errorlevel 1 (
    echo Error retrieving SSL certificate for %1.
) else (
    echo SSL certificate retrieved successfully.
)
pause
goto :menu

:: Function to gather all information
:gather_all_info
cls
echo ========================================
echo Gathering all information for %1:
echo ========================================
call :get_whois_info %1
call :get_dns_info %1
call :get_ip_address %1
call :get_ssl_certificate %1
pause
goto :menu

:: Help section
:help
cls
echo ========================================
echo Help - Understanding the Menu Options
echo ========================================
echo [1] WHOIS Information:
echo     Retrieves the WHOIS information for the domain, which includes 
echo     domain registration details, owner contact information, and 
echo     other administrative data.
echo.
echo [2] DNS Information:
echo     Retrieves DNS records (A, AAAA, MX, NS, TXT) for the domain, 
echo     which are used to map domain names to IP addresses, mail 
echo     server details, and other domain-specific settings.
echo.
echo [3] IP Address:
echo     Displays the IP address associated with the domain.
echo.
echo [4] SSL Certificate:
echo     Retrieves and displays the SSL certificate details for the 
echo     domain, including its validity, issuer, and expiration date.
echo.
echo [5] All Information:
echo     Gathers and displays all of the above information (WHOIS, 
echo     DNS, IP Address, SSL Certificate) in a single view.
echo.
echo [6] Exit:
echo     Allows you to exit the application. A confirmation prompt will 
echo     be shown before exiting.
echo.
echo [7] Help:
echo     Displays this help menu with explanations for each option.
echo ========================================
pause
goto :menu

:: Function to confirm Exit
:confirm_exit
set /p "confirm=Are you sure you want to exit? [Y/N]: "
if /i "%confirm%"=="Y" goto :exit
if /i "%confirm%"=="N" goto :menu
goto :menu

:exit
cls
echo Exiting... Goodbye!
exit /b 0
