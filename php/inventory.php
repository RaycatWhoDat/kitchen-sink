<?php

namespace Inventory;

trait Exposable {
    public function __get($key)
    {
        return $this->$key;
    }

    public function __set($key, $value)
    {
        $this->$key = $value;
    }
}


class InventoryItem
{
    use Exposable;
    
    private $id;
    private $name;
    private $price;

    public function __construct($id, $name, $price)
    {
        $this->id = $id;
        $this->name = $name;
        $this->price = $price;
    }
}

enum StoreEventType
{
    case PURCHASED;
    case REFUNDED;

    public function text()
    {
        return match ($this)
            {
                self::PURCHASED => 'PURCHASED',
                self::REFUNDED => 'REFUNDED'
            };
    }
}

class StoreEvent
{
    use Exposable;
    
    private $eventType;
    private $timestamp;
    private $payload;

    public function __construct($eventType, $payload)
    {
        $this->eventType = $eventType;
        $date = new \DateTimeImmutable();
        $this->timestamp = $date->getTimestamp();
        $this->payload = $payload;
    }
}

class Store
{
    use Exposable;
    
    private $name;
    private $openingTime;
    private $closingTime;
    private $stock;
    private $events;

    public function __construct($name)
    {
        $this->name = $name;
        $this->openingTime = 900;
        $this->closingTime = 1700;
        $this->stock = [];
        $this->events = [];
    }

    public function updateItemQuantity($item, $amount)
    {
        $this->stock[$item->id] = $amount;
    }

    public function purchaseItem($item)
    {
        if ($this->stock[$item->id] <= 0) return;
        $this->events[] = new StoreEvent(StoreEventType::PURCHASED, $item->id);
        $this->updateItemQuantity($item, $this->stock[$item->id] - 1);
    }

    public function refundItem($item)
    {
        $this->events[] = new StoreEvent(StoreEventType::REFUNDED, $item->id);
        $this->updateItemQuantity($item, $this->stock[$item->id] + 1);
    }
}

$item1 = new InventoryItem('1', 'Item 1 - A', 500);
$item2 = new InventoryItem('2', 'Item 2 - B', 750);
$item3 = new InventoryItem('3', 'Item 3 - C', 1000);

$items = [
    $item1->id => $item1,
    $item2->id => $item2,
    $item3->id => $item3
];
    

$store = new Store("Bob's Shop");

$store->updateItemQuantity($item1, 10);
$store->updateItemQuantity($item2, 7);
$store->updateItemQuantity($item3, 5);

$store->purchaseItem($item1);
$store->purchaseItem($item2);
$store->refundItem($item1);

foreach ($store->events as $event)
{
    echo "{$event->timestamp} {$event->eventType->text()} '{$items[$event->payload]->name}' \n";
}

?>
