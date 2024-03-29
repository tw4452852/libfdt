const std = @import("std");
const mem = std.mem;

export fn strlen(s: [*c]const u8) callconv(.C) usize {
    return std.mem.len(s);
}
export fn strrchr(s: [*c]const u8, target: u8) callconv(.C) [*c]const u8 {
    const slice = mem.sliceTo(s, 0);
    return if (mem.lastIndexOfScalar(u8, slice, target)) |pos| s + pos else null;
}

export fn strnlen(s: [*c]const u8, n: usize) callconv(.C) usize {
    return @min(strlen(s), n);
}

export fn memchr(s: [*c]u8, c: u8, n: c_ulong) callconv(.C) [*c]u8 {
    return if (mem.indexOfScalar(u8, s[0..n], c)) |pos| s + pos else null;
}
