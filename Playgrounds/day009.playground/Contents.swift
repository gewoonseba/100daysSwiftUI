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

let upperCasedTeam = team.map { $0.uppercased() }
print(upperCasedTeam)

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0 ..< size {
        numbers.append(generator())
    }

    return numbers
}

let newRolls = makeArray(size: 50) { Int.random(in: 1 ... 20) }
print(newRolls)

func doImportantwork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("First work")
    first()
    print("Second work")
    second()
    print("Third work")
    third()
    print("Done")
}

doImportantwork {
    print("This is the actual first work")
} second: {
    print("This is the actual second work")
} third: {
    print("This is the actual third work ,")
}

// Checkpoint 5

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers
    .filter { !$0.isMultiple(of: 2) }
    .sorted()
    .map { print("\($0) is a lucky number") }

print(luckyNumbers)
