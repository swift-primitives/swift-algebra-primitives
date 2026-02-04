// Algebra.Z.Modulo+Literals.swift

// No custom conformance needed.
// Tagged<Residue<n>, Ordinal> gets ExpressibleByIntegerLiteral from
// Identity Primitives Test Support (via the test support chain) because
// Ordinal: ExpressibleByIntegerLiteral in ordinal-primitives source.
//
// Usage in tests:
//   let a: Algebra.Z.Modulo<5> = 3  // Tagged(__unchecked: (), Ordinal(UInt(3)))
//
// Literal type is UInt, so negative literals are compile-time errors.
// Values must be in [0, n) — no wrapping. This is appropriate for tests.
