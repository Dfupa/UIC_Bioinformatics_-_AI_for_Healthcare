# Session 02 follow along: Bash wrappers, sourcing, link.


## Purpose

Turn a working command-line task into an organized Bash wrapper. Separate configuration and reusable functions, use symbolic links deliberately, test failure behavior, and review an AI-generated script before execution.

This is the single canonical Session 2 follow-along resource.

## Today's story

**Marc**, a PhD student of the group ask you to run an old script of his for data analysis releases and check whether another bioinformatician can operate it safely. 

DO NOT PROVIDE THE INPUT FILES NOR COPY-PASTE IT TO THE AI CHATBOT/AGENT.

Assume they hold sensible information and that you signed a NDA.

## 1. The whole shebang

Inspect the first lines of the wrapper:

```bash
head -n 8 scripts/run_gene_filter.sh
```

Compare the following invocations:

```bash
bash scripts/run_gene_filter.sh --help
./scripts/run_gene_filter.sh --help
```

The second form also requires executable permission and uses the shebang to select an interpreter.

Check permissions:

```bash
ls -l scripts/run_gene_filter.sh
```

The course examples use `bash script.sh` so executable permission is not required for the guided work.

## 2. Locate resources relative to the script

The wrapper calculates its own directory:

```bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

This lets it locate `config.sh`, `lib/common.sh`, and `filter_genes.sh` even when the user launches the wrapper from another directory.

## 3. Source trusted configuration and functions

```bash
source "$script_dir/config.sh"
source "$script_dir/lib/common.sh"
```

Important:

> `source` executes a file in the current shell. Only source files you trust and have inspected.

Inspect the sourced files:

```bash
sed -n '1,120p' scripts/config.sh
sed -n '1,160p' scripts/lib/common.sh
```

Try the configuration interactively in a temporary shell:

```bash
bash -c 'source scripts/config.sh; printf "%s\t%s\n" "$DEFAULT_CHROMOSOME" "$DEFAULT_MINIMUM_EXPRESSION"'
```

## 4. Use symbolic links as named pointers

Create a link called `data/current` that points to the teaching release:

```bash
if [[ ! -e data/current && ! -L data/current ]]; then
  ln -s teaching data/current
fi

ls -l data/current
readlink data/current
head -n 3 data/current/genes.tsv
```

The relative target `teaching` is resolved from the directory containing the link.

Questions:

1. Why is a symlink useful for large shared datasets?
2. What happens if its target is moved?
3. Why should a pipeline record the real data release as well as the convenient link name?

## 5. Run the wrapper with defaults

```bash
mkdir -p results/session2

bash scripts/run_gene_filter.sh \
  data/current/genes.tsv \
  results/session2/chr7_default.tsv
```

Defaults:

```text
chromosome: chr7
minimum expression: 100
```

Expected genes: `GENE007`, `GENE009`, and `GENE020`.

## 6. Override configuration through arguments

```bash
bash scripts/run_gene_filter.sh \
  data/current/genes.tsv \
  results/session2/chr10_high.tsv \
  chr10 \
  170
```

Expected genes: `GENE013` and `GENE021`.

## 7. Understand argument forwarding

The wrapper receives arguments, supplies defaults, checks paths, and calls a narrower processing script:

```bash
"$script_dir/filter_genes.sh" \
  "$input_tsv" \
  "$chromosome" \
  "$minimum_expression" \
  "$output_tsv"
```

For a generic wrapper that forwards every argument unchanged, Bash provides:

```bash
some_command "$@"
```

Always quote `"$@"` to preserve argument boundaries.

## 8. Test errors deliberately

Missing input:

```bash
bash scripts/run_gene_filter.sh \
  data/current/missing.tsv \
  results/session2/missing.tsv

echo "Exit status: $?"
```

Existing output:

```bash
bash scripts/run_gene_filter.sh \
  data/current/genes.tsv \
  results/session2/chr7_default.tsv

echo "Exit status: $?"
```

Invalid numeric threshold:

```bash
bash scripts/run_gene_filter.sh \
  data/current/genes.tsv \
  results/session2/invalid.tsv \
  chr7 \
  many

echo "Exit status: $?"
```

## 9. Good-practice checklist

Inspect whether the wrapper:

- uses `#!/usr/bin/env bash`
- enables `set -euo pipefail`
- quotes variable expansions
- prints errors to standard error
- uses meaningful exit statuses
- refuses unsafe overwrites
- locates helper files relative to itself
- logs meaningful actions
- separates configuration from processing logic
- remains understandable without an AI explanation.

Further production patterns include `mktemp -d`, `trap` cleanup, structured logs, explicit `--force` options, and automated tests. They are introduced conceptually rather than required in this short wrapper.

## 10. AI-review activity

Do not run this draft before review:

```bash
#!/usr/bin/env sh
set -e

#variables
input=$1
output=${2:-results/gene_summary.tsv}
config=${CONFIG_FILE:-scripts/config.sh}

# Set the wd or smth
source $config
mkdir -p $(dirname $output)
ln -s $input data/latest.tsv

#Functions
gene_count=$(grep -c "GENE" $input) #This just works
high_expression=$(awk -F ',' '$9 > 100' $input | wc -l)

echo "file,genes,high_expression" > $output
echo "$input,$gene_count,$high_expression" >> $output
echo "Finished"
```

Complete four evidence-supported defects as the core target. Continue
to six when time permits:

1. Target at least four distinct defects; six is the extension target.
2. Include at least one biological or format-related defect.
3. Rank findings by risk.
4. Correct at least three prioritized defects.
5. State a focused test for each correction.

Review through these lenses:

- arguments and interface
- quoting and word splitting
- trusted versus untrusted sourcing
- symbolic-link behavior
- input and output safety
- delimiter and header assumptions
- biological meaning of the counts
- reproducibility and error reporting

## AI-use record hand-out

```text
Task represented by the AI draft:
Assumptions made by the draft:

Defects identified:
1.
2.
3.
4.
5.
6.

Prioritized defects:
1.
2.
3.

Corrections made or proposed:

Focused tests or evidence:

Remaining limitations:

```
