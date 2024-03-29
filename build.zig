const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const dtc = b.dependency("dtc", .{});

    const lib = b.addStaticLibrary(.{
        .name = "libfdt",
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });
    lib.addCSourceFiles(.{
        .root = .{ .dependency = .{
            .dependency = dtc,
            .sub_path = "libfdt",
        } },
        .files = &.{
            "fdt.c",
            "fdt_ro.c",
            "fdt_wip.c",
            "fdt_sw.c",
            "fdt_rw.c",
            "fdt_strerror.c",
            "fdt_empty_tree.c",
            "fdt_addresses.c",
            "fdt_overlay.c",
            "fdt_check.c",
        },
    });
    lib.addIncludePath(.{ .path = "src" });
    lib.addIncludePath(.{ .dependency = .{
        .dependency = dtc,
        .sub_path = "libfdt",
    } });

    lib.installHeadersDirectoryOptions(.{
        .source_dir = dtc.path("libfdt"),
        .install_dir = .header,
        .install_subdir = "",
        .include_extensions = &.{
            "libfdt.h",
            "fdt.h",
            "libfdt_env.h",
        },
    });
    lib.installHeadersDirectoryOptions(.{
        .source_dir = .{ .path = "src" },
        .install_dir = .header,
        .install_subdir = "",
        .include_extensions = &.{
            "stdlib.h",
            "string.h",
        },
    });
    if (target.result.os.tag == .freestanding) {
        lib.bundle_compiler_rt = true;
    } else {
        lib.linkLibC();
    }

    b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "sample",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibrary(lib);
    b.installArtifact(exe);
}
