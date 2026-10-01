# Homework — Build a gene and sequence profile

> **Expected time: 60 minutes.** Set up links from `Module02_01/homework/`, then run the exercise from `Module02_01/homework/exercise_data/`. The supplied data are synthetic teaching examples, not biological measurements.

## Goal

**Mike** has messed it up! Apparently the inputed `genes.tsv` file had incorrect gc_content from other sequence records. Plus disk space is limited, so it is required to work smartly instead of copying all the files all over again.

Write a Bash wrapper that combines four inputs by `gene_id`: `genes.tsv`, `expression_values.tsv`, `gene_annotations.tsv`, and `homework_sequences.fasta`. Access them through symbolic links in `homework/exercise_data/`. Calculate GC percentage from each FASTA sequence, then redirect the wrapper's TSV output into `homework/exercise_data/gene_profile.tsv`.

Use the [short report template](workflow_report_template.md).

## AI DISCLAIMER

You can use and AI chatbot or assitant to do the exercise, but do not paste/nor suply the data. You can do so with the scripts itself.

## Supplied material

- `data/teaching/homework_sequences.fasta` has 30 synthetic, multiline, 1,000-base records. The first token after `>` is a `gene_id`; the remaining header text is descriptive. Every ID occurs once in each of the four inputs.
- `scripts/summarize_fasta.sh` is a simple record counter. `scripts/summarize_fasta_scaffold.sh` adds input and output safety checks. **Neither computes per-record GC.** Inspect and run both, then copy the scaffold into your submission and extend the copy.
- `data/test/mini_sequences.fasta` is a small positive test for the supplied counters. `data/test/not_fasta.txt` is a negative test for your new FASTA summarizer.
- `data/teaching/SOURCE.md` explains the synthetic data. As stated above, the existing `gc_percent` in `genes.tsv` is a wrongfully supplied field; its values differ from the new FASTA values. Calculate `sequence_gc_percent` from FASTA bases rather than copying that field.

## Set up one working directory

From `Module02_01/homework/`, create `exercise_data/` and link every supplied file needed for the exercise. These are relative links: each target is resolved from `exercise_data/`, where the link lives. Do not copy or edit the supplied files. I provide a small example.

```bash
ln -s ../../data/teaching/genes.tsv exercise_data/genes.tsv
readlink exercise_data/genes.tsv
```

Confirm that linked inputs can be read, for example with `head -n 2 genes.tsv` and `head -n 2 not_fasta.txt`. If a link is broken, fix its target before continuing. From this point, use the short file names in `exercise_data/` for every input. Write **all generated TSVs and the final result** in `exercise_data/`; never redirect output to a linked input name.


## Required work

1. Inspect the four linked inputs with `head`, `wc`, `cut`, or similar commands. Check the TSV headers and verify that FASTA headers contain `GENE001` through `GENE030`. Compare the two linked scripts with `diff -u` or by reading them. Run `bash summarize_fasta.sh mini_sequences.fasta count_simple.tsv` (expect 4 records) and `bash summarize_fasta_scaffold.sh homework_sequences.fasta count_scaffold.tsv` (expect 30 records). Both result files belong in `exercise_data/`. Explain which script refuses an existing output.
2. Copy the linked scaffold into your own script with `cp -L summarize_fasta_scaffold.sh ../scripts/summarize_fasta_gc.sh`. Edit the copy, not the symlink or its supplied target. Preserve its missing-input, same-path, existing-output, and no-header checks. Replace the aggregate count output with this exact TSV header: `gene_id<TAB>sequence_length<TAB>sequence_gc_percent`. For every FASTA record, concatenate all sequence lines; count only `G` and `C` bases; calculate `100 × (G + C) / sequence_length`; and print one decimal place. The record ID is the first whitespace-delimited token after `>`. Do not count header text, line breaks, or other records' bases. An empty sequence must fail rather than cause division by zero. You may use `awk` for record-by-record processing.
3. Write `../scripts/build_gene_profile.sh`. Its four positional arguments are `GENES_TSV EXPRESSION_TSV ANNOTATIONS_TSV FASTA`. Check that all four inputs exist, invoke your GC summarizer, and combine the four datasets on `gene_id` using `join` or `awk`. Print only the final TSV to standard output; send errors or progress messages to standard error. Keep the linked inputs unchanged. Create any intermediate TSVs in `exercise_data/` and remove them when the wrapper finishes.
4. Redirect the wrapper's standard output into `exercise_data/gene_profile.tsv`. Since you are working from that directory, use:

   ```bash
   set -C  # refuse to overwrite an existing file with >
   bash ../scripts/build_gene_profile.sh \
     genes.tsv expression_values.tsv gene_annotations.tsv homework_sequences.fasta \
     > gene_profile.tsv
   echo "Exit status: $?"
   ```

   Do not use `>|` or redirect to any symlinked input. Use fresh diagnostic output names while iterating and reserve `gene_profile.tsv` for the final run. Check the exit status before treating the file as a result; shell redirection can create an empty file even if the wrapper fails. The successful result must have 31 lines: one header plus 30 data rows. Preserve the nine columns of `genes.tsv` in their original order, then append `control_mean`, `treatment_mean`, `pathway`, `evidence`, `sequence_length`, and `sequence_gc_percent` in that order. The resulting header is:

   ```text
   gene_id	symbol	chromosome	start	end	strand	biotype	gc_percent	mean_expression	control_mean	treatment_mean	pathway	evidence	sequence_length	sequence_gc_percent
   ```

5. Check that the output IDs match the IDs in `genes.tsv` and that each appears once; a row count alone does not detect a swapped or duplicated key. Run your summarizer with linked `not_fasta.txt` and a new output path in `exercise_data/`: it must exit nonzero and leave no result file. Record the wrapper's success status, the failure status, and your observations.
6. Ask an AI assistant for **one** additional failure test for this wrapper. Record the suggestion, whether you accepted it, and the command or evidence used to check it. Do not paste the supplied data into the assistant.

Optional: If you finish early, add a check that rejects sequence characters outside `A`, `C`, `G`, and `T`.

## Submission

```text
homework/
├── workflow_report.md
└── exercise_data/                  # student-created links and generated TSVs
    ├── genes.tsv -> ../../data/teaching/genes.tsv
    ├── ... other supplied links ...
    ├── count_simple.tsv
    ├── count_scaffold.tsv
    └── gene_profile.tsv
scripts/
    ├── summarize_fasta_gc.sh
    └── build_gene_profile.sh
```

Submit your scripts, report, and generated `exercise_data/gene_profile.tsv`. Record the link targets in the report; do not copy the supplied data files. Use [workflow_report_template.md](workflow_report_template.md) for a brief command and test record.

## Assessment

| Criterion | Weight |
|---|---:|
| Correct per-record FASTA length and GC calculation | 30% |
| Complete, key-correct four-input join and required TSV shape | 30% |
| Correct links, output redirection, and successful failure test | 20% |
| Clear verification and concise report, including AI review | 20% |
