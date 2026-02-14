
---

# Happy Function

Symbolic differentiation engine written in **Dart** (CLI-based).

## Overview

Happy Function is a command-line tool for computing:

* First-order derivatives
* Partial derivatives
* Laplacian (∇²)
* Step-by-step symbolic solutions

The project is currently built for **Windows (CLI)**, with plans to add a **Flutter GUI** and cross-platform support in future versions.

---

## Features

* Symbolic derivative computation
* Recursive expression evaluation
* Step tracking during differentiation
* Support for nested and complex expressions

---

## Project Structure

### Installation

* [Install packages](https://github.com/TahaFawzyElshrif/Happy-Function/tree/main/HappyFunction/install/install)
* [Install files](https://github.com/TahaFawzyElshrif/Happy-Function/tree/main/HappyFunction/install/files)

### Source Code

* [Source folder](https://github.com/TahaFawzyElshrif/Happy-Function/tree/main/HappyFunction/source)

---

## Algorithm Design

The core logic is based on:

* **Recursive parsing** to evaluate inner expressions first
* Rule-based derivative computation
* Step recording using a FIFO queue
* Expression formatting before derivative processing

The system processes complex expressions by resolving the innermost functions first, then applying derivative rules outward.

---

## Main Components

* `hapfun` → Entry point (main class)
* `equationformat` → Expression formatting & preprocessing
* `driv` → Core derivative computation engine
* `hapfunV1` → Combined version for executable build

---

## Current Limitations

* Some complex nested expressions may produce incorrect results
* Constants may sometimes be formatted incorrectly
* Step explanations for Laplacian may lack clarity
* Derivative of `x` requires explicit input as `x^1`

---

## Future Improvements

* Improved expression parsing robustness
* Better step formatting and readability
* Advanced function support
* GUI version using Flutter
* Cross-platform compatibility

---

## Tech Stack

* Dart (CLI application)
* Recursive symbolic computation

---
