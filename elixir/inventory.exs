defmodule InventoryItem do
  defstruct [:id, :name, :price]
end

defmodule StoreEvent do
  defstruct [:event_type, :timestamp, :payload]
end

defmodule Store do
  defstruct [:name, :opening_time, :closing_time, :stock, :events]
end

defmodule StoreActions do
  def update_item_quantity(store, item, amount) do
    new_stock = Map.put(store.stock, item.id, amount)
    Map.merge(store, %{ stock: new_stock })
  end

  def purchase_item(store, item) do
    if Map.get(store.stock, item.id) > 0 do
      new_events = store.events ++ [%StoreEvent{ event_type: :purchased, timestamp: DateTime.utc_now, payload: item.id }]
      store = Map.merge(store, %{ events: new_events })
      StoreActions.update_item_quantity(store, item, Map.get(store.stock, item.id) - 1)
    else
      StoreActions.update_item_quantity(store, item, Map.get(store.stock, item.id))
    end
  end

  def refund_item(store, item) do
    new_events = store.events ++ [%StoreEvent{ event_type: :refunded, timestamp: DateTime.utc_now, payload: item.id }]
    store = Map.merge(store, %{ events: new_events })
    StoreActions.update_item_quantity(store, item, Map.get(store.stock, item.id) + 1)
  end
end

defmodule Main do
  def main do
    item1 = %InventoryItem{ id: 1, name: "Item 1 - A", price: 500 }
    item2 = %InventoryItem{ id: 2, name: "Item 2 - B", price: 750 }
    item3 = %InventoryItem{ id: 3, name: "Item 3 - C", price: 1000 }
    
    my_store = %Store{
      name: "Bob's Store",
      opening_time: nil,
      closing_time: nil,
      stock: %{},
      events: []
    }
    
    my_store = StoreActions.update_item_quantity(my_store, item1, 10)
    my_store = StoreActions.update_item_quantity(my_store, item2, 7)
    my_store = StoreActions.update_item_quantity(my_store, item3, 5)
    
    my_store = StoreActions.purchase_item(my_store, item1)
    my_store = StoreActions.purchase_item(my_store, item1)
    my_store = StoreActions.purchase_item(my_store, item2)
    my_store = StoreActions.purchase_item(my_store, item3)
    my_store = StoreActions.refund_item(my_store, item1)

    IO.inspect my_store
  end
end

Main.main
