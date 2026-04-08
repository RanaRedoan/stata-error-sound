#!/bin/sh

sound_path="$1"

[ -f "$sound_path" ] || exit 0

if command -v ffplay >/dev/null 2>&1; then
    ffplay -nodisp -autoexit "$sound_path" >/dev/null 2>&1
    exit 0
fi

if command -v mpg123 >/dev/null 2>&1; then
    mpg123 -q "$sound_path" >/dev/null 2>&1
    exit 0
fi

if command -v mpv >/dev/null 2>&1; then
    mpv --no-video --really-quiet "$sound_path" >/dev/null 2>&1
    exit 0
fi

if command -v cvlc >/dev/null 2>&1; then
    cvlc --play-and-exit --intf dummy "$sound_path" >/dev/null 2>&1
    exit 0
fi

if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$sound_path" >/dev/null 2>&1 &
fi

exit 0
