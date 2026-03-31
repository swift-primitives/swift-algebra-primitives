# swift-algebra-primitives Insights

<!--
---
title: swift-algebra-primitives Insights
version: 1.0.0
last_updated: 2026-03-31
applies_to: [swift-algebra-primitives]
normative: false
---
-->

Design decisions, implementation patterns, and lessons learned specific to this package.

## Overview

This document captures insights that emerged during development of swift-algebra-primitives.
These are not API requirements — they are recorded decisions and patterns that inform
future work on this package.

**Document type**: Non-normative (recorded decisions, not requirements).

**Consolidation source**: Reflection entries tagged with `[package: swift-algebra-primitives]`.

---

## Pair<~Copyable> as Ecosystem Tuple Replacement (2026-03-30)

**Date**: 2026-03-30

**Context**: `Pair<First, Second>` in swift-algebra-primitives is the ecosystem's answer to the ~Copyable tuple limitation ([IMPL-072]). The `Split` struct in swift-io is an ad-hoc `Pair<Reader, Writer>`. Making `Pair` support `~Copyable` parameters would generalize this pattern and benefit the entire ecosystem.

**Required work**:
- Add `~Copyable` conditional conformance for First/Second parameters
- Rework functor API (`map`, `bimap`, `swapped`) with consuming/borrowing overloads per [IMPL-025]
- `Product` (variadic) is blocked on `~Copyable` pack expansion support in the compiler

**Applies to**: Pair, Product, functor API (map, bimap, swapped)
