# debian-workstation

Reproducible **Debian Stable** workstation focused on clean, predictable, and productive development.

## Concept

The project is built around a simple idea: keep the **host machine** clean and predictable, while using isolated environments when a separate system is needed.

* **Host machine** — Debian Stable for software and web development, Docker, system administration, and everyday work.
* **CLI** — the base command-line environment and tools required for system bootstrap and development.
* **Desktop** — KDE Plasma or XFCE can be added as part of the workstation setup.
* **Virtual machines** — separate guest systems that run on the host machine and provide isolated environments for testing, experiments, and other workloads.
* **Configuration as code** — system configuration, package manifests, and installation logic are stored in this repository.

## Virtual Machines

A virtual machine is a separate operating system running on the host through a hypervisor.

Instead of installing every tool and every operating system directly on the host, a VM provides an isolated environment with its own:

* operating system;
* installed packages;
* users and configuration;
* filesystem;
* network configuration.

The basic model is:

```text
Physical computer
       │
       ▼
Host machine
Debian Stable
       │
       ├── Development
       ├── Docker
       ├── Daily work
       │
       └── Virtual machines
              │
              ├── Guest system
              ├── Guest system
              └── Guest system
```

The host remains the primary working environment. VMs are used when a separate or temporary environment is preferable to modifying the host directly.

For example, a VM can be used to test another Linux distribution, reproduce a specific environment, experiment with system configuration, or isolate software that should not become part of the main workstation.

## Goals

* Recreate the workstation from scratch in a predictable way.
* Keep the host machine clean and minimal.
* Store package definitions and configuration in version control.
* Separate the installation logic from package definitions.
* Make the system easy to maintain and reproduce.
* Use virtual machines when an isolated environment is needed.

## Structure

```text
debian-workstation/

├── bootstrap.sh
├── config.sh
├── packages/
│   ├── base.txt
│   ├── cli.txt
│   ├── core.txt
│   └── README.md
├── scripts/
│   └── lib/
│       ├── colors.sh
│       ├── extract_packages.sh
│       └── output.sh
└── README.md
```

## Package Manifests

The `packages/` directory contains package definitions used by the installation scripts.

```text
packages/
├── base.txt
├── cli.txt
└── core.txt
```

Each manifest describes a logical group of packages. Keeping package definitions separate from the installation logic makes it easier to understand, modify, and version the workstation configuration.

## Scripts

The `scripts/lib/` directory contains reusable Bash components used by the main installation scripts.

* `colors.sh` — terminal color and formatting definitions.
* `output.sh` — common CLI output functions.
* `extract_packages.sh` — reads package manifests and extracts package information.

## Reproducibility

The repository is intended to be the source of truth for the workstation setup.

After reinstalling Debian, the goal is to restore the required host environment using the repository rather than manually repeating the installation and configuration process.
