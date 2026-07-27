# Forge Workstation Specification

> **Reference System**

This document defines the target state of the author's development workstation. It serves as the implementation specification for Forge's capabilities.

The objective of Forge is simple:

> Given a fresh installation of Arch Linux, running

```bash
forge build workstation
```

should reproduce the environment described below with minimal manual intervention.

This specification is intentionally implementation-agnostic. It describes **what** the workstation should become, not **how** Forge accomplishes it.

---

# Operating System

## Distribution

- Arch Linux

## Desktop Environment

- KDE Plasma

## Display Server

- Wayland

## Boot Manager

- systemd-boot

## Kernel

- Arch Linux current stable kernel

---

# User Environment

## Primary User

- forge

## Default Shell

- Zsh

## Shell Prompt

- Starship

## Terminal Emulator

- Konsole

## Working Environment

- Developer-focused
- Keyboard-driven
- Minimal visual clutter
- Fast startup
- Consistent behavior

---

# Terminal Experience

The terminal should provide a modern command-line environment.

## Expected Tooling

- eza
- bat
- fd
- ripgrep
- fzf
- zoxide
- btop

## Shell Configuration

- Useful aliases
- Modern defaults
- Improved navigation
- Syntax highlighting
- Completion
- History support

---

# Fonts

## Primary Terminal Font

- JetBrainsMono Nerd Font

## Glyph Support

- Nerd Font icons

## Unicode Support

- UTF-8 locale configured

---

# Git

Git should be fully configured for development.

## Expected Configuration

- User identity
- SSH authentication
- Default branch: `main`
- Preferred editor
- Useful aliases
- Rebase-based pulls
- Automatic pruning

---

# GitHub

- GitHub CLI installed
- Authentication completed
- SSH-based workflow
- Repository cloning supported immediately

---

# Development Toolchain

## Languages

- Node.js

## Package Managers

- npm
- pnpm

## Expected Behavior

- Current LTS or project-supported versions
- Immediately usable after installation

---

# Editor

## Visual Studio Code

### Expected Behavior

- Launches successfully
- Integrated terminal uses configured shell
- Git integration functional

---

# Desktop Environment

KDE Plasma configured for development.

## Desired Characteristics

- Clean layout
- Minimal distractions
- Efficient workflow
- Multiple monitor support
- Sensible defaults

---

# NVIDIA Support

## Expected Configuration

- NVIDIA drivers installed
- Hardware acceleration enabled
- GPU recognized
- CUDA-ready environment when applicable

---

# Developer Utilities

## Expected Utilities

- curl
- wget
- unzip
- zip
- tar
- less
- openssh
- man-db
- base-devel

---

# Networking

Networking should support:

- GitHub SSH
- Package management
- Development tooling
- Docker
- Local development

---

# Docker

- Docker installed
- Docker daemon functional
- Current user configured for Docker usage without requiring repeated privilege escalation

---

# Python

- Python available
- pip available
- Virtual environments supported

---

# Quality Requirements

Every capability should satisfy the following requirements.

## Idempotent

Running Forge multiple times should not damage an existing installation.

Repeated execution should converge toward the desired configuration.

---

## Verifiable

Every installation step should include verification.

Forge should never report success without confirming the desired state.

---

## Deterministic

Given the same profile and capabilities, Forge should produce the same workstation every time.

---

## Recoverable

Failures should stop execution with clear diagnostics.

The user should know exactly what failed and why.

---

# Future Workstation Enhancements

The following items are intentionally outside the initial implementation but represent future milestones.

- Multiple workstation profiles
- Optional capabilities
- AI tooling
- Language-specific development stacks
- Virtualization
- Kubernetes
- Cloud SDKs
- Embedded development
- Game development
- Security research tooling
- Data science tooling

---

# Design Philosophy

Forge is not intended to install software.

Forge exists to capture developer knowledge.

Each capability represents experience that has been distilled into a repeatable process.

The workstation is not simply a collection of packages.

It is a curated development environment whose configuration reflects deliberate engineering decisions.

As Forge grows, this specification should evolve alongside the reference workstation.

Every meaningful improvement made to the author's daily environment should eventually become reproducible through Forge.

> The workstation itself is the source of truth.
>
> Forge is the mechanism that recreates it.
