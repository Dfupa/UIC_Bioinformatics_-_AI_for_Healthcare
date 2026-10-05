
# Master's Degree in Bioinformatics & AI for Healthcare

Here I will store all the teaching materials for UIC's master's programme **Bioinformatics & AI in Health**. This github repository is going to be structured by its own Module and thematic block (ie: Module02_01 would be Module 2, thematic block 1)

## Module 02: Applied Bioinformatics & Agentic Workflows

Teaching materials for **Applied Bioinformatics & Agentic Workflows** in UIC's master's programme **Bioinformatics & AI in Health**. The course connects biological data work with practical command-line and programming skills. Students may use AI coding assistants to draft ideas and code, then check the results, assumptions, and failure behaviour themselves.

This is a growing course repository. Materials will be added as classes progress.

### Module map

| Module | Focus |
|---|---|
| [Module02_01](Module02_01/) | Thematic block 1: Unix terminal, biological text files, `grep`/`awk`/`sed`, and Bash script organization |
| [Module02_02](Module02_02/) | Thematic block 2: Python sequence analysis, bioinformatics file formats, validation, and release-readiness decisions |

### Find your way through Module02_01

| Start here | What it contains |
|---|---|
| [Session 1 guide](Module02_01/guides/S1_Unix_terminal_for_biologists.md) | Navigate files and inspect, filter, use editors (`awk`/`sed`) and combine biological text data. |
| [Session 2 guide](Module02_01/guides/S2_bash_scripting_and_organization.md) | Bash wrappers, configuration, symbolic links, and script review. |
| [Colab notebooks](Module02_01/notebooks/) | Both sessions as executable notebooks, with optional terminals and Google Drive inputs. |
| [Teaching data](Module02_01/data/teaching/) and [test fixtures](Module02_01/data/test/) | Small synthetic inputs and known-answer checks. The [data note](Module02_01/data/teaching/SOURCE.md) explains their provenance. |


Run the Session 1 and 2 guides from `Module02_01/guides`.

### Find your way through Module02_02


| Start here | What it contains |
|---|---|
| [Session 3 student notebook](Module02_02/notebooks/S03_python_sequence_analysis.ipynb) | Primary guided notebook for the teaching session. |
| [Teaching data](Module02_02/data/teaching/) | PhiX174 FASTA, a 100-read FASTQ excerpt, and matching orchid FASTA/GenBank records. See the [data notes](Module02_02/data/teaching/README.md). |
| [Format-validation fixtures](Module02_02/data/test/) | Compact FASTA, FASTQ, SAM/BAM, VCF, GFF3, and BED examples containing known valid properties and deliberate defects. |

Materials for Sessions 4 and 5 will continue to be added to `Module02_02`.

## Software requirements

Complete the setup before working through `Module02_02`. The full installation,
verification commands, and before-class checklist are in
[Software requirements](Module02_02/SOFTWARE_REQUIREMENTS.md).

| Software | Use | Status |
|---|---|---|
| Python 3.10–3.12 | Run scripts and notebooks | Required |
| JupyterLab 4 | Work through the guided notebooks | Required |
| Biopython | Parse and analyse FASTA, FASTQ, and annotated sequence records | Required |
| NumPy, pandas, and Matplotlib | Numerical summaries, evidence tables, and biological figures | Required |
| `pysam` | Inspect SAM/BAM files from Python | Required |
| `gzip` and `sha256sum` | Validate compressed reads and file integrity | Required for the Session 5 workflow |
| `samtools` | Check BAM integrity, headers, and indexes | Strongly recommended |

Start Jupyter from the `Module02_02/` directory so thatSpark is not required. 
the notebooks can resolve the supplied data paths consistently.


## Bioinformatics file formats cheat sheet

Use this as a memory aid after inspecting the session examples. It does not
replace format documentation or format-aware validation.

| Format | Biological object | Critical convention | Preferred tool | Consequential cross-file check |
|---|---|---|---|---|
| FASTA | Named nucleotide or protein sequence | Sequence can wrap; identifiers must be stable | Biopython `SeqIO` | Identifier and sequence length |
| FASTQ | Read and per-base qualities | Sequence and quality lengths agree | Biopython `SeqIO` | Mate identifiers and counts |
| SAM/BAM | Read alignments | Flags, CIGAR, reference header, sorting | `pysam` or `samtools` | Reference names and lengths |
| VCF | Variants and optional genotypes | POS is 1-based; `REF` depends on the reference | Controlled parser or VCF-aware tool | `REF` versus FASTA |
| GFF3/GTF | Genome annotation | Nine fields; 1-based closed; attribute grammars differ | Controlled parser or annotation library | IDs, parents, bounds, protein identifiers |
| BED | Genomic intervals | 0-based half-open | Controlled parser or interval-aware tool | Bounds and overlaps |
