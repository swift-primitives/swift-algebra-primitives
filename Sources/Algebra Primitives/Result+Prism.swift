// Result+Prism.swift
// Prisms for Result's success and failure cases.

extension Result where Success: Sendable, Failure: Sendable {
    /// A prism focusing on the `.success` case of `Result`.
    ///
    /// Named `successPrism` to avoid conflict with the `success` enum case.
    ///
    /// - `embed`: Wraps a success value in `.success`
    /// - `extract`: Returns the success value if present, `nil` if failure
    ///
    /// ## Example
    ///
    /// ```swift
    /// let prism = Result<Int, Error>.successPrism
    ///
    /// // Embed
    /// let result = prism.embed(42)  // .success(42)
    ///
    /// // Extract
    /// prism.extract(.success(42))        // 42
    /// prism.extract(.failure(someError)) // nil
    /// ```
    public static var successPrism: Prism<Result, Success> {
        Prism(
            embed: { .success($0) },
            extract: {
                if case .success(let value) = $0 {
                    return value
                }
                return nil
            }
        )
    }

    /// A prism focusing on the `.failure` case of `Result`.
    ///
    /// Named `failurePrism` to avoid conflict with the `failure` enum case.
    ///
    /// - `embed`: Wraps an error in `.failure`
    /// - `extract`: Returns the error if present, `nil` if success
    ///
    /// ## Example
    ///
    /// ```swift
    /// let prism = Result<Int, MyError>.failurePrism
    ///
    /// // Embed
    /// let result = prism.embed(.notFound)  // .failure(.notFound)
    ///
    /// // Extract
    /// prism.extract(.failure(.notFound))  // .notFound
    /// prism.extract(.success(42))         // nil
    /// ```
    public static var failurePrism: Prism<Result, Failure> {
        Prism(
            embed: { .failure($0) },
            extract: {
                if case .failure(let error) = $0 {
                    return error
                }
                return nil
            }
        )
    }
}
