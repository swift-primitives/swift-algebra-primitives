// Algebra.Law.Reciprocal.swift

import Algebra_Field_Primitives

/// Reciprocal law: a · reciprocal(a) = 1 for nonzero a,
/// reciprocal(0) throws nonInvertible.
extension Algebra.Law {
    /// Harness for the reciprocal law: a · reciprocal(a) = 1 for nonzero a, and reciprocal(0) throws.
    public enum Reciprocal {}
}

extension Algebra.Law.Reciprocal {
    /// Verifies the reciprocal law over the given elements.
    ///
    /// For zero: verifies reciprocal throws `.nonInvertible`.
    /// For nonzero: verifies `a * reciprocal(a) == one`.
    /// No traps. All failure is structural.
    @inlinable
    public static func check<Element: Equatable & Sendable, C: Collection<Element>>(
        of field: Algebra.Field<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            if a == field.zero {
                // Zero must throw .nonInvertible.
                do throws(Algebra.Field<Element>.Error) {
                    let result = try field.reciprocal(a)
                    return .init(law: "reciprocal", elements: [a], lhs: result, rhs: field.zero)
                } catch {
                    // reciprocal(zero) correctly threw .nonInvertible (the only possible error).
                    continue
                }
            } else {
                // Nonzero must produce inverse.
                do throws(Algebra.Field<Element>.Error) {
                    let inv = try field.reciprocal(a)
                    let product = field.multiplying(a, inv)
                    if product != field.one {
                        return .init(law: "reciprocal", elements: [a], lhs: product, rhs: field.one)
                    }
                } catch {
                    return .init(law: "reciprocal", elements: [a], lhs: a, rhs: field.one)
                }
            }
        }
        return nil
    }
}
