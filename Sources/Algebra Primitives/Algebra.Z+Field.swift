// Algebra.Z+Field.swift

/// Field witness for Z/pZ when p is prime.
///
/// Returns nil when n is not prime or when `(n-1)*(n-1)` overflows `UInt`.
/// Reciprocal throws `Algebra.Field<Self>.Error.nonInvertible` for zero.
extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static func field() -> Algebra.Field<Self>? {
        let n = Tag.capacity
        guard n > 1 else { return nil }
        guard isPrime(n) else { return nil }
        guard let ring = ring else { return nil }
        return .init(
            additive: ring.ring.additive,
            multiplicative: .init(monoid: ring.ring.multiplicative),
            reciprocal: { (element) throws(Algebra.Field<Self>.Error) in
                let value = element.intValue
                guard value != 0 else { throw .nonInvertible }
                return Self(__unchecked: (), Ordinal(UInt(inverse(value, modulus: n))))
            }
        )
    }
}
