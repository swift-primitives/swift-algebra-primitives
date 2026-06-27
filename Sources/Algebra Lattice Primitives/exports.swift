// exports.swift
// Re-export the semilattice substructure: a lattice is built from a join
// semilattice and a meet semilattice, so consumers of the lattice surface
// also see `Algebra.Semilattice` (and the tower below it).

@_exported public import Algebra_Semilattice_Primitives
