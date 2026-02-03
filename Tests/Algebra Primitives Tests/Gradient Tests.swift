import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Gradient {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Gradient.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Gradient.allCases.count == 2)
        #expect(Gradient.allCases.contains(.ascending))
        #expect(Gradient.allCases.contains(.descending))
    }

    @Test
    func `opposite swaps values`() {
        #expect(Gradient.opposite(of: .ascending) == .descending)
        #expect(Gradient.opposite(of: .descending) == .ascending)
    }

    @Test
    func `opposite property equals static function`() {
        for gradient in Gradient.allCases {
            #expect(gradient.opposite == Gradient.opposite(of: gradient))
        }
    }

    @Test
    func `negation operator equals opposite`() {
        for gradient in Gradient.allCases {
            #expect(!gradient == gradient.opposite)
        }
    }

    @Test
    func `aliases are correct`() {
        #expect(Gradient.rising == .ascending)
        #expect(Gradient.falling == .descending)
        #expect(Gradient.up == .ascending)
        #expect(Gradient.down == .descending)
    }

    @Test
    func `Value typealias works`() {
        let paired: Gradient.Value<Double> = .init(.ascending, 0.5)
        #expect(paired.first == .ascending)
        #expect(paired.second == 0.5)
    }
}

// MARK: - EdgeCase

extension Gradient.Test.EdgeCase {
    @Test
    func `opposite is involution`() {
        for gradient in Gradient.allCases {
            #expect(Gradient.opposite(of: Gradient.opposite(of: gradient)) == gradient)
        }
    }
}
