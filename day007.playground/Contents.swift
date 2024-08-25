import Cocoa

func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

showWelcome()

//                    ↓ ext  ↓ internal name
func printTimesTables(for number: Int, end: Int) {
    for i in 1...end {
        print("\(i) × \(number) = \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 3, end: 3)

let root = sqrt(169)
print(root)

// Single line bodies don't need an explicit return
func rollDice() -> Int {
    Int.random(in: 1...6)
}

let result = rollDice()
print(result)

func sameLetters(first: String, second: String) -> Bool {
    first.sorted() == second.sorted()
}

print(sameLetters(first: "lego", second: "goel"))

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

print(pythagoras(a: 3, b: 4))

func getUser() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift") // names of tuples not required
}

let (firstName, _) = getUser()

print("User: \(firstName)")

let lyric = "I see a red door and I want it painted black."
print(lyric.hasPrefix("I see"))


//               ↓ use without name externally
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
print(isUppercase(string))
