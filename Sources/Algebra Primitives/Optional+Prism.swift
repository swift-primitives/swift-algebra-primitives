// Optional+Prism.swift
// Prism for Optional's some case.

extension Optional where Wrapped: Sendable {
    /// A prism focusing on the `.some` case of `Optional`.
    ///
    /// Named `somePrism` to avoid conflict with the `some` enum case.
    ///
    /// - `embed`: Wraps a value in `.some`
    /// - `extract`: Returns the wrapped value if present, `nil` otherwise
    ///
    /// ## Example
    ///
    /// ```swift
    /// let prism = Optional<Int>.somePrism
    ///
    /// // Embed
    /// let optional = prism.embed(42)  // Optional(42)
    ///
    /// // Extract
    /// prism.extract(.some(42))  // 42
    /// prism.extract(.none)      // nil
    /// ```
    public static var somePrism: Prism<Optional, Wrapped> {
        Prism(
            embed: { .some($0) },
            extract: { $0 }
        )
    }
}
