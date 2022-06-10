class InventoryItem {
    has Str $.id;
    has Str $.name;
    has Real $.price;
}

enum StoreEventType <PURCHASED REFUNDED>;

class StoreEvent {
    has StoreEventType $.event-type;
    has Real $.timestamp = now;
    has $.payload;
}

class Store {
    has Str $.name;
    has Real $.opening-time;
    has Real $.closing-time;
    has %.stock = {};
    has StoreEvent @.events;

    method update-item-quantity(InventoryItem $item, Real $amount) {
        %.stock{$item.id} = $amount;
    }

    method purchase-item(InventoryItem $item) {
        return if %.stock{$item.id} <= 0;
        @.events.push: StoreEvent.new(event-type => PURCHASED, payload => $item.id);
        self.update-item-quantity($item, %.stock{$item.id} - 1);
    }

    method refund-item(InventoryItem $item) {
        @.events.push: StoreEvent.new(event-type => REFUNDED, payload => $item.id);
        self.update-item-quantity($item, %.stock{$item.id} + 1);
    }
}

my $item1 = InventoryItem.new(id => "1", name => "Item 1 - A", price => 500);
my $item2 = InventoryItem.new(id => "2", name => "Item 2 - B", price => 750);
my $item3 = InventoryItem.new(id => "3", name => "Item 3 - C", price => 1000);

my $store = Store.new(name => "Bob's Shop");

$store.update-item-quantity($item1, 10);
$store.update-item-quantity($item2, 7);
$store.update-item-quantity($item3, 5);

$store.purchase-item($item1);

say $store.stock;
