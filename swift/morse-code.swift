func encode(_ input: Int) -> String {
    let morseKey = "-----.....----"
    var output = ""
    for (_, digit) in "\(input)".enumerated() {
        let index = Int("\(digit)") ?? 0
        let stringStart = morseKey.index(morseKey.startIndex, offsetBy: index)
        let stringEnd = morseKey.index(morseKey.startIndex, offsetBy: index + 4)
        output += morseKey[stringStart...stringEnd]
    }
    return output
}

extension String {
    func split(segments: Int) -> [String] {
        var allSegments: [String] = []
        var segment = ""
        for (_, character) in self.enumerated() {
            segment += "\(character)"
            if (segment.count >= segments) {
                allSegments.append(segment)
                segment = ""
            }
        }
        return allSegments
    }
}

func decode(_ input: String) -> Int {
    let morseKey = "-----.....----"
    var output = ""
    for segment in input.split(segments: 5) {
        // This SUCKS. Why doesn't Swift have a nice way of getting the first index of a string?
        let index = morseKey.firstIndex(of: segment)
        let distance = morseKey.distance(from: morseKey.startIndex, to: index)
        print(distance)
        
    }
    return Int(output) ?? 0
}

print(encode(1203))
print(decode("-----.....-----.....-----"))
