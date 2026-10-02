# Session 1 follow along: Unix terminal for biologists.
> Execute commands in a native terminal from the `Module02-01/` directory.

## Purpose

Use ordinary Unix tools to understand an unfamiliar project, answer a bounded
question about a gene table, and retain evidence that the answer is correct.
This is the single canonical Session 1 follow-along resource.

## Today's story and map

Welcome to your new research team at **Clara’s lab**!

A collaborator has delivered a gene table, gene annotations, gene expression values and a candidates list. Before interpreting it, you must discover its structure, challenge your own assumptions, and verify before performing any kind of analysis.

DO NOT PROVIDE THE INPUT FILES NOR COPY-PASTE IT TO THE AI CHATBOT/AGENT.

Assume they hold sensible information and that you signed a NDA.

> **Let's begin!**

## 1. Ask the shell where you are

```bash
pwd
ls
ls -lah
```

- `pwd` prints the working directory.
- `ls -lah` includes hidden entries, permissions, human-readable sizes, and metadata.
- A relative path is interpreted from the current working directory.



## 2. Inspect the project tree

If `tree` is installed, else install it:

```bash
tree -L 3
```

The portable fallback would be:

```bash
find . -maxdepth 3 -print | sort
```

Questions:

1. Where are the raw teaching fixtures?
2. Where do reusable scripts live?
3. Why should scripts not assume the user's current directory?

## 3. Locate files by properties

```bash
tree -L 2 2>/dev/null || \
find . -maxdepth 2 -print | sort

find data -maxdepth 2 -type f -print | sort
```

`tree` visualizes hierarchy. `find` searches by properties and can feed later commands.

## 4. Inspect metadata before content

```bash
file data/teaching/genes.tsv
stat data/teaching/genes.tsv
du -h data/teaching/genes.tsv
wc -c data/teaching/genes.tsv
```

Remember:

- A `.tsv` suffix is a claim, not proof of tab-separated structure.
- File size affects whether an editor, stream command, or dedicated tool is appropriate.
- Metadata does not validate biological meaning.

However:

1. Why there is a difference of size with `stat`  and `du`  for the same file?

## 5. Preview without loading everything

```bash
head -n 5 data/teaching/genes.tsv
tail -n 5 data/teaching/genes.tsv
less data/teaching/genes.tsv
```

Useful `less` keys:

```text
Space     next page
b         previous page
/text     search
n         next match
q         quit
```

## 6. Count carefully

```bash
wc -l data/teaching/genes.tsv
wc -l data/test/mini_reads.fastq
```

Known answers:

- `genes.tsv`: 31 lines, including one header;
- `mini_reads.fastq`: 12 lines, representing 3 four-line teaching records.

Remember:

> `wc -l` counts lines. Whether a line equals a record depends on the file format and its allowed structure.

## 7. Operate around the workspace safely

```bash
mkdir -p results/session1
cp data/teaching/candidate_genes_a.txt results/session1/candidates_copy.txt
mv results/session1/candidates_copy.txt results/session1/candidates_working.txt
```

Inspect before removing generated work:

```bash
ls -l results/session1/candidates_working.txt
```

If instructed to clean that exact generated file:

```bash
rm -i results/session1/candidates_working.txt
rmdir results/
rmdir results/session1/
rm -r results/
```

Never use a broad or unresolved path with a destructive command.

## 8. Help is part of the workflow

```bash
man sort
sort --help | less
```

For any unfamiliar command, identify:

- expected input
- default output
- delimiter or comparison rules
- overwrite behavior
- exit behavior

## 9. Select fields in a tabular file

`cut`  selects delimited fields without understanding their meaning: -f determines the fields by position
`tr`translates individual characters; it is not a general word replacer.

```bash
cut -f1,2,7 data/teaching/genes.tsv | head

cut -f2 data/teaching/genes.tsv | \
 tail -n +2 | tr '[:lower:]' '[:upper:]'
```

Default `sort` is lexica: -n requests numeric order; -r reverses; -k selects a key; -t sets delimiter.
Sorting a whole table may move the header. Separate it beforehand.

```bash
{ head -n 1 data/teaching/genes.tsv; \
  tail -n +2 data/teaching/genes.tsv | \
  sort -t $'\t' -k9,9nr; } | head
```
This a more complex command: First, print the header of the tabular file; then starting from the second-to-last line read the file, pass it through a pipe to a sort command using as delimiter a tab with the following key: sort by field 9, numeric (n) and in reverse (r); finally pass it through a pipe to a head command to stdout.


## 10. Count categories with uniq

```bash
cut -f7 data/teaching/genes.tsv |
  tail -n +2 |
  sort |
  uniq -c |
  sort -nr
```

Expected counts:

```text
16 protein_coding
8 lncRNA
4 pseudogene
2 miRNA
```

Before running the pipeline, predict what removing `tail -n +2` or `sort`
would change. Read the pipeline from left to right and name the output of every
stage.

## 11. Use `grep`, `sed`, and `awk` for different jobs

Use these tools for different levels of a text-processing problem:

- `grep` selects lines that match a pattern;
- `sed` applies controlled line-oriented transformations;
- `awk` selects records, addresses fields, performs calculations, and emits
  structured output.

Select one exact tabular record with `grep`. The start anchor (`^`), complete
identifier, and literal tab prevent a longer identifier such as `GENE0071`
from being accepted accidentally:

```bash
grep -n $'^GENE007\t' data/teaching/genes.tsv

grep -Ei '^>.*kinase' data/test/mini_sequences.fasta

```
Extended regular expressions (RegEx) include all the basic meta-characters plus additional ones
•  For example, the () are group delimiters with the -E option
•  The | symbol indicates alternative matches

After any expression:
•  {N}, where N is a number, means exactly N repetitions
• {N,M}, where N<M, means between N and M repetitions

```bash
cat data/test/mini_sequences.fasta | grep -E "GCGC|TAAA"

cat data/test/mini_sequences.fasta | grep -E "(AA|GG|TT|CC)(AA|GG|TT|CC)+"

cat data/test/mini_sequences.fasta | grep -E "(CG){1,5}"
```

### 12. Transform a stream with `sed`
Sed is the stream editor, a non-interactive command-line text editor.

In `s/pattern/replacement/`, `sed` changes the first matching occurrence on
each selected line. Anchors and surrounding context make substitutions safer.
First preview the relevant input lines and the proposed transformation:

```bash
sed -n '1,5p' data/teaching/genes.tsv
sed 's/^GENE/G_/g' data/teaching/genes.tsv | head
```

The command writes transformed text to standard output; it does not alter the
supplied file. You can save a reviewed transformation as a new result rather than
editing teaching data in place:

```bash
sed 's/^GENE/G_/' data/teaching/candidate_genes_a.txt \
  > candidate_genes_short_ids.txt

diff -u \
  data/teaching/candidate_genes_a.txt \
  candidate_genes_short_ids.txt
```

Count the changed identifiers independently:

```bash
grep -c '^GENE' data/teaching/candidate_genes_a.txt
grep -c '^G_' candidate_genes_short_ids.txt
```

Identifier changes can affect later joins and provenance. A plausible-looking
prefix change is therefore not merely cosmetic.


### 13. Filter records and fields with `awk`

For a tab-separated input:

- `NR` is the current record number and `NF` is its number of fields;
- `$0` is the complete record;
- `$1`, `$2`, … address fields after splitting with `FS`;
- a pattern selects records and an action block computes or prints;
- `OFS` should be set explicitly when emitting TSV output.

Project three fields, preserving their tab-separated structure:

```bash
awk -F '\t' '
  BEGIN { OFS = "\t" }
  NR == 1 { print $1, $3, $9; next }
  $3 == "chr7" && $9 >= 100 { print $1, $3, $9 }
' data/teaching/genes.tsv
```

Now filter complete records and save a new table while preserving its header:

```bash
awk -F '\t' '
  BEGIN { OFS = "\t" }
  NR == 1 { print; next }
  $3 == "chr7" && ($9 + 0) >= 100 { print }
' data/teaching/genes.tsv \
  > results/session1/chr7_high_expression.tsv
```

Expected genes: `GENE007`, `GENE009`, and `GENE020`.

Independently inspect the identifiers:

```bash
awk -F '\t' 'NR > 1 { print $1 }' \
  results/session1/chr7_high_expression.tsv
```


## 14. How does this transfer to biological file parsing?

Compare line counts with record-aware rules:

```bash
wc -l data/test/mini_sequences.fasta
grep -c '^>' data/test/mini_sequences.fasta

wc -l data/test/mini_reads.fastq
awk 'END { print NR, NR % 4 }' data/test/mini_reads.fastq
```

For these compact fixtures, expect four FASTA headers and `12 0` for the FASTQ
line count and remainder. These are useful sanity checks, not complete format
validation:

- a FASTA record may span several sequence lines and each line length is set between 60 and 80 characters per line unless it is set as a single line.
- FASTQ sequence and quality strings must have equal lengths and are set in groups of 4 lines;


## 15. AI review checkpoint: Your first task
Your first task at this research group was to select protein_coding genes with mean expression at least 150 and provides genomic coordinates. 

Ask an AI assistant for one awk command that preserves the header and  do so.


Genomic coordinates ->  chrN:start-end


Remember:

1. Think carefully about the file you are working on
2. Trying to predict the output is key to provide accurate info to the prompt
3. Iterate its results with an independent command or manual inspection till reaching the solution


`REMEMBER: DO NOT PROVIDE THE INPUT FILES NOR COPY-PASTE IT TO THE AI CHATBOT/AGENT.`
`Assume it holds sensible information and that you signed a NDA. `


And if were to be iRNA (lncRNA + miRNA) simultanously over 10 mean expression?


## 16. Combine and compare tables by relationship

Choose the command from the relationship between the inputs:

- `paste` combines rows of two files by position sequentially. Can use -d to set delimiter.
- `join` combines lines of two files on a common field or key. Can use -i to ignore case
  -1 join on this field of file 1 and -2 join on this field of file 2
- `comm` compares two sorted one-column files.
  -1 suppresses column 1 (file 1) whereas -2 suppresses column 2 (file2).
  -3 suppresses lines present in both files and -12 print lines present in both file 1 and 2

Find identifiers shared by the two candidate lists. Process substitution
provides each sorted stream without overwriting either input:

```bash
paste data/teaching/candidate_genes_a.txt data/teaching/candidate_genes_b.txt | head

comm -12 \
  <(sort data/teaching/candidate_genes_a.txt) \
  <(sort data/teaching/candidate_genes_b.txt) \
  | tee results/session1/shared_candidate_genes.txt
```

Expected shared identifiers:

```text
GENE003
GENE007
GENE014
GENE025
```

Check that the result contains four identifiers:

```bash
wc -l shared_candidate_genes.txt
```

Combine annotation and expression tables by `gene_id`, not by row position:

```bash
join --header -t $'\t' -1 1 -2 1 \
  data/teaching/gene_annotations.tsv \
  data/teaching/expression_values.tsv \
  > gene_annotation_expression.tsv

head -n 5 gene_annotation_expression.tsv
```

## 17. Extra commands for niche uses: split and shuf

- `split` splits a file into pieces.
  -l, allows to set the number of lines/records per output partition file.
  -n, generate chunks of the input file as output files.
- `shuf`  is used to generate random permutations out of the contents of a file.
  By setting –randomsource=<(yes N) you are setting a specific random seed as fixed.



```bash
{
  head -n 1 data/teaching/genes.tsv
  tail -n +2 data/teaching/genes.tsv | \
    shuf --random-source=<(yes 42)
} > gene_sample.tsv

tail -n +2 gene_sample.tsv | split -l 10 - gene_split_
```
Let's explain the above command rationale:
1. Keep the header separate; shuffle data rows only.
2. A seed (in this case 42) aids reproducibility, but keep in mind GNU-specific options reduce portability vs other randomizer tools
3. Remember that random rows are not automatically a biologically representative sample.
4. Afterwards, perform an equal split based on lines (excluding the header). In this case it would have worked with `-n 1/3`

As an extra think about why the commands below can damage biological record boundaries:

```bash
shuf data/test/mini_reads.fastq
split -l 5 data/test/mini_reads.fastq read_part_
```

Do not treat these outputs as valid transformed biological files.


## 18. Work with compressed streams

`gzip` changes storage, not the logical tabular structure. Use `gzip -c` to
create a compressed result without replacing its source, and use `zgrep` or
`zcat` to inspect decompressed text as a stream:

```bash
gzip -c data/teaching/genes.tsv \
  > genes.tsv.gz

zgrep $'^GENE007\t' genes.tsv.gz
zcat genes.tsv.gz | wc -l
wc -l data/teaching/genes.tsv
```

The decompressed and original line counts should agree. The bioinformatics standard is to avoid creating an
unnecessary persistent decompressed copy of a large input if possible.
