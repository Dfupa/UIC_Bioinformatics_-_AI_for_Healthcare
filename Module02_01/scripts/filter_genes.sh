#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 4 ]]; then
  echo "Usage: $0 INPUT_TSV CHROMOSOME MINIMUM_VALUE OUTPUT_TSV" >&2
  exit 1
fi

input_tsv="$1"
target_chromosome="$2"
minimum_value="$3"
output_tsv="$4"

if [[ ! -f "$input_tsv" ]]; then
  echo "Error: input table not found: $input_tsv" >&2
  exit 2
fi

if ! [[ "$minimum_value" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: minimum value must be a non-negative number." >&2
  exit 3
fi

if [[ "$input_tsv" == "$output_tsv" ]]; then
  echo "Error: input and output paths must be different." >&2
  exit 4
fi

if [[ -e "$output_tsv" ]]; then
  echo "Error: output already exists: $output_tsv" >&2
  exit 5
fi

mkdir -p "$(dirname "$output_tsv")"
temporary_output="$(mktemp "${output_tsv}.tmp.XXXXXX")"
trap 'rm -f "$temporary_output"' EXIT

awk -F '\t' -v chromosome="$target_chromosome" -v minimum="$minimum_value" '
  BEGIN { OFS = "\t" }
  NR == 1 {
    for (i = 1; i <= NF; i++) column[$i] = i

    if (!("chromosome" in column)) {
      print "Error: required column chromosome is missing." > "/dev/stderr"
      exit 10
    }

    if ("mean_expression" in column) {
      value_name = "mean_expression"
    } else if ("mean_count" in column) {
      value_name = "mean_count"
    } else {
      print "Error: required column mean_expression or mean_count is missing." > "/dev/stderr"
      exit 11
    }

    chromosome_column = column["chromosome"]
    value_column = column[value_name]
    print
    next
  }
  $chromosome_column == chromosome && ($value_column + 0) >= minimum { print }
' "$input_tsv" > "$temporary_output"

mv "$temporary_output" "$output_tsv"
trap - EXIT

printf "Wrote filtered table to: %s\n" "$output_tsv"
