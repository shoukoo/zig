const expect = @import("std").testing.expect;
const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const A = error{ NotDir, PathNotFound };
const B = error{ OutOfMemory, PathNotFound };
const C = A || B;

const AllocationErr = error{OutOfMemory};

// anyerror is the global error set, which due to being the superset of all error sets, can have an error from any set coerced to it. Its usage should be generally avoided.

test "cerse error from a subset to a superset" {
    const err: FileOpenError = AllocationErr.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    //type coercion successfully takes place
    const x: error{AccessDenied}!void = createFile();

    //Zig does not let us ignore error unions via _ = x;
    //we must unwrap it with "try", "catch", or "if" by any means
    _ = x catch {};
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}

test "try" {
    try expect(failFn() == error.Oops);
}

test "returning an error" {
    failingFunction() catch |err| {
        try expect(err == error.Oops);
        return;
    };
}

// An error set type and another type can be combined with the ! operator to form an error union type. Values of these types may be an error value or a value of the other type.

test "error union" {
    const maybe_err: AllocationErr!u16 = 10;
    const no_err = maybe_err catch 0;

    try expect(@TypeOf(no_err) == u16);
    try expect(no_err == 10);
}
