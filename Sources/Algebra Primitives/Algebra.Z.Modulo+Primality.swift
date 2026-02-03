// Algebra.Z.Modulo+Primality.swift

extension Algebra.Z.Modulo {
    /// Tests whether a positive integer is prime via trial division.
    ///
    /// Uses `i <= n / i` loop condition to avoid overflow in `i * i`.
    /// Time complexity: O(sqrt(n)).
    @inlinable
    internal static func isPrime(_ value: Int) -> Bool {
        guard value >= 2 else { return false }
        guard value >= 4 else { return true }
        guard !value.isMultiple(of: 2) else { return false }
        var i = 3
        while i <= value / i {
            if value.isMultiple(of: i) { return false }
            i += 2
        }
        return true
    }

    /// Computes the modular inverse of `a` modulo `modulus` via extended Euclidean algorithm.
    ///
    /// Returns the unique `x` in [0, modulus) such that `a * x ≡ 1 (mod modulus)`.
    /// Precondition: `gcd(a, modulus) == 1` and `modulus > 1`.
    /// Intermediate values are bounded by the modulus, so no overflow risk.
    @inlinable
    internal static func inverse(_ a: Int, modulus: Int) -> Int {
        var old_r = a
        var r = modulus
        var old_s = 1
        var s = 0

        while r != 0 {
            let q = old_r / r
            let temp_r = r
            r = old_r - q * r
            old_r = temp_r
            let temp_s = s
            s = old_s - q * s
            old_s = temp_s
        }

        // Normalize to [0, modulus)
        let result = old_s % modulus
        return result < 0 ? result + modulus : result
    }
}
