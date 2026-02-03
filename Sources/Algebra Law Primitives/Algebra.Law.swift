// Algebra.Law.swift

import Algebra_Field_Primitives

/// Namespace for algebraic law verification harnesses.
///
/// Each law is a namespace type with single-word members returning
/// `Violation?`. A nil result means the law holds for the tested
/// elements. A non-nil result provides the offending elements and
/// the mismatched sides.
///
/// Harnesses are pure functions with no traps. Test code wraps with
/// `#expect(violation == nil)`.
extension Algebra {
    public enum Law {}
}
