# Orchid FASTA/GenBank comparison

The generated files in this directory are curated from
`Python/biopython_notebook/other/` and contain the same 94 orchid sequence
records represented as sequence-oriented FASTA and richer GenBank records.

Session 1 uses a bounded selection to compare what `SeqIO` can retain from the
two formats: identifiers and sequences in both, plus descriptions, annotations,
references, and sequence features in GenBank.

The associated legacy notebook used removed `Bio.Alphabet` APIs. Current
teaching code uses modern `Bio.Seq`, `Bio.SeqRecord`, and `Bio.SeqIO` APIs and
performs alphabet checks explicitly.
