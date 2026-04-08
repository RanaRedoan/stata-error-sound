# stata-error-sound

`stata-error-sound` is a small Stata package that runs a do-file and plays a short sound whenever the do-file exits with any nonzero return code. That includes ordinary Stata command errors, errors raised inside the wrapped do-file, and other failures that leave a nonzero `_rc`.

## Install

In Stata, install directly from the repository's raw `main` branch:

```stata
net install stata_error_sound, from("https://raw.githubusercontent.com/RanaRedoan/stata-error-sound/main") replace
```

After installation, open the help with either:

```stata
help dosound
help stata_error_sound
```

## Usage

Run a do-file and use the bundled sound:

```stata
dosound using my_analysis.do
```

If the do-file path contains spaces, quote it:

```stata
dosound using "D:/AI Agent Task/Stata Dos/dos/01_setup.do"
```

Override the sound file for one run:

```stata
dosound using my_analysis.do, sound("C:/sounds/error.mp3")
```

If the wrapped do-file finishes successfully, `dosound` stays silent. If it fails with any nonzero return code, `dosound` tries to play the bundled MP3 and then exits with the same return code that the do-file produced.

The `sound()` option does not run by itself. It only changes which audio file is played if the wrapped do-file ends with an error. If you select a file in `sound()`, `dosound` uses that file. If you do not select a file, `dosound` uses the bundled default sound. Use the full command form:

```stata
dosound using "D:/AI Agent Task/Stata Dos/dos/01_setup.do", sound("C:/sounds/error.mp3")
```

On Windows, the helper opens the selected audio file with the default associated player. If that cannot be started, it falls back to a short beep so that an error still produces an audible signal.

## Repository contents

- `dosound.ado`: the Stata command
- `dosound.sthlp`: Stata help page
- `stata.toc` and `stata_error_sound.pkg`: GitHub `net install` metadata
- `sounds/`: bundled default sound asset
- `scripts/`: OS-specific playback helpers for Windows, macOS, and Linux
