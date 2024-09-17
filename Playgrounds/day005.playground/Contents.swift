import Cocoa

let score = 85

if score > 80 {
    print("Great job!")
}

let speed = 88
let percentage = 85
let age = 18

if speed >= 88 {
    print("Where we're going, we don't need roads")
}

if percentage < 85 {
    print("Sorry, you failed the test")
}

if age >= 18 {
    print("You're eligible to vote")
} else {
    print("Sorry, you're too young to vote")
}

let ourName = "Dave Lister"
let friendName = "Arnold Daniels"

if ourName < friendName {
    print("It's \(ourName) vs \(friendName)")
} else {
    print("It's \(friendName) vs \(ourName)")
}

var numbers = [1, 2, 3]
numbers.append(4)

if numbers.count > 3 {
    numbers.remove(at: 0)
}

print(numbers)

let country = "Canada"

if country == "Australia" {
    print("G'day")
}

let name = "Taylor Swift"

if name != "Anonymous" {
    print("Welcome, \(name)")
}

var username = ""

if username.isEmpty {
    username = "Anonymous"
}

print("Hello, \(username)")

let temp = 25

if temp > 20 && temp < 30 {
    print("It's a nice day.")
}

let userAge = 14
let hasParentalConsent = true

if age >= 18 || hasParentalConsent {
    print("You can buy the game.")
}

enum TransportOption {
    case airplane, helicopter, bike, car, escooter
}

let transport = TransportOption.airplane

if transport == .airplane || transport == .helicopter {
    print("Let's fly")
} else if transport == .bike {
    print("Hope there is a bikepath")
} else if transport == .car {
    print("Have fun in traffice")
} else {
    print("I'm going to hire a scooter now")
}

enum Weather {
    case sun, wind, rain, snow, unknown
}

let forecast = Weather.sun

switch forecast {
case .sun:
    print("It should be a nice day")
case .rain:
    print("Pack an umbrella")
case .wind:
    print("Wear seomething warm")
case .snow:
    print("School is cancelled")
case .unknown:
    print("Our forecast generator is broken!")
}

let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther")
default:
    print("Who are you?")
}

let day = 5
print("My true love gave to me...")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partrige in a pear tree")
}

let personAge = 18
let canVote = age >= 18 ? "Yes" : "No"

let hour = 23
print(hour < 12 ? "Before noon" : "After noon")

let names = ["Jane", "Kaylee", "Mal"]
print(names.isEmpty ? "No one" : "\(names.count) people")

enum Theme {
    case dark, light
}

let theme = Theme.dark
let background = theme == .dark ? "Black" : "White"
print(background)
