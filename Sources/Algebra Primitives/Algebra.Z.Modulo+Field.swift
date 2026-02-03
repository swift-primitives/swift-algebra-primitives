// Algebra.Z.Modulo+Field.swift

/// Field witness for Z/pZ when p is prime.
///
/// Returns nil when n is not prime or when `(n-1)*(n-1)` overflows `Int`.
/// Reciprocal throws `Algebra.Field<Self>.Error.nonInvertible` for zero.
extension Algebra.Z.Modulo {
    @inlinable
    public static func field() -> Algebra.Field<Self>? {
        guard n > 1 else { return nil }
        guard isPrime(n) else { return nil }
        guard let ring = ring else { return nil }
        return .init(
            additive: ring.ring.additive,
            multiplicative: .init(monoid: ring.ring.multiplicative),
            reciprocal: { (element) throws(Algebra.Field<Self>.Error) in
                guard element.residue != 0 else { throw .nonInvertible }
                return .init(__unchecked: inverse(element.residue, modulus: n))
            }
        )
    }
}
