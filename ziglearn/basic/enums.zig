//Methods can be given to enums. These act as namespaced functions that can be called with dot syntax
//Namespace function lives inside of enum
const expect = @import("std").testing.expect;
const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

test "enum method" {
    try expect(Suit.spades.isClubs() == Suit.isClubs(.spades));
}

//Enums can also be given var and const declarations. These act as namespaced globals, and their values are unrelated and unattached to instances of the enum type.
const Mode = enum {
    var count: u32 = 0;
    on,
    off,
};

test "hmm" {
    Mode.count += 1;
    try expect(Mode.count == 1);
}
