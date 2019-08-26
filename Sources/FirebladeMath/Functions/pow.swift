#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func pow(_ base: Float32, _ exponent: Float32) -> Float32 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.powf(base, exponent)
    #elseif os(Linux)
    return Glibc.powf(base, exponent)
    #endif
}

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func pow(_ base: Float64, _ exponent: Float64) -> Float64 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.pow(base, exponent)
    #elseif os(Linux)
    return Glibc.pow(base, exponent)
    #endif
}
