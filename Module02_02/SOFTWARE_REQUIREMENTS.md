# Software requirements for Module02_02

Complete this setup before the session starts. Do not wait until the first notebook
exercise to discover that the Python environment or BAM tools are unavailable.

## Required software

| Software | Course use | Requirement |
|---|---|---|
| Python 3.10–3.12 | Scripts and notebooks | Required |
| JupyterLab 4 | Follow-along notebooks | Required |
| Biopython | Sequence objects, FASTA/FASTQ parsing, and translation | Required |
| NumPy | Compact numerical summaries | Required |
| pandas | Evidence and findings tables | Required |
| Matplotlib | One-purpose biological figures | Required |
| pysam | SAM/BAM inspection from Python | Required |
| `samtools` | BAM integrity, headers, and indexing | Strongly recommended |
| `gzip` and `sha256sum` | Compressed reads and delivery-integrity checks | Required for the capstone |


## Create the Python environment

From the repository root:

```bash
cd Module02-02
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

On later days, reactivate the same environment with:

```bash
cd Module02-02
source .venv/bin/activate
```

## Optional system-tool installation

Ubuntu or WSL2:

```bash
sudo apt update
sudo apt install samtools
```

macOS with Homebrew:

```bash
brew install samtools
```

The notebooks provide a `pysam` route where practical, but being able to run
`samtools` from a terminal is strongly recommended for Session 2 and the
capstone.

## Verify before class

With `.venv` active, run:

```bash
python --version
python -m pip check
jupyter --version
python -c "import Bio, numpy, pandas, matplotlib, pysam; print('Python environment: PASS')"
samtools --version | head -n 1
```

Then confirm that the course data are present:

```bash
test -f data/teaching/phix174.fasta && echo "PhiX teaching data: PASS"
test -f data/test/reference.fasta && echo "format fixtures: PASS"
test -f data/capstone_blind/checksums.sha256 && echo "capstone delivery: PASS"
```

Start Jupyter from `Module02-02/`:

```bash
jupyter lab
```

In a new notebook cell, verify:

```python
from pathlib import Path
assert Path("data/teaching/phix174.fasta").is_file()
print("Notebook working directory: PASS")
```

## Download-free session policy

All data required by students must already be present in the repository.
Dataset acquisition and curation are instructor build steps, not live classroom
steps. If any `PASS` check fails, resolve it before the session.

## Before-class checklist

- [ ] Python reports a supported version from 3.10 through 3.12.
- [ ] `python -m pip check` reports no broken requirements.
- [ ] The Python import check prints `PASS`.
- [ ] Jupyter starts from `Module02-02/`.
- [ ] The three data checks print `PASS`.
- [ ] `samtools` runs, or the instructor has confirmed a `pysam`-only path.
