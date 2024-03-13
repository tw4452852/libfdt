const std = @import("std");
const mem = std.mem;

export fn c_strlen(s: [*c]const u8) callconv(.C) c_ulong {
    return mem.sliceTo(s, 0).len;
}

export fn c_strchr(s: [*c]const u8, target: u8) callconv(.C) [*c]const u8 {
    const slice = mem.sliceTo(s, 0);
    return if (mem.indexOfScalar(u8, slice, target)) |pos| s + pos else null;
}

export fn c_strrchr(s: [*c]const u8, target: u8) callconv(.C) [*c]const u8 {
    const slice = mem.sliceTo(s, 0);
    return if (mem.lastIndexOfScalar(u8, slice, target)) |pos| s + pos else null;
}

export fn c_strnlen(s: [*c]const u8, n: usize) callconv(.C) usize {
    const slice = mem.sliceTo(s[0..n], 0);
    return slice.len;
}

export fn c_memcpy(dst: [*c]u8, src: [*c]u8, n: c_ulong) callconv(.C) [*c]u8 {
    @setRuntimeSafety(false);
    for (0..n) |i| {
        dst[i] = src[i];
    }
    return dst;
}

export fn c_memset(dst: [*c]u8, v: u8, n: c_ulong) callconv(.C) [*c]u8 {
    @setRuntimeSafety(false);
    for (0..n) |i| {
        dst[i] = v;
    }
    return dst;
}

export fn c_memmove(dst: [*c]u8, src: [*c]u8, n: c_ulong) callconv(.C) [*c]u8 {
    @setRuntimeSafety(false);
    if (dst <= src) {
        return c_memcpy(dst, src, n);
    } else {
        var i = n;
        while (i > 0) {
            i -= 1;
            dst[i] = src[i];
        }
    }
    return dst;
}

export fn c_memcmp(s1: [*c]u8, s2: [*c]u8, n: c_ulong) callconv(.C) c_int {
    return switch (mem.order(u8, s1[0..n], s2[0..n])) {
        .eq => 0,
        .lt => -1,
        .gt => 1,
    };
}

export fn c_memchr(s: [*c]u8, c: u8, n: c_ulong) callconv(.C) [*c]u8 {
    return if (mem.indexOfScalar(u8, s[0..n], c)) |pos| s + pos else null;
}
