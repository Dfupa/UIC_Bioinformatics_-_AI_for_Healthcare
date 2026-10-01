# Teaching-data provenance

The files in this directory are synthetic, format-realistic teaching fixtures created for Module02-01. They are not derived from patients, study participants, or a specific reference genome.

The gene identifiers, symbols, coordinates, annotations, GC percentages, and expression values are intentionally small and simplified. They support Unix command-line exercises without making biological claims.

## Intended use

- `genes.tsv`: navigation, inspection, column selection, sorting, counting, filtering, and sampling.
- `gene_annotations.tsv`: key-based integration with `join` or `awk`.
- `expression_values.tsv`: aligned-column and key-based integration exercises.
- `candidate_genes_a.txt` and `candidate_genes_b.txt`: sorted-list comparison with `comm`.
- `homework_sequences.fasta`: 30 synthetic FASTA records keyed by the `gene_id` values in the three TSV files. Each record contains 1,000 bases wrapped at 80 characters per line.

The FASTA bases were generated with Python's `random.Random(20261001)`. For each record, a GC count between 350 and 650 out of 1,000 bases was drawn independently of the `genes.tsv` `gc_percent` field; G/C and A/T bases were then chosen and shuffled. The FASTA values differ from the supplied `gc_percent` values. They are artificial sequences assigned to identifiers, not sequences from the listed genomic coordinates or full gene models.

