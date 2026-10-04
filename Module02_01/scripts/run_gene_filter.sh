#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Only source trusted files. Sourcing executes code in the current shell.
# shellcheck source=./config.sh
source "$script_dir/config.sh"
# shellcheck source=./lib/common.sh
source "$script_dir/lib/common.sh"

usage() {
  cat <<'USAGE'
Usage: run_gene_filter.sh INPUT_TSV OUTPUT_TSV [CHROMOSOME] [MINIMUM_EXPRESSION]

Defaults come from scripts/config.sh or from the environment:
  DEFAULT_CHROMOSOME
  DEFAULT_MINIMUM_EXPRESSION
USAGE
}

if [[ ${1:-} == "--help" || ${1:-} == "-h" ]]; then
  usage
  exit 0
fi

if [[ $# -lt 2 || $# -gt 4 ]]; then
  usage >&2
  exit 1
fi

input_tsv="$1"
output_tsv="$2"
chromosome="${3:-$DEFAULT_CHROMOSOME}"
minimum_expression="${4:-$DEFAULT_MINIMUM_EXPRESSION}"

require_file "$input_tsv"

if [[ "$input_tsv" == "$output_tsv" ]]; then
  die "Input and output paths must be different." 3
fi

if [[ -e "$output_tsv" ]]; then
  die "Output already exists: $output_tsv" 4
fi

log "Filtering $input_tsv for chromosome=$chromosome and minimum=$minimum_expression"

"$script_dir/filter_genes.sh" \
  "$input_tsv" \
  "$chromosome" \
  "$minimum_expression" \
  "$output_tsv"

log "Workflow completed: $output_tsv"
