const expect = @import("std").testing.expect;
// Zig’s unions allow you to define types which store one value of many possible typed fields; only one field may be active at one time.

const Result = union {
    int: i64,
    float: f64,
    bool: bool,
};

test "simple union" {
    var result = Result{ .int = 1234 };
    _ = result;
    // result.float = 12.34; // error accessing a field in a union which is not active
}

// Tagged unions are unions which use an enum to detect which field is active. Here we make use of payload capturing again, to switch on the tag type of a union while also capturing the value it contains. Here we use a pointer capture; captured values are immutable, but with the |*value| syntax, we can capture a pointer to the values instead of the values themselves. This allows us to use dereferencing to mutate the original value.

const Tag = enum { a, b, c };
const Tagged = union(Tag) { a: u8, b: f32, c: bool };
test "switch on tagged union" {
    var value = Tagged{ .b = 1.5 };
    switch (value) {
        .a => |*byte| byte.* += 1,
        .b => |*float| float.* *= 2,
        .c => |*b| !b.*,
    }

    try expect(value.b == 3);
}
