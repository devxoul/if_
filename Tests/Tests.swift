// The MIT License (MIT)
//
// Copyright (c) 2016 Suyeol Jeon (xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import XCTest
import if_

class Tests: XCTestCase {
    
    func testIf() {
        XCTAssertEqual(if_(true) { "A" }, "A")
        XCTAssertNil(if_(false) { "A" }, "A")
    }

    func testIfElse() {
        let point = 70
        let grade = if_(point >= 90) {
            "A"
        }.else_ {
            "B"
        }
        XCTAssertEqual(grade, "B")
    }

    func testIfElseIf() {
        let point = 70
        let grade = if_(point >= 90) {
            "A"
        }.else_if_(point >= 80) {
            "B"
        }
        XCTAssertNil(grade)
    }

    func testIfElseIfElse() {
        let point = 70
        let grade = if_(point >= 90) {
            "A"
        }.else_if_(point >= 80) {
            "B"
        }.else_ {
            "C"
        }
        XCTAssertEqual(grade, "C")
    }

    func testIfLet() {
        let value: Any = "A"
        let string = if_let_(value as? String) {
            "(" + $0 + ")"
        }
        let integer = if_let_(value as? Int) {
            $0 * 2
        }
        XCTAssertEqual(string, "(A)")
        XCTAssertNil(integer)
    }

    func testIfLetWhere() {
        let value: Any = "A"
        let string = if_let_(value as? String, where_: { $0.characters.count == 1 }) {
            "(" + $0 + ")"
        }
        let string2 = if_let_(value as? String, where_: { $0.characters.count > 1 }) {
            "(" + $0 + $0 + ")"
        }
        XCTAssertEqual(string, "(A)")
        XCTAssertNil(string2)
    }

    func testIfLetElseIfLet() {
        let value: Any = 12
        let string = if_let_(value as? Int) {
            "int (" + String($0) + ")"
        }.else_if_let_(value as? String) {
            "string (" + $0 + ")"
        }
        XCTAssertEqual(string, "int (12)")
    }

    func testIfLet2() {
        let value1: Any = "A"
        let value2: Any = "B"
        let string = if_let_(value1 as? String, value2 as? String) {
            $0 + ", " + $1
        }
        let integer = if_let_(value1 as? Int, value2 as? String) {
            $0 + (Int($1) ?? 0)
        }
        XCTAssertEqual(string, "A, B")
        XCTAssertNil(integer)
    }

}
