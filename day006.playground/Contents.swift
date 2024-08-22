import Cocoa

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]
print(platforms[1...])

for os in platforms {
    print("Swift works great on \(os)")
}

for i in 1...12 {
    print("This is the table of \(i)")

    for j in 1...12 {
        print("     \(i) × \(j) = \(i * j)")
    }
    print()
}

for i in 1 ..< 5 {
    print("Counting from 1 up to 5: \(i)")
}

var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)

var countdown = 10

while countdown > 0 {
    print(countdown)
    countdown -= 1
}

print("Blast off 🚀")

let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

print("Critical hit")

var averageScore = 2.5
while averageScore < 15.0 {
    averageScore += 2.5
    print("The average score is \(averageScore)")
}

let filenames = ["me.jpg", "work.txt", "sophie.jpg"]

for filename in filenames {
    if !filename.hasSuffix(".jpg") {
        continue
    }
    print(filename)
}

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1), i.isMultiple(of: number2) {
        multiples.append(i)

        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)

let options = ["up", "down", "left", "right"]
let secretCombination = ["up", "up", "right"]

outerLoop: for option1 in options {
    for option2 in options {
        for option3 in options {
            let attempt = [option1, option2, option3]
            print("🔁")
            if attempt == secretCombination {
                print("The combination is \(attempt)")
                break outerLoop
            }
        }
    }
}

//checkpoint Fizzbuzz

for i in 1...100 {
    var output = ""
    if i.isMultiple(of: 3){
        output.append("Fizz")
    }
    if i.isMultiple(of: 5) {
        output.append("Buzz")
    }
    if output.isEmpty {
        output.append(String(i))
    }
    print("\(i): \(output)")
}
