# Forge Architecture

## Design Principles

- Engine orchestrates.
- Modules own implementation.
- Profiles define capabilities.
- Configuration is declarative.
- Bootstrap remains minimal.
- Capabilities never communicate directly with the user.
- Capabilities declare metadata, perform work, and report success or failure through exit codes. The engine is solely responsible for presenting progress, status, warnings, and errors.

