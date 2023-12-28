// opaque types in Zig have an unknown (albeit non-zero) size and alignment. Because of this these data types cannot be stored directly. These are used to maintain type safety with pointers to types that we don’t have information about.
const Window = opaque {};
const Button = opaque {};

extern fn show_window(*Window) callconv(.C) void;

test "opaque" {
    var main_window: *Window = undefined;
    show_window(main_window);

    var ok_button: *Button = undefined;
    show_window(ok_button);
}

// Opaque types may have declarations in their definitions (the same as structs, enums and unions).
const Window2 = opaque {
    fn show(self: *Window2) void {
        show_window2(self);
    }
};

extern fn show_window2(*Window2) callconv(.C) void;

test "opaque with declarations" {
    var main_window: *Window2 = undefined;
    main_window.show();
}
