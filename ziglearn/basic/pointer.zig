// Normal pointers in Zig cannot have 0 or null as a value. They follow the syntax *T, where T is the child type.

//Referencing is done with &variable, and dereferencing is done with variable.*.
const expect = @import("std").testing.expect;

fn increment(x: *u8) void {
    x.* += 1;
}

test "pointer" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

test "naughty pointer" {
    var x: u16 = 0;
    var y: *u8 = @ptrFromInt(x);
    _ = y;
}

// Zig also has const pointers, which cannot be used to modify the referenced data. Referencing a const variable will yield a const pointer.
//
test "const pointers" {
    const x: u8 = 1;
    var y = &x;
    y.* += 1;
}
