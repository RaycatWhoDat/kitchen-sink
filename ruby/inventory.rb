class InventoryItem < Struct.new :id, :name, :price
  def initialize id, name, price; super end
end

class StoreEvent < Struct.new :event_type, :payload, :timestamp
  def initialize event_type, payload, timestamp = Time.now.to_i; super end
end

class Store
  attr_accessor :name, :opening_time, :closing_time, :stock, :events

  def initialize name
    @name = name
    @opening_time = 900
    @closing_time = 1700
    @stock = {}
    @events = []
  end

  def update_item_quantity item, amount
    @stock[item.id] = amount
  end

  def purchase_item item
    if @stock[item.id] < 1
      return
    end

    @events.push StoreEvent.new :purchased, item.id
    @stock[item.id] = @stock[item.id] - 1
  end

  def refund_item item
    @events.push StoreEvent.new :refunded, item.id
    @stock[item.id] = @stock[item.id] + 1
  end
  
end

item1 = InventoryItem.new "1", "Item 1 - A", 500
item2 = InventoryItem.new "2", "Item 2 - B", 750
item3 = InventoryItem.new "3", "Item 3 - C", 1000

store = Store.new "Bob's Shop"

store.update_item_quantity item1, 10
store.update_item_quantity item2, 7
store.update_item_quantity item3, 5

store.purchase_item item1
store.refund_item item1

puts store.stock
