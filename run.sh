#!/bin/sh

USER_AGENT="github.com/fraserli/aoc2023"

set -e

DIR="$(dirname "$(readlink -f "$0")")"

[ -n "$1" ] || (echo "Usage: $0 <day>" && exit 1)
day="$(printf "%02d" "$1")"

src="$DIR/src/Day${day}.hs"
input="$DIR/inputs/day${day}.txt"

if [ ! -f "$input" ]; then
    [ -n "$AOC_SESSION" ] || (echo "AOC_SESSION not set" && exit 1)
    url="https://adventofcode.com/2023/day/$1/input"

    echo "Downloading input for day $1..."
    curl -s --cookie "session=$AOC_SESSION" -A "$USER_AGENT" "$url" > "$input"
fi

cat "$input" | stack "$src"
