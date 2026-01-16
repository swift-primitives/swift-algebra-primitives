// Prism.swift
// A partial isomorphism between Whole and Part.

/// A partial isomorphism between `Whole` and `Part`.
///
/// A prism represents a bidirectional transformation where:
/// - `embed` unconditionally constructs `Whole` from `Part` (total function)
/// - `extract` optionally extracts `Part` from `Whole` (partial function)
///
/// Prisms are the dual of lenses: where lenses focus on product types (structs),
/// prisms focus on sum types (enums). They're useful for working with enum cases
/// and their associated values.
///
/// ## Example
///
/// ```swift
/// // Define a prism for Optional.some
/// extension Optional {
///     static var some: Prism<Optional, Wrapped> {
///         Prism(
///             embed: { .some($0) },
///             extract: { $0 }
///         )
///     }
/// }
///
/// // Use the prism
/// let prism = Optional<Int>.some
/// let optional = prism.embed(42)     // Optional(42)
/// let value = prism.extract(optional) // Optional(42)
/// let none = prism.extract(nil)       // nil
/// ```
public struct Prism<Whole, Part>: Sendable where Whole: Sendable, Part: Sendable {
    /// Unconditionally constructs `Whole` from `Part`.
    public let embed: @Sendable (Part) -> Whole

    /// Optionally extracts `Part` from `Whole`.
    public let extract: @Sendable (Whole) -> Part?

    /// Creates a prism with the given embed and extract functions.
    ///
    /// - Parameters:
    ///   - embed: A function that constructs `Whole` from `Part`.
    ///   - extract: A function that optionally extracts `Part` from `Whole`.
    @inlinable
    public init(
        embed: @escaping @Sendable (Part) -> Whole,
        extract: @escaping @Sendable (Whole) -> Part?
    ) {
        self.embed = embed
        self.extract = extract
    }
}

// MARK: - Composition

extension Prism {
    /// Composes two prisms: `Whole → Middle → Part`.
    ///
    /// The composed prism:
    /// - Embeds by applying the second prism's embed, then the first's
    /// - Extracts by applying the first prism's extract, then the second's
    ///
    /// - Parameters:
    ///   - first: The outer prism from `Whole` to `Middle`.
    ///   - second: The inner prism from `Middle` to `Part`.
    /// - Returns: A composed prism from `Whole` to `Part`.
    @inlinable
    public static func composing<Middle: Sendable>(
        _ first: Prism<Whole, Middle>,
        _ second: Prism<Middle, Part>
    ) -> Prism<Whole, Part> {
        Prism(
            embed: { first.embed(second.embed($0)) },
            extract: { first.extract($0).flatMap(second.extract) }
        )
    }

    /// Appends another prism, composing `self` with `next`.
    ///
    /// This is equivalent to `Prism.composing(self, next)`.
    ///
    /// - Parameter next: The prism to append.
    /// - Returns: A composed prism from `Whole` to `Next`.
    @inlinable
    public func appending<Next: Sendable>(_ next: Prism<Part, Next>) -> Prism<Whole, Next> {
        Prism<Whole, Next>.composing(self, next)
    }
}

// MARK: - Identity

extension Prism where Whole == Part {
    /// The identity prism that passes values through unchanged.
    @inlinable
    public static var identity: Prism<Whole, Part> {
        Prism(embed: { $0 }, extract: { $0 })
    }
}

// MARK: - Convenience

extension Prism {
    /// Checks if the given value matches this prism's case.
    ///
    /// - Parameter whole: The value to check.
    /// - Returns: `true` if extraction succeeds, `false` otherwise.
    @inlinable
    public func matches(_ whole: Whole) -> Bool {
        extract(whole) != nil
    }

    /// Modifies the part within a whole value, if it exists.
    ///
    /// - Parameters:
    ///   - whole: The value to modify.
    ///   - transform: A transformation to apply to the extracted part.
    /// - Returns: A new whole with the transformed part, or the original if extraction fails.
    @inlinable
    public func modify(_ whole: Whole, _ transform: (Part) -> Part) -> Whole {
        guard let part = extract(whole) else { return whole }
        return embed(transform(part))
    }
}
