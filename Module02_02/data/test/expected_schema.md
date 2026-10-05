# Session 2 compact fixtures — expected checks

`alignments.bam` is generated from `alignments.sam` by
`instructor/build_test_bam.py`. It contains the same three teaching alignment
records and allows format-aware BAM access without opening the blinded
capstone.

These deliberately tiny files support manual inspection and known-answer
validation. They are not a realistic sequencing release; Session 3 uses
`data/capstone_blind/`.

## Expected valid properties

- `reference.fasta`: one non-empty `chr1` record of 100 bases.
- `reads.fastq`: complete four-line records with equal sequence and quality
  lengths.
- `alignments.sam` and `alignments.bam`: matching header and three records; the
  SAM representation exposes the eleven mandatory fields.
- `variants.vcf`: VCF metadata, one `#CHROM` header, and tab-separated
  records.
- `annotation.gff3`: comments plus nine-field feature records.
- `targets.bed`: tab-separated intervals using 0-based, half-open coordinates.

## Known-answer defects

| File | Expected defect | Validation layer |
|---|---|---|
| `reads_with_issue.fastq` | One sequence/quality length mismatch | Structure |
| `alignments.sam` | One alignment extends beyond the 100-base reference | Cross-file |
| `variants.vcf` | One record uses `chr2`, which is absent from the FASTA | Cross-file |
| `annotation.gff3` | One feature has end smaller than start | Coordinate/schema |
| `targets.bed` | One interval has `end == start` | Coordinate/schema |

## Coordinate reference

- GFF3/GTF: normally 1-based and closed.
- BED: 0-based and half-open.
- VCF POS and SAM POS: 1-based.
- GFF3 interval `11–60` corresponds to BED `10–60`.
- One-base GFF3 interval `101–101` corresponds to BED `100–101`.

Students should first predict which records fail, then verify with independent
CLI and Python checks. A successful parse does not establish biological or
cross-file validity.
