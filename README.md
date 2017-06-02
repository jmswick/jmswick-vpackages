# vpackages

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with vpackages](#setup)
    * [What vpackages affects](#what-vpackages-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with vpackages](#beginning-with-vpackages)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module creates virtual package resources for other modules to use to prevent
duplicate resource conflicts between modules that require similar packages.  These
virtual packages are defined by a hiera hash, and realized in the modules needing them.

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What vpackages affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements

VPackages requires a working hiera configuration to do a hash merge of the
configuration.

### Beginning with vpackages

A very basic setup of vpackages in hiera consists of the following.  It will
install the git and openssh packages using the default package manager, while
ensuring openssh is the latest version.

```
classes:
  - vpackages

vpackages::packages:
  git: {}
  openssh:
    ensure: latest

vpackages::realize_packages:
  - git
  - openssh
```

## Usage

With Hiera 5, the following lookup options hash is recommended for optimal
functionalty of the module to allow for taking advantage of what Hiera can
bring to the table.

```
lookup_options:
  '^vpackages::(.*)$':
    merge:
      strategy: deep
      knockout_prefix: --
```

## Limitations

This module so far has only been tested on Red Hat Enterprise Linux, but should
work on any OS that is supported by Puppet due to it just being a wrapper around
the Puppet package resource.

