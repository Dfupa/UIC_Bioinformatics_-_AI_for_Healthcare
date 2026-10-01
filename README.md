
# Master's Degree in Bioinformatics & AI for Healthcare

Here I will store all the teaching materials for UIC's master's programme **Bioinformatics & AI in Health**. This github repository is going to be structured by its own Module and thematic block (ie: Module02_01 would be Module 2, thematic block 1)

## Module 02: Applied Bioinformatics & Agentic Workflows

Teaching materials for **Applied Bioinformatics & Agentic Workflows** in UIC's master's programme **Bioinformatics & AI in Health**. The course connects biological data work with practical command-line and programming skills. Students may use AI coding assistants to draft ideas and code, then check the results, assumptions, and failure behaviour themselves.

This is a growing course repository. Materials will be added as classes progress.

### Module map

| Module | Focus |
|---|---|---|
| [Module02_01](Module02_01/) | Thematic block 1: Unix terminal, biological text files, `grep`/`awk`/`sed`, and Bash script organization |
| Module02_02 | Thematic block 2: Python scripting, bioinformatics file formats |

### Find your way through Module02_01

| Start here | What it contains |
|---|---|
| [Session 1 guide](Module02_01/guides/S1_Unix_terminal_for_biologists.md) | Navigate files and inspect, filter, use editors (`awk`/`sed`) and combine biological text data. |
| [Session 2guide](Module02_01/guides/S2_bash_scripting_and_organization.md) | Organize Bash scripts, build wrappers, use configuration and symbolic links, and test failures. |
| [Teaching data](Module02_01/data/teaching/) and [test fixtures](Module02_01/data/test/) | Small synthetic inputs and known-answer checks. The [data note](Module02_01/data/teaching/SOURCE.md) explains their provenance. |
| [Scripts](Module02_01/scripts/) | Runnable examples of code |
| [Homework](Module02_01/homework/assignment.md) | A 60-minute exercise after Session 2, with a [report template](Module02_01/homework/workflow_report_template.md). |

Run the session guides from `Module02_01/guides`. For homework, follow its setup instructions from `Module02_01/homework/`: create `exercise_data/`, link the supplied files there, and write generated results there. The supplied datasets are synthetic and are for teaching, not biological or clinical interpretation.

The emphasis here is on understanding what a command or script does, checking its output, and explaining any correction you make, including corrections to AI-generated code.
