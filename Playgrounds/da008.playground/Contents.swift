import Cocoa

func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) × \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 { throw PasswordError.short }
    if password == "12345" { throw PasswordError.obvious }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellend"
    }
}

let string = "12345"

do {
    let result = try checkPassword(string)
    print(result)
} catch PasswordError.short {
    print("Too short")
} catch PasswordError.obvious {
    print("Too obvious")
} catch {
    print("There was an error")
}

// checkpoint

enum SqrtError: Error {
    case outOfBounds, noSqrt
}

func calculateSqrt(of: Int) throws -> Int {
    if of < 1 || of > 10_000 {
        throw SqrtError.outOfBounds
    }
    for i in 1...100 {
        if of == i * i {
            print(i)
            return i
        }
    }
    throw SqrtError.noSqrt
}

do {
    try calculateSqrt(of: 4)
    try calculateSqrt(of: 25)
    try calculateSqrt(of: 3)
    try calculateSqrt(of: 12_000)
} catch {
    print("errr")
}

