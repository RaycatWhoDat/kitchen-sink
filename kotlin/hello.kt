package hello;

val suitMapping = mapOf(
    0 to "♥",
    1 to "♠",
    2 to "♦",
    3 to "♣"
);

data class Card(val cardValue: Int, val cardSuit: Int)

fun printCard(card: Card) {
    val (cardValue, cardSuit) = card;
    val displayedCardSuit = suitMapping.get(cardSuit)
    val displayedCardValue = when (cardValue) {
        1 -> "A"
        11 -> "J"
        12 -> "Q"
        13 -> "K"
        else -> "$cardValue"
    }
    
    println("$displayedCardValue$displayedCardSuit")
}

fun main() {
    (0..51)
        .map {
            val newValue = (it % 13) + 1
            val newSuit = it % 4
            
            Card(newValue, newSuit)
        }
        .shuffled()
        .take(5)
        .forEach { printCard(it); }
}

// Local Variables:
// compile-command: "kotlinc hello.kt -include-runtime -d hello.jar && java -jar hello.jar"
// End:
