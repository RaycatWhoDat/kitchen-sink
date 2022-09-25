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
    new_stock = Map.put(%{}, item.id, amount)
    IO.inspect new_stock
    store = Map.merge(store, %{ stock: new_stock })
    IO.inspect store
  end
end

defmodule Main do
  def main do
    my_store = %Store{
      name: "",
      opening_time: nil,
      closing_time: nil,
      stock: %{},
      events: []
    }
    
    StoreActions.update_item_quantity(my_store, %{id: 1}, 10)
  end
end

Main.main
