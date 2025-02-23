const std = @import("std");

// Simple memory pool for fixed-size allocations
const Pool = struct {
    buffer: []u8,
    free_list: ?*Node,
    allocator: std.mem.Allocator,

    const Node = struct {
        next: ?*Node,
    };

    pub fn init(allocator: std.mem.Allocator, size: usize, block_size: usize) !Pool {
        const total_size = size * block_size;
        const buffer = try allocator.alloc(u8, total_size);
        var pool = Pool{ .buffer = buffer, .free_list = null, .allocator = allocator };
        pool.initialize_blocks(block_size);
        return pool;
    }

    pub fn alloc(self: *Pool) ![]u8 {
        if (self.free_list) |node| {
            self.free_list = node.next;
            return @as([*]u8, @ptrCast(node))[0..16]; // Fixed block size
        }
        return error.OutOfMemory;
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var pool = try Pool.init(gpa.allocator(), 5, 16);
    const block = try pool.alloc();
    std.debug.print("Allocated block at {*}\n", .{block.ptr});
}
