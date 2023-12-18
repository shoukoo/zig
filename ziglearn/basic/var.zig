const constant: i32 = 5;

var variable: u32 = 5000;

const inferred_constant = @as(i32, 5);
var inferred_variable = @as(u32, constant);

// Constant and variable must have a value. If no known value can be given, then `undefined` value
// which coerces to any type, may be used as long as a tpe annotation is provided

const a: i32 = undefined;
const b: u32 = undefined;
