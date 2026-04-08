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
If the do-file exits with a nonzero return code, {cmd:dosound} plays a short sound and then exits with
the same return code.

{pstd}
By default, {cmd:dosound} uses the bundled file {cmd:dosound_error.mp3}. Use {cmd:sound()} to point
to another audio file for a specific run.

{marker options}{...}
{title:Options}

{phang}
{opt sound("path/to/file")} overrides the bundled sound file for the current invocation.

{marker examples}{...}
{title:Examples}

{phang2}{cmd:. net install stata_error_sound, from("https://raw.githubusercontent.com/RanaRedoan/stata-error-sound/main") replace}{p_end}
{phang2}{cmd:. dosound using my_analysis.do}{p_end}
{phang2}{cmd:. dosound using scripts/build_tables.do, sound("C:/sounds/error.mp3")}{p_end}

{title:Remarks}

{pstd}
Windows playback is handled through a bundled PowerShell helper. macOS uses {cmd:afplay}. Linux uses
the bundled shell helper, which tries common players such as {cmd:ffplay}, {cmd:mpg123}, {cmd:mpv},
and {cmd:cvlc}, then falls back to {cmd:xdg-open} if one of those players is not available.

{pstd}
If the sound file cannot be found or the OS cannot play it, {cmd:dosound} still returns the wrapped
do-file's original return code.

{title:Author}

{pstd}
Md. Redoan Hossain Bhuiyan
