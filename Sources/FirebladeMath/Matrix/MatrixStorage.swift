//
//  MatrixStorage.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 05.09.19.
//

public protocol Storage4x4Protocol: RandomAccessCollection, MutableCollection, RangeReplaceableCollection, Equatable {
    associatedtype Value: StorageScalar
    //associatedtype _Storage3x3: Storage3x3Protocol where _Storage3x3.Value == Value
    typealias Column = SIMD4<Value>

    init(_ columns: [Column])
    init(diagonal: Column)

    // swiftlint:disable large_tuple
    var columns: (Column, Column, Column, Column) { get }

    subscript(column: Int, row: Int) -> Value { get set }
    subscript(index: Int) -> Value { get set }
}

extension Storage4x4Protocol where Element == Value, Index == Int {
    public var startIndex: Int { 0 }
    public var endIndex: Int { 16 }

    public func index(after i: Int) -> Int { i + 1 }
}

public protocol Storage3x3Protocol: RandomAccessCollection, MutableCollection, RangeReplaceableCollection, Equatable {
    associatedtype Value: StorageScalar
    //associatedtype _Storage4x4: Storage4x4Protocol where _Storage4x4.Value == Value
    typealias Column = SIMD3<Value>

    init(_ columns: [Column])
    init(diagonal: Column)

    var columns: (Column, Column, Column) { get }

    subscript(column: Int, row: Int) -> Value { get set }
    subscript(index: Int) -> Value { get set }
}

extension Storage3x3Protocol where Element == Value, Index == Int {
    public var startIndex: Int { 0 }
    public var endIndex: Int { 9 }

    public func index(after i: Int) -> Int { i + 1 }
}
