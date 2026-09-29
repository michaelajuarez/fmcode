# FM Code

A CLI wrapper around Apple's on-device Foundation Models, built to bring Claude Code-style tool use to a fully local model on MacOS.

## Overview

FM Code runs entirely on-device using Apple's Foundation Models framework. There's no internet connection required, and no data leaves the machine. The model can read, list, and edit files in a project directory based on natural language input in a REPL, choosing which tool to call on its own rather than following a fixed command syntax.

It's smaller and less capable than a hosted model like Claude or ChatGPT, so this isn't trying to replace something like Claude Code or Codex. It's an alternative meant for smaller, local tasks where you don't want to call back to a model provider.

## Features

- REPL interface for interactive sessions
- Model-driven tool selection: the model decides when to list a directory, read a file, or edit one, based on what you ask for
- File tools: list directory contents, read files, edit files, create and write new files
- Graceful failure handling: a failed tool call (bad path, missing file) returns an error to the model and the session continues instead of crashing

## Getting Started

### Prerequisites

- macOS 26.0 (Tahoe) or later
- Apple Intelligence-capable device

### Installation

```bash
git clone https://github.com/michaelajuarez/fmcode
cd fmcode
swift build
```

## Usage

```bash
swift run
```

Example session:

```
> list the files in this directory
> read Package.swift
> change beta to BETA in scratch.txt
```

## Project Structure

```
.
├── Package.swift          # Swift package manifest
├── Sources/
│   ├── core/
│   │   └── helper.swift    # Shared helper utilities
│   └── fmcode/
│       ├── main.swift       # CLI entry point / REPL
│       └── Tools.swift      # Model tools (list, read, edit, write)
└── README.md
```

## Roadmap

- Command execution (`run_command`) with approval prompts before writes, edits, and shell commands
- Live tool-activity display during a session
- One-shot mode (`fmcode "prompt"`) for non-interactive use
- Release build and PATH installation
- Make a more pleasant UI/UX

## Contact

Michael Juarez - [@michaelajuarez](https://github.com/michaelajuarez)