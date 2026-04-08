# Stata Error Sound Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a GitHub-installable Stata package that runs a do-file and plays a short sound whenever the do-file exits with a nonzero return code.

**Architecture:** Package one public Stata command, `dosound`, plus a bundled MP3 asset and small OS-specific helper scripts for playback. The Stata command resolves the requested or bundled sound file, runs the target do-file with `capture noisily`, dispatches playback for Windows, macOS, or Linux, and then exits with the wrapped do-file's original return code.

**Tech Stack:** Stata ado/sthlp packaging, GitHub raw `net install` layout, Python `pytest` for static repository verification, PowerShell and POSIX shell helper scripts.

---

### Task 1: Lock the package contract with tests

**Files:**
- Create: `tests/test_package.py`

**Step 1: Write the failing test**

Add tests that assert:
- required package files exist
- `stata.toc` advertises one package
- `stata_error_sound.pkg` lists the ado/help files, sound asset, and platform helpers
- `dosound.ado` exposes `syntax using/ [, SOUND(string asis)]`
- `dosound.ado` preserves the wrapped return code and branches across Windows, Mac, and Unix/Linux

**Step 2: Run test to verify it fails**

Run: `python -m pytest tests/test_package.py -q`
Expected: FAIL because the package files do not exist yet.

### Task 2: Implement the installable Stata package

**Files:**
- Create: `stata.toc`
- Create: `stata_error_sound.pkg`
- Create: `dosound.ado`
- Create: `dosound.sthlp`
- Create: `README.md`
- Create: `scripts/dosound_play_win.ps1`
- Create: `scripts/dosound_play_mac.sh`
- Create: `scripts/dosound_play_linux.sh`

**Step 1: Write minimal implementation**

Add:
- a `stata.toc` content page for the package
- a `.pkg` file that installs the command, help, sound asset, and OS-specific helper scripts
- `dosound.ado` with bundled-sound resolution, optional `sound()` override, `capture noisily do`, OS detection, helper dispatch, and return-code preservation
- a help file and README with install and usage examples
- helper scripts that play the MP3 on each supported OS

**Step 2: Re-run test to verify it passes**

Run: `python -m pytest tests/test_package.py -q`
Expected: PASS.

### Task 3: Add the bundled sound asset and publishable repo metadata

**Files:**
- Create: `sounds/dosound_error.mp3`
- Modify: `README.md`

**Step 1: Copy the provided audio asset into the package**

Store the bundled sound at `sounds/dosound_error.mp3` and document that users can override it with `sound()`.

**Step 2: Verify installation-facing docs**

Confirm the README includes a raw-GitHub `net install` example and the help file documents the same command.

### Task 4: Verify and publish

**Files:**
- Create: `.gitignore`

**Step 1: Run the verification commands**

Run:
- `python -m pytest tests/test_package.py -q`
- `git status --short`

Expected:
- tests pass
- only intended repository files are present

**Step 2: Initialize git and publish**

Create the local git repository, commit the package, create `RanaRedoan/stata-error-sound` on GitHub, add the remote, and push the default branch.
