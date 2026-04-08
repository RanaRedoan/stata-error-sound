# stata-error-sound

`stata-error-sound` is a small Stata package that runs a do-file and plays a short sound whenever the do-file exits with a nonzero return code.

## Install

In Stata, install directly from the repository's raw `main` branch:

```stata
net install stata_error_sound, from("https://raw.githubusercontent.com/RanaRedoan/stata-error-sound/main") replace
```

## Usage

Run a do-file and use the bundled sound:

```stata
dosound using my_analysis.do
```

Override the sound file for one run:

```stata
dosound using my_analysis.do, sound("C:/sounds/error.mp3")
```

If the wrapped do-file finishes successfully, `dosound` stays silent. If it fails, `dosound` tries to play the bundled MP3 and then exits with the same return code that the do-file produced.

## Repository contents

- `dosound.ado`: the Stata command
- `dosound.sthlp`: Stata help page
- `stata.toc` and `stata_error_sound.pkg`: GitHub `net install` metadata
- `sounds/`: bundled default sound asset
- `scripts/`: OS-specific playback helpers for Windows, macOS, and Linux
