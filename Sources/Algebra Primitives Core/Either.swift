// Either.swift
// The binary coproduct type.

/// A value of one of two types (binary coproduct).
///
/// `Either` represents the coproduct `Left + Right`, the categorical dual of
/// ``Pair`` (product `First × Second`). Where `Pair` holds *both* values,
/// `Either` holds *exactly one*.
///
/// ## Example
///
/// ```swift
/// let success: Either<String, Int> = .right(42)
/// let failure: Either<String, Int> = .left("not found")
///
/// let mapped = success.map { $0 * 2 }   // .right(84)
/// let flipped = success.swapped          // Either<Int, String>.left(42)
///
/// // Never elimination — when one side is impossible
/// let certain: Either<Never, Int> = .right(10)
/// print(certain.value)  // 10
/// ```
@frozen
public enum Either<Left, Right> {
    /// The left alternative.
    case left(Left)

    /// The right alternative.
    case right(Right)
}

// MARK: - Conditional Conformances

extension Either: Sendable where Left: Sendable, Right: Sendable {}
extension Either: Equatable where Left: Equatable, Right: Equatable {}
extension Either: Hashable where Left: Hashable, Right: Hashable {}
#if !hasFeature(Embedded)
    extension Either: Codable where Left: Codable, Right: Codable {}
#endif
extension Either: Error where Left: Error, Right: Error {}

// MARK: - Functor (Static Implementation)

extension Either {
    /// Transforms the right component of an either while preserving the left.
    @inlinable
    public static func map<NewRight, E: Swift.Error>(
        _ either: Either,
        transform: (Right) throws(E) -> NewRight
    ) throws(E) -> Either<Left, NewRight> {
        switch either {
        case .left(let left):
            .left(left)
        case .right(let right):
            try .right(transform(right))
        }
    }

    /// Transforms the left component of an either while preserving the right.
    @inlinable
    public static func mapLeft<NewLeft, E: Swift.Error>(
        _ either: Either,
        transform: (Left) throws(E) -> NewLeft
    ) throws(E) -> Either<NewLeft, Right> {
        switch either {
        case .left(let left):
            try .left(transform(left))
        case .right(let right):
            .right(right)
        }
    }

    /// Transforms both components of an either.
    @inlinable
    public static func bimap<NewLeft, NewRight, E: Swift.Error>(
        _ either: Either,
        left leftTransform: (Left) throws(E) -> NewLeft,
        right rightTransform: (Right) throws(E) -> NewRight
    ) throws(E) -> Either<NewLeft, NewRight> {
        switch either {
        case .left(let left):
            try .left(leftTransform(left))
        case .right(let right):
            try .right(rightTransform(right))
        }
    }

    /// Returns an either with components swapped.
    @inlinable
    public static func swapped(_ either: Either) -> Either<Right, Left> {
        switch either {
        case .left(let left):
            .right(left)
        case .right(let right):
            .left(right)
        }
    }
}

// MARK: - Functor (Instance Convenience)

extension Either {
    /// Transforms the right component while preserving the left.
    @inlinable
    public func map<NewRight, E: Swift.Error>(
        _ transform: (Right) throws(E) -> NewRight
    ) throws(E) -> Either<Left, NewRight> {
        try Self.map(self, transform: transform)
    }

    /// Transforms the right component while preserving the left.
    @inlinable
    public func mapRight<NewRight, E: Swift.Error>(
        _ transform: (Right) throws(E) -> NewRight
    ) throws(E) -> Either<Left, NewRight> {
        try map(transform)
    }

    /// Transforms the left component while preserving the right.
    @inlinable
    public func mapLeft<NewLeft, E: Swift.Error>(
        _ transform: (Left) throws(E) -> NewLeft
    ) throws(E) -> Either<NewLeft, Right> {
        try Self.mapLeft(self, transform: transform)
    }

    /// Transforms both components.
    @inlinable
    public func bimap<NewLeft, NewRight, E: Swift.Error>(
        left leftTransform: (Left) throws(E) -> NewLeft,
        right rightTransform: (Right) throws(E) -> NewRight
    ) throws(E) -> Either<NewLeft, NewRight> {
        try Self.bimap(self, left: leftTransform, right: rightTransform)
    }
}

// MARK: - Basic Accessors

extension Either {
    /// The left value, or `nil` if this is a right.
    @inlinable
    public var left: Left? {
        switch self {
        case .left(let left): left
        case .right: nil
        }
    }

    /// The right value, or `nil` if this is a left.
    @inlinable
    public var right: Right? {
        switch self {
        case .left: nil
        case .right(let right): right
        }
    }
}

// MARK: - Never Elimination

extension Either where Left == Never {
    /// The right value, extractable unconditionally because the left is uninhabited.
    @inlinable
    public var value: Right {
        switch self {
        case .right(let right): right
        }
    }
}

extension Either where Right == Never {
    /// The left value, extractable unconditionally because the right is uninhabited.
    @inlinable
    public var value: Left {
        switch self {
        case .left(let left): left
        }
    }
}

// MARK: - Swap (Instance Convenience)

extension Either {
    /// Returns the either with components swapped.
    @inlinable
    public var swapped: Either<Right, Left> {
        Self.swapped(self)
    }
}
