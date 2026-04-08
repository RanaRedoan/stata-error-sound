program define dosound
    version 16
    syntax using/ [, SOUND(string asis)]

    local dofile `"`using'"'
    local resolved_sound `"`sound'"'

    if (`"`resolved_sound'"' == "") {
        quietly _dosound_default_sound
        local resolved_sound `"`r(sound)'"'
    }

    capture noisily do `"`dofile'"'
    local rc = _rc

    if (`rc' != 0) {
        quietly _dosound_play `"`resolved_sound'"'
    }

    exit `rc'
end

program define _dosound_play
    version 16
    args soundfile

    if (`"`soundfile'"' == "") {
        exit
    }

    capture confirm file `"`soundfile'"'
    if (_rc) {
        exit
    }

    local helper
    local cmd

    if (`"`c(os)'"' == "Windows") {
        capture findfile dosound_play_win.ps1
        if (_rc) exit
        local helper `"`r(fn)'"'
        local cmd `"powershell -STA -NoProfile -ExecutionPolicy Bypass -File `"`helper'"' `"`soundfile'"'"'
    }
    else if (`"`c(os)'"' == "MacOSX") {
        capture findfile dosound_play_mac.sh
        if (_rc) exit
        local helper `"`r(fn)'"'
        local cmd `"/bin/sh `"`helper'"' `"`soundfile'"'"'
    }
    else if inlist(`"`c(os)'"', "Unix", "Linux") {
        capture findfile dosound_play_linux.sh
        if (_rc) exit
        local helper `"`r(fn)'"'
        local cmd `"/bin/sh `"`helper'"' `"`soundfile'"'"'
    }
    else {
        exit
    }

    capture noisily shell `cmd'
end

program define _dosound_default_sound, rclass
    version 16

    capture findfile dosound_error.mp3
    if (!_rc) {
        return local sound `"`r(fn)'"'
        exit
    }

    capture findfile sounds/dosound_error.mp3
    if (!_rc) {
        return local sound `"`r(fn)'"'
        exit
    }

    capture findfile dosound.ado
    if (_rc) {
        return local sound ""
        exit
    }

    local ado_path `"`r(fn)'"'
    local ado_dir = substr(`"`ado_path'"', 1, length(`"`ado_path'"') - length("dosound.ado"))

    local candidate `"`ado_dir'dosound_error.mp3'"'
    capture confirm file `"`candidate'"'
    if (!_rc) {
        return local sound `"`candidate'"'
        exit
    }

    local candidate `"`ado_dir'sounds/dosound_error.mp3'"'
    capture confirm file `"`candidate'"'
    if (!_rc) {
        return local sound `"`candidate'"'
        exit
    }

    return local sound ""
end
