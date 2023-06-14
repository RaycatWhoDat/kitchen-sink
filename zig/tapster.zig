const std = @import("std");

const string = []const u8;
const ArrayList = std.ArrayList;

const stdout = std.io.getStdOut().writer();
var gpa: std.heap.GeneralPurposeAllocator(.{}) = .{};

const Card = struct {
    number: string,
    cardholder_name: string,
    balance: i32,
    ounces_poured: i32,
    fn init(number: string, cardholder_name: string) @This() {
        return Card{ .number = number, .cardholder_name = cardholder_name, .balance = 0, .ounces_poured = 0 };
    }
};

const ReaderEventType = enum { INSERTED, CHARGED, REMOVED };

const ReaderEvent = struct {
    event_type: ReaderEventType,
    timestamp: i64,
    payload: string,
    fn init(event_type: ReaderEventType, payload: string) @This() {
        return ReaderEvent{ .event_type = event_type, .timestamp = std.time.timestamp(), .payload = payload };
    }
};

const Reader = struct {
    const Self = @This();

    current_card: ?*Card = null,
    events: ArrayList(ReaderEvent) = undefined,

    fn init() Self {
        var reader = Reader{};
        reader.events = ArrayList(ReaderEvent).init(gpa.allocator());
        return reader;
    }

    fn insert_card(self: *Self, card: *Card) !void {
        try self.events.append(ReaderEvent.init(.INSERTED, card.number));
        self.current_card = card;
    }

    fn remove_card(self: *Self) !void {
        try self.events.append(ReaderEvent.init(.REMOVED, self.current_card.?.number));
        self.current_card = null;
    }

    fn charge_card(self: *Self, ounces_poured: i32, price_per_ounce: i32) !void {
        if (self.current_card == null) return;
        var charge = ounces_poured * price_per_ounce;
        // var buffer: [32]u8 = undefined;
        // _ = try std.fmt.bufPrint(&buffer, "{d}", .{charge});
        try self.events.append(ReaderEvent.init(.CHARGED, "(amount)"));
        self.current_card.?.balance += charge;
        self.current_card.?.ounces_poured += ounces_poured;
    }

    fn display_stats(self: *Self) !void {
        if (self.current_card != null) {
            try stdout.print("Cardholder name: {s}\n", .{self.current_card.?.cardholder_name});
            try stdout.print("Balance: ${d:.2}\n", .{@intToFloat(f32, self.current_card.?.balance) / 100});
            try stdout.print("Ounces poured: {d}\n", .{self.current_card.?.ounces_poured});
        }

        for (self.events.items) |event| {
            try stdout.print("{} - {} - {s}\n", .{ event.timestamp, event.event_type, event.payload });
        }
    }
};

pub fn main() !void {
    var card = Card.init("5555555555555555", "Ray Perry");

    var reader = Reader.init();

    try reader.insert_card(&card);
    try reader.charge_card(10, 55);
    try reader.remove_card();
    try reader.insert_card(&card);

    try reader.display_stats();
}
