let testCases: [Int: Bool] = [
  1997: false,
  1900: false,
  2000: true,
  2024: true
]

func isLeapYear(_ year: Int) -> Bool {
    (year.isMultiple(of: 100) && year.isMultiple(of: 400)) || (!year.isMultiple(of: 100) && year.isMultiple(of: 4))
}

for (year, result) in testCases {
    print("\(year) should be \(result). It is \(isLeapYear(year)).")
}
