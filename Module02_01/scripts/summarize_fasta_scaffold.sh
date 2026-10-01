#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 INPUT_FASTA OUTPUT_TSV" >&2
  exit 1
fi

input_fasta="$1"
output_tsv="$2"

if [[ ! -f "$input_fasta" ]]; then
  echo "Error: input FASTA file not found: $input_fasta" >&2
  exit 2
fi

if [[ "$input_fasta" == "$output_tsv" ]]; then
  echo "Error: input and output paths must be different." >&2
  exit 4
fi

if [[ -e "$output_tsv" ]]; then
  echo "Error: output already exists: $output_tsv" >&2
  exit 5
fi

if ! grep -q '^>' "$input_fasta"; then
  echo "Error: no FASTA headers beginning with '>' were found." >&2
  exit 3
fi

mkdir -p "$(dirname "$output_tsv")"

record_count="$(grep -c '^>' "$input_fasta")"

{
  printf "input_file\tfasta_record_count\n"
  printf "%s\t%s\n" "$input_fasta" "$record_count"
} > "$output_tsv"

printf "Wrote summary to: %s\n" "$output_tsv"
