from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def read_text(relative_path: str) -> str:
    return (ROOT / relative_path).read_text(encoding="utf-8")


def test_expected_files_exist():
    expected = [
        "README.md",
        "stata.toc",
        "stata_error_sound.pkg",
        "dosound.ado",
        "dosound.sthlp",
        "stata_error_sound.sthlp",
        "dosound_error.mp3",
        "dosound_play_win.ps1",
        "dosound_play_mac.sh",
        "dosound_play_linux.sh",
        "sounds/dosound_error.mp3",
        "scripts/dosound_play_win.ps1",
        "scripts/dosound_play_mac.sh",
        "scripts/dosound_play_linux.sh",
        "docs/plans/2026-04-08-stata-error-sound.md",
    ]
    missing = [path for path in expected if not (ROOT / path).exists()]
    assert not missing, f"Missing expected files: {missing}"


def test_stata_toc_describes_package():
    toc = read_text("stata.toc")
    assert "v 3" in toc
    assert "p stata_error_sound" in toc


def test_pkg_lists_installation_files():
    pkg = read_text("stata_error_sound.pkg")
    assert "v 3" in pkg
    assert "Distribution-Date: 20260408" in pkg
    assert "f dosound.ado" in pkg
    assert "f dosound.sthlp" in pkg
    assert "f stata_error_sound.sthlp" in pkg
    assert "f dosound_error.mp3" in pkg
    assert "f dosound_play_win.ps1" in pkg
    assert "f dosound_play_mac.sh" in pkg
    assert "f dosound_play_linux.sh" in pkg


def test_ado_declares_public_interface_and_rc_flow():
    ado = read_text("dosound.ado")
    assert "program define dosound" in ado
    assert 'syntax using/ [, SOUND(string asis)]' in ado
    assert "capture noisily do" in ado
    assert "`dofile'" in ado or "`using'" in ado
    assert "local rc = _rc" in ado
    assert "if (`rc' != 0)" in ado
    assert "exit `rc'" in ado


def test_ado_contains_cross_platform_dispatch():
    ado = read_text("dosound.ado")
    assert 'c(os)' in ado
    assert '"Windows"' in ado
    assert '"MacOSX"' in ado
    assert 'inlist(`"`c(os)' in ado
    assert "dosound_play_win.ps1" in ado
    assert "dosound_play_mac.sh" in ado
    assert "dosound_play_linux.sh" in ado


def test_readme_documents_github_install_and_usage():
    readme = read_text("README.md")
    assert "net install stata_error_sound" in readme
    assert "help dosound" in readme
    assert "help stata_error_sound" in readme
    assert "dosound using my_analysis.do" in readme
    assert 'dosound using "D:/AI Agent Task/Stata Dos/dos/01_setup.do"' in readme
    assert "quote it" in readme
    assert "any nonzero return code" in readme
    assert "sound(" in readme


def test_alias_help_file_points_to_command_help():
    alias_help = read_text("stata_error_sound.sthlp")
    assert "{help dosound}" in alias_help
    assert "help stata_error_sound" in alias_help


def test_windows_helper_has_mp3_and_beep_fallback():
    helper = read_text("dosound_play_win.ps1")
    assert "System.Windows.Media.MediaPlayer" in helper
    assert "Console]::Beep" in helper or "[Console]::Beep" in helper
