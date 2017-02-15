//
// GLMath - Pack.swift
//
// GLSLangSpec 8.4 Floating-Point Pack and Unpack Functions
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

/// First, converts each component of the normalized floating-point value `v`
/// into 16-bit integer values. Then, the results are packed into the
/// returned 32-bit unsigned integer.
///
/// The conversion for component `c` of `v` to fixed point is done as follows:
/// ```round(clamp(c, 0, 1) * 65535.0)```
///
/// The first component of the vector will be written to the least significant
/// bits of the output; the last component will be written to the most
/// significant bits.
public func packUnorm2x16(_ v: vec2) -> UInt32 {
    let us = round(clamp(v, 0, 1) * 65535)
    var pack: UInt32 = 0
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: UInt16.self, capacity: 2) { pu16 in
            pu16[0] = UInt16(us.x)
            pu16[1] = UInt16(us.y)
        }
    }
    return UInt32(littleEndian: pack)
}

/// First, unpacks a single 32-bit unsigned integer `p` into a pair of 16-bit
/// unsigned integers. Then, each component is converted to a normalized
/// floating-point value to generate the returned two-component vector.
///
/// The conversion for unpacked fixed-point value `f` to floating point is done
/// as follows: `f / 65535.0`.
///
/// The first component of the returned vector will be extracted from the least
/// significant bits of the input; the last component will be extracted from
/// the most significant bits.
public func unpackUnorm2x16(_ p: UInt32) -> vec2 {
    var v = vec2(0)
    var pack = p.littleEndian
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: UInt16.self, capacity: 2) { pu16 in
            v.x = Float(pu16[0])
            v.y = Float(pu16[1])
        }
    }
    // v / 65535.
    return v * 1.5259021896696421759365224689097e-5
}

/// First, converts each component of the normalized floating-point value `v`
/// into 8-bit integer values. Then, the results are packed into the
/// returned 32-bit unsigned integer.
///
/// The conversion for component `c` of `v` to fixed point is done as follows:
/// ```round(clamp(c, 0, 1) * 255.0)```
///
/// The first component of the vector will be written to the least significant
/// bits of the output; the last component will be written to the most
/// significant bits.
public func packUnorm4x8(_ v: vec4) -> UInt32 {
    let us = round(clamp(v, 0, 1) * 255)
    var pack: UInt32 = 0
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: UInt8.self, capacity: 4) { pu8 in
            pu8[0] = UInt8(us.x)
            pu8[1] = UInt8(us.y)
            pu8[2] = UInt8(us.z)
            pu8[3] = UInt8(us.w)
        }
    }
    return UInt32(littleEndian: pack)
}

/// First, unpacks a single 32-bit unsigned integer `p` into four 8-bit unsigned
/// integers. Then, each component is converted to a normalized floating-point
/// value to generate the returned four-component vector.
///
/// The conversion for unpacked fixed-point value `f` to floating point is done
/// as follows: `f / 255.0`.
///
/// The first component of the returned vector will be extracted from the least
/// significant bits of the input; the last component will be extracted from
/// the most significant bits.
public func unpackUnorm4x8(_ p: UInt32) -> vec4 {
    var v = vec4(0)
    var pack = p.littleEndian
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: UInt8.self, capacity: 4) { pu8 in
            v.x = Float(pu8[0])
            v.y = Float(pu8[1])
            v.z = Float(pu8[2])
            v.w = Float(pu8[3])
        }
    }
    // v / 255.
    return v * 0.0039215686274509803921568627451
}

/// First, converts each component of the normalized floating-point value `v`
/// into 16-bit integer values. Then, the results are packed into the
/// returned 32-bit unsigned integer.
///
/// The conversion for component `c` of `v` to fixed point is done as follows:
/// ```round(clamp(c, -1, 1) * 32767.0)```
///
/// The first component of the vector will be written to the least significant
/// bits of the output; the last component will be written to the most
/// significant bits.
public func packSnorm2x16(_ v: vec2) -> UInt32 {
    let i2 = round(clamp(v, -1, 1) * 32767)
    var pack: UInt32 = 0
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: Int16.self, capacity: 2) { pi16 in
            pi16[0] = Int16(i2.x)
            pi16[1] = Int16(i2.y)
        }
    }
    return UInt32(littleEndian: pack)
}

/// First, unpacks a single 32-bit unsigned integer `p` into two 16-bit signed
/// integers. Then, each component is converted to a normalized floating-point
/// value to generate the returned two-component vector.
///
/// The conversion for unpacked fixed-point value `f` to floating point is
/// done as follows: `clamp(f / 32767.0, -1, +1)`
///
/// The first component of the returned vector will be extracted from the
/// least significant bits of the input; the last component will be extracted
/// from the most significant bits.
public func unpackSnorm2x16(_ p: UInt32) -> vec2 {
    var v = vec2(0)
    var pack = p.littleEndian
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: Int16.self, capacity: 2) { pi16 in
            v.x = Float(pi16[0])
            v.y = Float(pi16[1])
        }
    }
    // v / 32767.
    return clamp(v * 3.0518509475997192297128208258309e-5, -1, 1)
}

/// First, converts each component of the normalized floating-point value `v`
/// into 8-bit integer values. Then, the results are packed into the
/// returned 32-bit unsigned integer.
///
/// The conversion for component `c` of `v` to fixed point is done as follows:
/// ```round(clamp(c, -1, 1) * 127.0)```
///
/// The first component of the vector will be written to the least significant
/// bits of the output; the last component will be written to the most
/// significant bits.
public func packSnorm4x8(_ v: vec4) -> UInt32 {
    let i4 = round(clamp(v, -1, 1) * 127)
    var pack: UInt32 = 0
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: Int8.self, capacity: 4) { pi8 in
            pi8[0] = Int8(i4.x)
            pi8[1] = Int8(i4.y)
            pi8[2] = Int8(i4.z)
            pi8[3] = Int8(i4.w)
        }
    }
    return UInt32(littleEndian: pack)
}

/// First, unpacks a single 32-bit unsigned integer `p` into four 8-bit signed
/// integers. Then, each component is converted to a normalized floating-point
/// value to generate the returned four-component vector.
///
/// The conversion for unpacked fixed-point value `f` to floating point is
/// done as follows: `clamp(f / 127.0, -1, +1)`
///
/// The first component of the returned vector will be extracted from the
/// least significant bits of the input; the last component will be extracted
/// from the most significant bits.
public func unpackSnorm4x8(_ p: UInt32) -> vec4 {
    var v = vec4(0)
    var pack = p.littleEndian
    withUnsafeMutablePointer(to: &pack) {
        $0.withMemoryRebound(to: Int8.self, capacity: 4) { pi8 in
            v.x = Float(pi8[0])
            v.y = Float(pi8[1])
            v.z = Float(pi8[2])
            v.w = Float(pi8[3])
        }
    }
    // v / 127.
    return clamp(v * 0.0078740157480315, -1, 1)
}

/// Returns a double-precision value obtained by packing the components of `v`
/// into a 64-bit value.
///
/// If an IEEE 754 Iinf or **NaN** is created, it will not signal, and the
/// resulting floating point value is unspecified. Otherwise, the bit-level
/// representation of `v` is preserved. The first vector component specifies
/// the 32 least significant bits; the second component specifies the 32 most
/// significant bits.
public func packDouble2x32(_ v: uvec2) -> Double {
    return unsafeBitCast(v, to: Double.self)
}

/// Returns a two-component unsigned integer vector representation of `v`.
/// The bit-level representation of `v` is preserved.
///
/// The first component of the vector contains the 32 least significant bits
/// of the double; the second component consists the 32 most significant bits.
public func unpackDouble2x32(_ d: Double) -> uvec2 {
    return unsafeBitCast(d, to: uvec2.self)
}
