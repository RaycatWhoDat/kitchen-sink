import std/[tables, times]

type InventoryItem = ref object
  id: string
  name: string
  price: int

proc newInventoryItem(id: string, name: string, price: int): InventoryItem =
  InventoryItem(id: id, name: name, price: price)
  
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
  store.stock.mgetOrPut(item.id, amount) = amount
  
proc purchaseItem(store: Store, item: InventoryItem) =
  var currentItemStock = store.stock.getOrDefault(item.id)
  if currentItemStock <= 0:
    return
    
  store.events.add(newStoreEvent(PURCHASED, item.id))
  store.updateItemQuantity(item, currentItemStock - 1)

proc refundItem(store: Store, item: InventoryItem) =
  var currentItemStock = store.stock.getOrDefault(item.id)
  store.events.add(newStoreEvent(REFUNDED, item.id))
  store.updateItemQuantity(item, currentItemStock + 1)

when isMainModule:
  var
    item1 = newInventoryItem("1", "Item 1 - A", 500)
    item2 = newInventoryItem("2", "Item 2 - B", 750)
    item3 = newInventoryItem("3", "Item 3 - C", 1000)
    store = newStore("Bob's Store")

  store.updateItemQuantity(item1, 10)
  store.updateItemQuantity(item2, 7)
  store.updateItemQuantity(item3, 5)
  store.purchaseItem(item1)
  store.refundItem(item1)

  echo store.stock
  
