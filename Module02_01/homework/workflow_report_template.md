# Module02-01 homework report — gene and sequence profile

Name:  
Date:  

## Symbolic-link setup

Record the `ln -s` commands used from `homework/` and the result of `readlink` for one teaching-data link, one test-data link, and one script link. Confirm that each resolves to a readable file.

```bash
# Link creation and checks
```

## Inputs and plan

| Input | Header/key check | Record or row count |
|---|---|---:|
| `genes.tsv` |  |  |
| `expression_values.tsv` |  |  |
| `gene_annotations.tsv` |  |  |
| `gene_sequences.fasta` |  |  |

How do you obtain the FASTA `gene_id`, `sequence_length`, and `sequence_gc_percent`? How do you prevent missing or duplicate keys from disappearing in a join? (2–4 sentences.)

## Commands and results

```bash
# Commands run from homework/exercise_data/ to compare/run the supplied
# scripts and redirect the wrapper's output to gene_profile.tsv
```

Output path (`homework/exercise_data/gene_profile.tsv`) and exact header:  
Observed number of data rows:  

| Check | Expected | Observed |
|---|---|---|
| Supplied simple counter on `mini_sequences.fasta` | 4 records |  |
| Supplied scaffold on `gene_sequences.fasta` | 30 records |  |
| Wrapper success exit status | 0 |  |
| `GENE001` sequence length and GC | `1000`, `47.1` |  |
| `GENE030` sequence length and GC | `1000`, `60.2` |  |
| Output ID set versus `genes.tsv` | Same 30 IDs, once each |  |
| `not_fasta.txt` test | Nonzero exit status; no output file |  |

## AI suggestion

Suggested failure test:  
Accepted or corrected, and why:  
Command or evidence used to check it:  

## Conclusion

In 3–5 sentences, state what the output TSV contains, one safeguard in your wrapper, and one limitation of using these synthetic sequences.
