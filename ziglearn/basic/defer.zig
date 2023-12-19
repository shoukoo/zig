const expect = @import("std").testing.expect;
test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
    }

    try expect(x == 7);
}

// when there are multiple defers in a single block, they are executed in reverse order
test "multi defer" {
    var x: f32 = 5;
    {
        defer x -= 1;
        defer x += 2;
        defer x /= 2;
    }

    try expect(x == 3.5);
}
