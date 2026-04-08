{smcl}
{* *! version 1.0.0 08apr2026}{...}
{vieweralsosee "" "--"}{...}
{viewerjumpto "Syntax" "dosound##syntax"}{...}
{viewerjumpto "Description" "dosound##description"}{...}
{viewerjumpto "Options" "dosound##options"}{...}
{viewerjumpto "Examples" "dosound##examples"}{...}

{title:Title}

{p2colset 5 20 22 2}{...}
{p2col:{hi:dosound} {hline 2}}Run a do-file and play a short sound if it exits with an error{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:dosound} {cmd:using} {it:filename.do}
[{cmd:,} {opt sound("path/to/file")}]

{marker description}{...}
{title:Description}

{pstd}
{cmd:dosound} wraps {cmd:do}. It runs the requested do-file with normal output and error messages.
If the do-file exits with any nonzero return code, including ordinary Stata command errors and errors
raised inside the wrapped do-file, {cmd:dosound} plays a short sound and then exits with the same
return code.

{pstd}
By default, {cmd:dosound} uses the bundled file {cmd:dosound_error.mp3}. Use {cmd:sound()} to point
to another audio file for a specific run. If {cmd:sound()} is provided, that selected audio file is
used. If {cmd:sound()} is omitted, the bundled default sound is used.

{marker options}{...}
{title:Options}

{phang}
{opt sound("path/to/file")} overrides the bundled sound file for the current invocation.

{marker examples}{...}
{title:Examples}

{phang2}{cmd:. net install stata_error_sound, from("https://raw.githubusercontent.com/RanaRedoan/stata-error-sound/main") replace}{p_end}
{phang2}{cmd:. help dosound}{p_end}
{phang2}{cmd:. help stata_error_sound}{p_end}
{phang2}{cmd:. dosound using my_analysis.do}{p_end}
{phang2}{cmd:. dosound using "D:/AI Agent Task/Stata Dos/dos/01_setup.do"}{p_end}
{phang2}{cmd:. dosound using scripts/build_tables.do, sound("C:/sounds/error.mp3")}{p_end}
{phang2}{cmd:. dosound using "D:/AI Agent Task/Stata Dos/dos/01_setup.do", sound("C:/sounds/error.mp3")}{p_end}

{title:Remarks}

{pstd}
Windows playback is handled through a bundled PowerShell helper. macOS uses {cmd:afplay}. Linux uses
the bundled shell helper, which tries common players such as {cmd:ffplay}, {cmd:mpg123}, {cmd:mpv},
and {cmd:cvlc}, then falls back to {cmd:xdg-open} if one of those players is not available.

{pstd}
If the sound file cannot be found or the OS cannot play it, {cmd:dosound} still returns the wrapped
do-file's original return code.

{pstd}
If your do-file path contains spaces, quote the path after {cmd:using}. For example,
{cmd:dosound using "D:/My Project/run.do"}.

{pstd}
On Windows, the bundled helper opens the selected audio file with the default associated player. If
that cannot be started, it falls back to a short beep so that an error still produces an audible signal.

{title:Author}

{pstd}
Md. Redoan Hossain Bhuiyan
