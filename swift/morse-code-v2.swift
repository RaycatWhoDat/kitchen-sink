import Foundation

let morseCodeKey = "-----.....----"

func encode(_ number: Int) -> String {
    String(number)
      .compactMap { Int(String($0)) }
      .map {
          let startIndex = morseCodeKey.index(morseCodeKey.startIndex, offsetBy: $0)
          let endIndex = morseCodeKey.index(startIndex, offsetBy: 5)
          return morseCodeKey[startIndex ..< endIndex]
      }
      .joined()
}

func decode(_ code: String) -> Int {
    let digits = stride(from: 0, to: code.count, by: 5)
      .compactMap {
          let startIndex = code.index(code.startIndex, offsetBy: $0)
          let endIndex = code.index(startIndex, offsetBy: 5)
          return if let range = morseCodeKey.range(of: code[startIndex ..< endIndex]) {
              String(morseCodeKey.distance(from: morseCodeKey.startIndex, to: range.lowerBound))
          } else {
              nil
          }
      }
      .joined()

    return Int(digits)!
}

print(encode(1203))
print(decode("-----.....-----.....-----"))
