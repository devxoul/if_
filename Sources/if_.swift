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

// MARK: if

public func if_<Value>(condition: Bool, _ then: () -> Value) -> Value? {
    if condition {
        return then()
    }
    return nil
}


// MARK: if let

public func if_let_<Optional, Value>(optional: Optional?, _ then: Optional -> Value) -> Value? {
    return if_let_(optional, where_: true, then)
}

public func if_let_<Optional, Value>(optional: Optional?,
                                     @autoclosure where_: () -> Bool,
                                     _ then: Optional -> Value) -> Value? {
    return if_let_(optional, where_: { _ in true }, then)
}

public func if_let_<Optional, Value>(optional: Optional?,
                                     where_: Optional -> Bool,
                                     _ then: Optional -> Value) -> Value? {
    if let wrapped = optional where where_(wrapped) {
        return then(wrapped)
    }
    return nil
}


// MARK: if let 2

public func if_let_<Optional1, Optional2, T>(optional1: Optional1?,
                                             _ optional2: Optional2?,
                                             _ then: (Optional1, Optional2) -> T) -> T? {
    return if_let_(optional1, optional2, where_: true, then)
}

public func if_let_<Optional1, Optional2, T>(optional1: Optional1?,
                                             _ optional2: Optional2?,
                                             @autoclosure where_: () -> Bool,
                                             _ then: (Optional1, Optional2) -> T) -> T? {
    return if_let_(optional1, optional2, where_: { _ in true }, then)
}

public func if_let_<Optional1, Optional2, T>(optional1: Optional1?,
                                             _ optional2: Optional2?,
                                             where_: (Optional1, Optional2) -> Bool,
                                             _ then: (Optional1, Optional2) -> T) -> T? {
    if let wrapped1 = optional1, wrapped2 = optional2 where where_((wrapped1, wrapped2)) {
        return then((wrapped1, wrapped2))
    }
    return nil
}


// MARK: if let 3

public func if_let_<Optional1, Optional2, Optional3, T>(optional1: Optional1?,
                                                        _ optional2: Optional2?,
                                                        _ optional3: Optional3?,
                                                        _ then: (Optional1, Optional2, Optional3) -> T) -> T? {
    return if_let_(optional1, optional2, optional3, where_: true, then)
}

public func if_let_<Optional1, Optional2, Optional3, T>(optional1: Optional1?,
                                                        _ optional2: Optional2?,
                                                        _ optional3: Optional3?,
                                                        @autoclosure where_: () -> Bool,
                                                        _ then: (Optional1, Optional2, Optional3) -> T) -> T? {
    return if_let_(optional1, optional2, optional3, where_: { _ in true }, then)
}

public func if_let_<Optional1, Optional2, Optional3, T>(optional1: Optional1?,
                                                        _ optional2: Optional2?,
                                                        _ optional3: Optional3?,
                                                        where_: (Optional1, Optional2, Optional3) -> Bool,
                                                        _ then: (Optional1, Optional2, Optional3) -> T) -> T? {
    if let wrapped1 = optional1, wrapped2 = optional2, wrapped3 = optional3
     where where_((wrapped1, wrapped2, wrapped3)) {
        return then((wrapped1, wrapped2, wrapped3))
    }
    return nil
}


// MARK: -

extension Optional {

    // MARK: else if

    public func else_if_(condition: Bool, _ then: () -> Wrapped) -> Wrapped? {
        if case .None = self where condition {
            return then()
        }
        return self
    }


    // MARK: else if let

    public func else_if_let_<Optional>(optional: Optional?, _ then: Optional -> Wrapped) -> Wrapped? {
        if case .None = self, let wrapped = optional {
            return then(wrapped)
        }
        return self
    }


    // MARK: else if let 2

    public func else_if_let_<Optional1, Optional2>(optional1: Optional1?,
                                                   _ optional2: Optional2?,
                                                   _ then: (Optional1, Optional2) -> Wrapped) -> Wrapped? {
        if case .None = self, let wrapped1 = optional1, wrapped2 = optional2 {
            return then((wrapped1, wrapped2))
        }
        return self
    }


    // MARK: else if let 3

    public func else_if_let_<Optional1, Optional2, Optional3>(optional1: Optional1?,
                                                              _ optional2: Optional2?,
                                                              _ optional3: Optional3?,
                                                              _ then: (Optional1, Optional2, Optional3) -> Wrapped)
                                                              -> Wrapped? {
        if case .None = self, let wrapped1 = optional1, wrapped2 = optional2, wrapped3 = optional3 {
            return then((wrapped1, wrapped2, wrapped3))
        }
        return self
    }


    // MARK: else

    public func else_(then: () -> Wrapped) -> Wrapped {
        switch self {
        case .None:
            return then()
        case .Some(let wrapped):
            return wrapped
        }
    }
    
}
