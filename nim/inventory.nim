import std/[tables, times]

type InventoryItem = ref object
  id: string
  name: string
  price: int

type StoreEventType = enum
  PURCHASED,
  REFUNDED

type StoreEvent = ref object
  eventType: StoreEventType
  timestamp: int64
  payload: string

proc newStoreEvent(eventType: StoreEventType, payload: string): StoreEvent =
  StoreEvent(eventType: eventType, timestamp: getTime().toUnix(), payload: payload)

type Store = ref object
  name: string
  openingTime: int
  closingTime: int
  stock: Table[string, int]
  events: seq[StoreEvent]

proc newStore(name: string): Store =
  Store(name: name, openingTime: 900, closingTime: 2100, stock: initTable[string, int](), events: @[])

proc updateItemQuantity(store: Store, item: InventoryItem, amount: int) =
  store.stock[item.id] = amount
  
proc purchaseItem(store: Store, item: InventoryItem) =
  var currentItemStock = store.stock[item.id] or 0
  if currentItemStock <= 0:
    return
    
  store.events.add(newStoreEvent(PURCHASED, item.id))
  store.updateItemQuantity(item, currentItemStock - 1)

proc main =
  var
    item1 = InventoryItem(id: "1", name: "Item 1 - A", price: 500)
    item2 = InventoryItem(id: "2", name: "Item 2 - B", price: 750)
    item3 = InventoryItem(id: "3", name: "Item 3 - C", price: 1000)
    store = newStore("Bob's Store")

  store.updateItemQuantity(item1, 10)
  store.updateItemQuantity(item2, 7)
  store.updateItemQuantity(item3, 0)
  store.purchaseItem(item1)
  store.purchaseItem(item3)

  echo store.stock
  
when isMainModule:
  main()
