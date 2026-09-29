# Project Name

This is a Apple Foundations Model CLI, that replicates the functionality of Claude Code.

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Overview

This allows the user to use their local Apple Foundations Model present on their Mac to do some light code editing. It's not as capable as a larger model, but this CLI allows for the user to create, edit, and write to files based on natural language input.

## Features

- Creating new files
- Edit existing files
- No internet connection required, running off the Apple Foundations Model present on MacOS

## Getting Started

### Prerequisites

- MacOS 27.0 Golden Gate
- Apple Intelligence-capable device

### Installation

```bash
# Clone the repository
git clone https://github.com/michaelajuarez/fmcode
cd fmcode

# Install dependencies
swift build
```

## Usage

```bash
# Run the project
swift run
```

Example:

```bash
> Write FizzBuzz to a new file
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
│       └── Tools.swift      # Model tools (file create/edit, etc.)
└── README.md
```

## Testing

```bash
swift run
```

## Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m "Add my feature"`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a pull request

## License

Distributed under the MIT License. See `LICENSE` for details.

## Contact

Your Name - [@michaelajuarez](https://github.com/michaelajuarez) - michael@juarezfamily.com

Project link: https://github.com/michaelajuarez/fmcode