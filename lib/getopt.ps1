<# 
.SYNOPSIS
Gets the command-line options from an array of arguments.

.DESCRIPTION
Gets the command-line options from an array of arguments using the getopt.py module. Supports both short and long options.

.PARAMETER Argv
The array of arguments to parse.

.PARAMETER Shortopts
The string of single-letter options. Options that take a parameter should be followed by ':'.

.PARAMETER Longopts
The array of strings that are long-form options. Options that take a parameter should end with '='.

.OUTPUTS
System.Object[]. The getopt function returns an array of three objects: a hashtable of options and their values, an array of remaining arguments, and a string of error message (if any).

.EXAMPLE
getopt @("-a","-b","foo","--long=bar") "ab:" @("long=")

This example parses the arguments using the short and long options and returns a hashtable of options and their values, an array of remaining arguments, and an empty string for error message.
#>
function getopt {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] # The array of arguments to parse
        $Argv,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] # The string of single-letter options
        $Shortopts,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] # The array of long-form options
        $Longopts
    )

    # Create a hashtable for storing the options and their values
    $Opts = @{}

    # Create an array for storing the remaining arguments
    $Rem = @()

    # Create a function for returning the error message
    function err($msg) {
        $Opts, $Rem, $msg
    }

    # Create a function for escaping special characters in regex patterns
    function regex_escape($str) {
        return [Regex]::Escape($str)
    }

    # Loop through each argument in the array
    for ($i = 0; $i -lt $Argv.Length; $i++) {
        $Arg = $Argv[$i]
        
        # Skip null or non-string arguments
        if ($null -eq $Arg -or !($Arg -is [String])) { continue }

        if ($Arg -eq '--') {
            # Terminate all options and add the rest of the arguments to the remaining array
            if ($i -lt $Argv.Length - 1) {
                $Rem += $Argv[($i + 1)..($Argv.Length - 1)]
            }
            break
        } elseif ($Arg.StartsWith('--')) {
            # Parse a long option
            $Name = $Arg.Substring(2)

            # Check if the option is valid and matches one of the long options
            $Longopt = $Longopts | Where-Object { $_ -match "^$Name=?$" }

            if ($Longopt) {
                if ($Longopt.EndsWith('=')) {
                    # The option requires a value
                    if ($i -eq $Argv.Length - 1) {
                        # No value provided
                        return err "Option --$Name requires an argument."
                    }
                    # Add the option and its value to the hashtable
                    $Opts.$Name = $Argv[++$i]
                } else {
                    # The option does not require a value
                    # Add the option and set its value to true in the hashtable
                    $Opts.$Name = $true
                }
            } else {
                # The option is not recognized
                return err "Option --$Name not recognized."
            }
        } elseif ($Arg.StartsWith('-') -and $Arg -ne '-') {
            # Parse a short option
            for ($j = 1; $j -lt $Arg.Length; $j++) {
                $Letter = $Arg[$j].ToString()

                # Check if the option is valid and matches one of the short options
                if ($Shortopts -match "$(regex_escape $Letter):?") {
                    $Shortopt = $Matches[0]
                    if ($Shortopt[1] -eq ':') {
                        # The option requires a value
                        if ($j -ne $Arg.Length - 1 -or $i -eq $Argv.Length - 1) {
                            # No value provided
                            return err "Option -$Letter requires an argument."
                        }
                        # Add the option and its value to the hashtable
                        $Opts.$Letter = $Argv[++$i]
                    } else {
                        # The option does not require a value
                        # Add the option and set its value to true in the hashtable
                        $Opts.$Letter = $true
                    }
                } else {
                    # The option is not recognized
                    return err "Option -$Letter not recognized."
                }
            }
        } else {
            # Add the non-option argument to the remaining array
            $Rem += $Arg
        }
    }

    # Return the hashtable, the remaining array, and an empty string for error message
    $Opts, $Rem, ""
}