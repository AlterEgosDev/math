//
//  inverse.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if FRB_USE_SIMD
import func simd.simd_inverse
#endif

public func inverse(_ matrix: Mat3x3f) -> Mat3x3f {
    #if FRB_USE_SIMD
    return Mat3x3f(storage: simd.simd_inverse(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func inverse(_ matrix: Mat3x3d) -> Mat3x3d {
    #if FRB_USE_SIMD
    return Mat3x3d(storage: simd.simd_inverse(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func inverse(_ matrix: Mat4x4f) -> Mat4x4f {
    #if FRB_USE_SIMD
    return Mat4x4f(storage: simd.simd_inverse(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func inverse(_ matrix: Mat4x4d) -> Mat4x4d {
    #if FRB_USE_SIMD
    return Mat4x4d(storage: simd.simd_inverse(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func inverse(_ quat: Quat4f) -> Quat4f {
    #if FRB_USE_SIMD
    return Quat4f(storage: simd_inverse(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func inverse(_ quat: Quat4d) -> Quat4d {
    #if FRB_USE_SIMD
    return Quat4d(storage: simd_inverse(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}
