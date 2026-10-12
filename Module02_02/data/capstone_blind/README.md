# Blinded bacterial release candidate

This directory contains a small bacterial genomics release candidate for the
Module02-02 hands-on practical. The reference and annotation were derived from
a public, complete bacterial genome. The organism identity is intentionally
withheld so that the practical focuses on file structure, validation, and
evidence-based release decisions.

The read and variant data are simulated and contain no patient or participant
information. Do not use sequence-similarity searches to identify the organism
during the exercise.

## Files

| File | Role |
|---|---|
| `reference.fasta` | Blinded circular reference sequence |
| `annotation.gff3` | De-identified reference annotation |
| `reads_R1.fastq.gz` / `reads_R2.fastq.gz` | Simulated paired-end reads |
| `alignments.sam` | Text alignment file |
| `alignments.bam` / `alignments.bam.bai` | Coordinate-sorted binary alignments and index |
| `variants.vcf` | Candidate small variants for `sample_A` |
| `targets.bed` | Candidate target intervals |
| `manifest.json` | Release expectations and simulation summary |
| `checksums.sha256` | SHA-256 integrity checksums |

## Known conventions

- All files use the neutral reference identifier `ref_01`.
- The reference has 580,076 bases and is circular.
- The annotation uses 1-based, closed coordinates.
- BED uses 0-based, half-open coordinates.
- VCF positions are 1-based; every `REF` value must match the reference.
- The supplied genetic code is translation table 4.

## Start the intake check

From this directory:

```bash
sha256sum -c checksums.sha256
gzip -t reads_R1.fastq.gz reads_R2.fastq.gz
head reference.fasta
head annotation.gff3
head variants.vcf
```

Passing the checksum test only confirms file integrity. It does not establish
that every record is structurally, biologically, or cross-file consistent.

## Release question

Treat the directory as a release candidate. Identify and prioritise defects,
support each finding with reproducible evidence, and decide whether the release
should pass, pass with warnings, or fail.
