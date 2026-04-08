#!/bin/sh

sound_path="$1"

[ -f "$sound_path" ] || exit 0

afplay "$sound_path" >/dev/null 2>&1 || exit 0
