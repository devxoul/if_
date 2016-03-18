if_
===

![Swift](https://img.shields.io/badge/Swift-2.1-orange.svg)

Swift if-else statement as an expression.


At a Glance
-----------

#### if-else

```swift
let point = 70
let grade = if_(point >= 90) {
    "A"
}.else_if_(point >= 80) {
    "B"
}.else_ {
    "C"
}
print(point) // "C"
```

If there's no `else_` chaining, the expression will return `nil` for else cases.

```swift
let point = 70
let grade = if_(point >= 90) {
    "A"
}.else_if_(point >= 80) {
    "B"
}
print(point) // nil
```


#### if-let-else

```swift
let value: Any = "Hello"
let string = if_let_(value as? String) {
    $0 + " world!"
}
print(string) // "Hello world!"
```

Use `,` to bind multiple optionals.

```swift
let someValue = if_let_(optional1, optional2, optional3) {
    $0 + $1 + $2
}
```


#### if-let-where

```swift
let value: Any = 12
let result = if_let_(value as? Int, where_: { $0 % 2 == 0 }) {
    $0 * 2
}
print(value) // 24
```


License
-------

**if_** is under MIT license. See the [LICENSE](LICENSE) file for more info.
