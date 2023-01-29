sub get-percentage-bar(Rat $percentage where 0.0 <= * <= 1.0) {
    "🔴" x floor($percentage * 10) ~ "⭕" x (10 - floor($percentage * 10))
}

say get-percentage-bar(0.5);
