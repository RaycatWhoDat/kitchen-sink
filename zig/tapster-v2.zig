const std = @import("std");
const print = std.debug.print;
const ArrayList = std.ArrayList;
var gpa: std.heap.GeneralPurposeAllocator(.{}) = .{};

const Card = struct { number: []const u8, cardholderName: []const u8, balance: f32 = 0.0, ouncesPoured: f32 = 0.0 };

const ReaderEventType = enum {
    INSERTED,
    CHARGED,
    REMOVED,
    fn getName(self: ReaderEventType) []const u8 {
        return switch (self) {
            .INSERTED => "INSERTED",
            .CHARGED => "CHARGED",
            .REMOVED => "REMOVED",
        };
    }
};

const ReaderEvent = struct { eventType: ReaderEventType, timestamp: i64, payload: []const u8 };

fn newReaderEvent(eventType: ReaderEventType, payload: []const u8) ReaderEvent {
    return ReaderEvent{ .eventType = eventType, .timestamp = std.time.timestamp(), .payload = payload };
}

const Reader = struct {
    currentCard: ?*Card = null,
    events: ArrayList(ReaderEvent) = undefined,

    fn init() @This() {
        var reader = Reader{};
        reader.events = ArrayList(ReaderEvent).init(gpa.allocator());
        return reader;
    }

    fn insertCard(self: *Reader, card: *Card) !void {
        const newEvent = newReaderEvent(.INSERTED, card.cardholderName);
        try self.events.append(newEvent);
        self.currentCard = card;
    }

    fn removeCard(self: *Reader) !void {
        try self.events.append(newReaderEvent(.REMOVED, self.currentCard.?.cardholderName));
        self.currentCard = null;
    }

    fn chargeCard(self: *Reader, ouncesPoured: f32, pricePerOunce: f32) !void {
        if (self.currentCard == null) return;
        const charge = ouncesPoured * pricePerOunce;
        const payload = try std.fmt.allocPrint(gpa.allocator(), "${d:.2}", .{charge});
        try self.events.append(newReaderEvent(.CHARGED, payload));
        self.currentCard.?.balance += charge;
        self.currentCard.?.ouncesPoured += ouncesPoured;
    }

    fn displayStats(self: *Reader) !void {
        if (self.currentCard != null) {
            print("Cardholder name: {s}\n", .{self.currentCard.?.cardholderName});
            print("Balance: ${d:.2}\n", .{self.currentCard.?.balance});
            print("Ounces poured: {d}\n", .{self.currentCard.?.ouncesPoured});
        }

        for (self.events.items) |event| {
            print("{} - {s} - {s}\n", .{ event.timestamp, event.eventType.getName(), event.payload });
        }
    }
};

pub fn main() !void {
    var card = Card{ .number = "5555555555555555", .cardholderName = "Ray Perry" };
    var reader = Reader.init();

    try reader.insertCard(&card);
    try reader.chargeCard(10.1, 0.79);
    try reader.removeCard();
    try reader.insertCard(&card);

    try reader.displayStats();
}
