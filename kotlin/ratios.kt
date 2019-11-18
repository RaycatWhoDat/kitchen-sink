package ratios;

fun findRatios(numbers: List<Int>) {
    var negatives = 0.0
    var zeroes = 0.0
    var positives = 0.0

    numbers.forEach {
        when (it) {
            -1 -> negatives++
            0 -> zeroes++
            1 -> positives++
        }
    }
    
    println("-1: ${negatives / numbers.size}")
    println("0: ${zeroes / numbers.size}")
    println("1: ${positives / numbers.size}")
}

fun main() {
    findRatios(generateSequence { listOf(-1, 0, 1).random() }.take(100).toList())
}

// Local Variables:
// compile-command: "kotlinc -include-runtime -d ratios.jar ratios.kt && java -jar ratios.jar"
// End:
