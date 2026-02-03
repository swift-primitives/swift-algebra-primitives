import Testing

@testable import Algebra_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Product")
struct ProductTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension ProductTests.Unit {
    @Test
    func `pair creation works`() {
        let pair = Product(1, "hello")
        #expect(pair.0 == 1)
        #expect(pair.1 == "hello")
    }

    @Test
    func `triple creation works`() {
        let triple = Product(1, "hello", true)
        #expect(triple.0 == 1)
        #expect(triple.1 == "hello")
        #expect(triple.2 == true)
    }

    @Test
    func `values tuple access works`() {
        let pair = Product(42, "test")
        #expect(pair.values.0 == 42)
        #expect(pair.values.1 == "test")
    }

    @Test
    func `equal products compare equal`() {
        let p1 = Product(1, "hello")
        let p2 = Product(1, "hello")
        #expect(p1 == p2)
    }

    @Test
    func `unequal products compare unequal`() {
        let p1 = Product(1, "hello")
        let p2 = Product(1, "world")
        #expect(p1 != p2)
    }

    @Test
    func `different first values are unequal`() {
        let p1 = Product(1, "hello")
        let p2 = Product(2, "hello")
        #expect(p1 != p2)
    }

    @Test
    func `equal products have same hash`() {
        let p1 = Product(1, "hello")
        let p2 = Product(1, "hello")
        var hasher1 = Hasher()
        var hasher2 = Hasher()
        p1.hash(into: &hasher1)
        p2.hash(into: &hasher2)
        #expect(hasher1.finalize() == hasher2.finalize())
    }

    @Test
    func `product can be used in set`() {
        let p1 = Product(1, "hello")
        let p2 = Product(2, "world")
        let set: Set<Product<Int, String>> = [p1, p2]
        #expect(set.count == 2)
    }

    @Test
    func `product can be used as dictionary key`() {
        let p1 = Product(1, "hello")
        var dict: [Product<Int, String>: Int] = [:]
        dict[p1] = 42
        #expect(dict[p1] == 42)
    }

    @Test
    func `product is sendable`() {
        let p: Product<Int, String> = Product(1, "test")
        let _: any Sendable = p
    }
}

// MARK: - EdgeCase

extension ProductTests.EdgeCase {
    @Test
    func `products with same values in different order are unequal`() {
        let p1 = Product(1, 2)
        let p2 = Product(2, 1)
        #expect(p1 != p2)
    }
}
