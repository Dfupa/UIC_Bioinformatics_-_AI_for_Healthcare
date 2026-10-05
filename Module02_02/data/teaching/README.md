# Session 1 teaching data

These compact public-data excerpts support manual parsing and known-answer
tests. They contain no participant metadata used for clinical interpretation.

## `phix174.fasta`

- Coliphage PhiX174 complete genome, accession `J02482.1`.
- One FASTA record, 5,386 bases.
- Expected GC fraction: `0.44764203490531007`.
- SHA-256: `f9b7390d0a5f568bcb054ab3c9ac5c91bfca100f4fcb7ef9b1766f5f476c954f`.
- Adapted from the public sequence included with the legacy `Python/`
  teaching archive.

## `phix_reads_100.fastq`

- First 100 records from the public `ERR266411_1.first1000.fastq` excerpt in
  the legacy teaching archive.
- Four hundred lines using the simple four-line FASTQ representation.
- The first reads originate from PhiX control sequence and are suitable for
  structure and quality-score exercises.
- SHA-256: `9145e997437b27104e87982cdb607509dda86d16edf21a88eacc19193306620c`.

These files are used for teaching record structure and validation. They should
not be interpreted as a complete sequencing run or a representative QC sample.

### `orchid/`

The orchid FASTA and GenBank files contain the same 94 sequence records in a
sequence-oriented and an annotation-rich representation. Session 1 compares
their modern Biopython `SeqRecord` content after the compact PhiX work.

