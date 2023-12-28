// The struct type may be omitted from a struct literal. These literals may coerce to other struct types
const expect = @import("std").testing.expect;
test "anonymous struct literal" {
    const Point = struct { x: i32, y: i32 };

    var pt: Point = .{
        .x = 13,
        .y = 67,
    };
    try expect(pt.x == 13);
    try expect(pt.y == 67);
}

// Anonymous structs may be completely anonymous i.e. without being coerced to another struct type.
test "fully anonymous struct" {
    try dump(.{
        .int = @as(u32, 1234),
        .float = @as(f64, 12.34),
        .b = true,
        .s = "hi",
    });
}

fn dump(args: anytype) !void {
    try expect(args.int == 1234);
    try expect(args.float == 12.34);
    try expect(args.b);
    try expect(args.s[0] == 'h');
    try expect(args.s[1] == 'i');
}

//Anonymous structs without field names may be created and are referred to as tuples. These have many of the properties that arrays do; tuples can be iterated over, indexed, can be used with the ++ and ** operators, and have a len field. Internally, these have numbered field names starting at "0", which may be accessed with the special syntax @"0" which acts as an escape for the syntax - things inside @"" are always recognised as identifiers.

test "tuple" {
    const values = .{
        @as(u32, 1234),
        @as(f64, 12.34),
        true,
        "hi",
    } ++ .{false} ** 2;
    try expect(values[0] == 1234);
    try expect(values[4] == false);
    try expect(values[5] == false);
    inline for (values, 0..) |v, i| {
        if (i != 2) continue;
        try expect(v);
    }
    try expect(values.len == 6);
    try expect(values.@"3"[0] == 'h');
}
