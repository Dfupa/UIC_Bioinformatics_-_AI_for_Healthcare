# Assignment: From *H. influenzae* annotation to protein evidence

## Scenario

Tyrone, the postdoc of the group ask you to run parsing and validation analysis on a dataset he was working on: The haemophilius influenzae species. 

You received a pinned *Haemophilus influenzae* Rd KW20 reference, a bounded
GFF3 feature set, and the matching annotated protein FASTA. Extract selected
CDS sequences, translate them with the declared bacterial genetic code, and
compare your computed proteins with the supplied annotations.


Use:

```text
data/teaching/haemophilus_influenzae/reference.fna
data/teaching/haemophilus_influenzae/subsets/homework_features.gff3
data/teaching/haemophilus_influenzae/proteins.faa
notebooks/04_homework_haemophilus_cds_to_protein.ipynb
```

Tyrone tells you that the declared CDS translation table for H. influenzae is **11** and tips you to verify the dataset README and
GFF3 metadata rather than inferring conventions from filenames.

## Required functions

Implement and test:

```python
parse_gff3_attributes(text) -> dict[str, str]
group_cds_by_protein(gff_path) -> dict[str, dict]
reverse_complement(sequence) -> str
extract_cds(reference, segments, strand) -> str
```

Function expectations:

- parse the ninth GFF3 field as semicolon-delimited `key=value` items;
- GFF3 coordinates are 1-based and closed; Python slices are 0-based and
  half-open;
- validate strand as `+` or `-` and phase as `0`, `1`, or `2`;
- group repeated CDS rows by `protein_id` instead of assuming one row per
  protein;
- order segments in biological 5′→3′ order before applying phase;
- reverse-complement negative-strand CDS correctly;
- never modify supplied data in place.

Use Biopython `SeqIO` for production FASTA parsing and `Bio.Seq.Seq` for
translation. A small manual example may be used to explain the mental model.

## Tasks and suggested time

| Task |
|---|
| Inspect files and state assembly, coordinate, strand, phase, and translation-table assumptions |
| Parse attributes and group CDS rows by protein identifier |
| Implement strand-aware, multi-segment coordinate extraction |
| Apply phase and translate with table 11 |
| Compare computed and annotated proteins |
| Produce `protein_validation.tsv` and one compact figure |
| Complete reasoning and AI-use records |

Analyse at least six proteins, including two positive-strand single-row CDS,
two negative-strand single-row CDS, one multi-row CDS, and one additional
feature chosen and justified by the student.

## Required tests

Include at least:

```python
assert reverse_complement("GATACA") == "TGTATC"
assert extract_cds("AACCGGTT", [(2, 5, 0)], "+") == "ACCG"
assert extract_cds("AACCGGTT", [(2, 5, 0)], "-") == "CGGT"
```

Add tests for lowercase input, an invalid coordinate, invalid strand, invalid
phase, a repeated `protein_id`, and a protein identifier absent from the
protein FASTA.

## Translation validation

Translate with:

```python
from Bio.Seq import Seq

protein = Seq(cds_sequence).translate(table=11)
```

Do not use `to_stop=True` to hide internal stop codons. Normalize only a
terminal stop when the documented comparison requires it, and record that
decision. 

A mismatch limited to the first residue may reflect a bacterial
alternative start codon: inspect the nucleotide codon and annotation before
testing `cds=True`, which is appropriate only when the sequence is a complete
CDS with a valid start and terminal stop. Record both the evidence and the
chosen comparison rule; do not replace the residue by hand.

For each selected protein report protein identifier; contig; segment count;
start; end; strand; phase; nucleotide and translated lengths; annotated
protein length; exact-match status; internal-stop status; and an evidence note.
Do not silently correct mismatches.

## AI-use requirement

Ask for one bounded helper or review, not a complete solution. 

You can provide 

## Deliverables

```text
Module02_02/homework/
├── H1_haemophilus_cds_to_protein.ipynb
├── protein_validation.tsv
├── README.md
└── ai_use.md
```

`README.md` must state assumptions, tests, one biological observation, and one
limitation. `ai_use.md` must contain the bounded prompt, its answers,
tests (if generated), correction if any, and acceptance/rejection decisions (if any).

## Assessment of the task at hand

| Criterion | Weight | Evidence |
|---|---:|---|
| Functional correctness | 35% | Grouping, extraction, translation, and comparison work |
| Error detection and correction | 30% | Coordinates, phase, strand, multi-row features, stops, and missing IDs are tested |
| Reasoning and documentation | 20% | Assumptions, evidence, biological interpretation, and limitations are clear |
| Technical and format compliance | 15% | Required files and columns, table 11, and raw-data preservation |
