# *Haemophilus influenzae* teaching dataset

## Pinned source

- Organism: *Haemophilus influenzae* Rd KW20
- RefSeq assembly: `GCF_000027305.1`
- Assembly name: `ASM2730v1`
- Principal sequence identifier used by the annotation: `NC_000907.1`
- Declared CDS translation table: 11
- Genomic FASTA retrieval date: 2026-09-22
- Genomic FASTA source: `https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/027/305/GCF_000027305.1_ASM2730v1/GCF_000027305.1_ASM2730v1_genomic.fna.gz`

## Files

| Path | Role |
|---|---|
| `reference.fna` | Complete genomic nucleotide reference |
| `annotation.gff3` | Full reference annotation |
| `proteins.faa` | Annotated protein sequences |
| `subsets/single_cds.gff3` | One simple CDS for first parser checks |
| `subsets/mixed_strands.gff3` | Positive- and negative-strand examples |
| `subsets/multisegment_cds.gff3` | Repeated protein identifier across CDS rows |
| `subsets/homework_features.gff3` | Bounded homework feature selection |
| `expected/` | Known-answer feature counts and identifier comparisons |
| `checksums.sha256` | Integrity checks for the generated teaching release |

The full annotation contains more CDS rows than distinct protein identifiers.
That difference is intentional teaching evidence: a file row, an annotation
feature, and a biological product are not interchangeable concepts.