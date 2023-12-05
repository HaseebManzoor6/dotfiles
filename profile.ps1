# == Colors ==
# No ugly ls directory background colors
$psstyle.FileInfo.Directory = $psstyle.FileInfo.Executable = $psstyle.FileInfo.SymbolicLink  = "`e[34;255m"
$psstyle.FileInfo.Executable = "`e[92;255m"
$psstyle.FileInfo.SymbolicLink  = "`e[36;255m"
$PSStyle.FileInfo.Extension.Clear()
$PSStyle.Formatting.TableHeader = ""
$PsStyle.Formatting.FormatAccent = ""

# == Prompt ==
$script:ESC=[char]27
$script:ICO_TIME=[char]0xf43a
$script:ICO_PATH=[char]0xf114
$script:ICO_BRANCH=[char]0xe725
$script:ICO_PROMPT='$'
#function PromptBoring { $savedexitcode=$lastexitcode; "[$(Get-Date -Format "hh:mm:ss")] $($executionContext.SessionState.Path.CurrentLocation)> "; $lastexitcode=$savedexitcode}
function Prompt {
	$script:savedexitcode=$global:lastexitcode
	write-host $script:ICO_TIME" $(Get-Date -Format 'hh:mm:ss') " -foregroundcolor DarkGray -n
	# -- Git --
	if ($(git rev-parse --git-dir 2>$null))
	{ if ( $x = git status --porcelain )
		{
			write-host '*' -foregroundcolor DarkYellow -n
		}
	  write-host $script:ICO_BRANCH" $()" -foregroundcolor DarkYellow -n
	  write-host "$(git branch --show-current) " -foregroundcolor DarkYellow -n
	}
	# ---------
	write-host $script:ICO_PATH" $($executionContext.SessionState.Path.CurrentLocation)"$script:ICO_PROMPT -foregroundcolor Gray -n
	$global:lastexitcode=$script:savedexitcode
	return ' '
}

# == Aliases ==
function vi { nvim $args }
function l { ls.exe --color -a $args }
function make { mingw32-make.exe $args }
function rkt { racket -it $args }

# == PATH ==
# mingw
$env:PATH += ';C:\mingw-w64\i686-8.1.0-posix-dwarf-rt_v6-rev0\mingw32\bin;C:\mingw_lib\SDL\bin;C:\mingw_lib\SDL2_image-2.0.5\i686-w64-mingw32\bin'
# VirtualBox
$env:PATH += ';C:\Program Files\Oracle\VirtualBox'
# SDL
$env:PATH += ';C:\mingw_lib\SDL\bin;C:\mingw_lib\SDL2_image-2.0.5\i686-w64-mingw32\bin'
# MiKTeX
$env:PATH += ';C:\Users\hasee\AppData\Local\Programs\MiKTeX\miktex\bin\x64\'
# WIT and Wiimm
$env:PATH += ';C:\Program Files\Wiimm\SZS;C:\Program Files\Wiimm\WIT;C:\Users\hasee\Documents\Emulators\wii hackery\wit-v3.04a-r8427-cygwin64\wit-v3.04a-r8427-cygwin64\bin'
# Racket
$env:PATH += ';C:\Program Files\Racket'

# Custom ls command
$env:PATH += ';C:\Users\hasee\c\ls\bin'

# PW generator
$env:PATH += ';C:\Users\hasee\python\pw'
