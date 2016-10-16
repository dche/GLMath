//
// GLMath - IntExt.swift
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

extension BaseInt {

    public var isPow2: Bool {
        return !isZero && !(self & (self - 1)).isZero
    }

    public var leadingZeros: UInt {
        var v = unsafeBitCast(self, to: UInt32.self)
        guard !v.isZero else { return 32 }
        var c: UInt = 0
        if (v & 0xFFFF0000 == 0) { c += 16; v <<= 16 }
        if (v & 0xFF000000 == 0) { c += 8; v <<= 8 }
        if (v & 0xF0000000 == 0) { c += 4; v <<= 4 }
        if (v & 0xC0000000 == 0) { c += 2; v <<= 2 }
        if (v & 0x80000000 == 0) { c += 1 }
        return c
    }

    public var trailingZeros: UInt {
        var v = unsafeBitCast(self, to: UInt32.self)
        guard !v.isZero else { return 32 }
        var c: UInt = 0
        if (v & 0x0000FFFF == 0) { c += 16; v >>= 16 }
        if (v & 0x000000FF == 0) { c += 8; v >>= 8 }
        if (v & 0x0000000F == 0) { c += 4; v >>= 4 }
        if (v & 0x00000003 == 0) { c += 2; v >>= 2 }
        if (v & 0x00000001 == 0) { c += 1 }
        return c
    }

    public var bitCount: UInt {
        let v = unsafeBitCast(self, to: UInt32.self)
        var c: UInt32 = v - ((v >> 1) & 0x55555555)
        c = ((c >> 2) & 0x33333333) + (c & 0x33333333)
        c = ((c >> 4) + c) & 0x0F0F0F0F
        c = ((c >> 8) + c) & 0x00FF00FF
        c = ((c >> 16) + c) & 0x0000FFFF
        return UInt(c)
    }
}
