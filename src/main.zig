const std = @import("std");
const c = @cImport({
    @cInclude("libfdt.h");
});
const os = @import("builtin").os.tag;

fn _start() callconv(.C) void {
    var buf: [64]u8 = undefined;
    _ = c.fdt_path_offset(&buf, "/memory");
}

comptime {
    if (os == .freestanding) @export(_start, .{ .name = "_start" });
}

pub fn main() void {
    const a: u64 = 0xabcd;
    const b: u64 = 0x1234;
    std.debug.print("hi {x}, world {x}\n", .{ a, b });
}
