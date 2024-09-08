import Cocoa

func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy: () -> Void = greetUser
greetCopy()

let sayHello = { (name: String) -> String in
    "Hi there, \(name)!"
}

print(sayHello("Maria"))

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

// parameter names get lost when creating a closure
let data: (Int) -> String = getUserData
let user = data(1989)
print(user)

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    } else {
        return name1 < name2
    }
}

// let captainFirstTEam = team.sorted(by: captainFirstSorted)
// print(captainFirstTEam)

// Full version
// let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
//    if name1 == "Suzanne" {
//        return true
//    } else if name2 == "Suzanne" {
//        return false
//    } else {
//        return name1 < name2
//    }
// })

// Removing params and return type
// let captainFirstTeam = team.sorted(by: { a, b in
//    if a == "Suzanne" {
//        return true
//    } else if b == "Suzanne" {
//        return false
//    } else {
//        return a < b
//    }
// })

// trailing closure
// let captainFirstTeam = team.sorted { a, b in
//    if a == "Suzanne" {
//        return true
//    } else if b == "Suzanne" {
//        return false
//    } else {
//        return a < b
//    }
// }

// no param names
let captainFirstTeam = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    } else {
        return $0 < $1
    }
}

let reverseTeam = team.sorted { $0 > $1 }

print(captainFirstTeam)
print(reverseTeam)

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let upperCasedTeam = team.map {$0.uppercased()}
print(upperCasedTeam)
