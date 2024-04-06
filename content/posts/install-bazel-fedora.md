---
title: "Installing Bazel in Fedora"
date: 2024-04-06T11:57:24+02:00
draft: false
toc: false
images:
tags: 
  - fedora
  - bazel
  - coding
---

Ref https://bazel.build/install/compile-source#bootstrap-bazel.

### Download from source

Download links are available at https://github.com/bazelbuild/bazel/releases.

Note: It requires downloading the distribution artifacts (`dist`), otherwise fails to find `PROTOC` :thinking_face:. More information in https://github.com/bazelbuild/bazel/issues/3801.


### Dependencies

Fedora doesn't have `build-essential`, but it has a concept for groups of packets, the following worked:

`sudo dnf groupinstall "Development Tools" "Development Libraries"`

`sudo dnf install  java-latest-openjdk java-latest-openjdk-devel`

### Self-contained binary

This can be moved/copied to any place, e.g. `cp output/bazel /usr/bin/bazel`

