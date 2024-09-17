import Cocoa

let playerName: String = "Lukaku"

enum UIStyle {
    case light, dark, system
}

var currentStyle: UIStyle = .dark

let username: String

let stringArray = ["One", "Two", "Three", "Four", "Five", "One", "Two"]
let uniqueStrings = Set(stringArray)

print(
    """
    There are \(stringArray.count) total strings in the array.
    There are \(uniqueStrings.count) unique strings in the array.
    """
)
