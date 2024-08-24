//
//  Date+Extensions.swift
//  CloneWidget
//
//  Created by minoh.park on 8/24/24.
//

import Foundation

public extension Date {
    /// `Date`를 주어진 날짜 형식으로 `String`으로 변환합니다.
    ///
    /// 이 메서드는 `DateFormatter`를 사용하여 `Date` 인스턴스를
    /// 주어진 `format` 파라미터에 따라 문자열로 변환합니다.
    ///
    /// - Parameter format: 날짜 형식 문자열입니다. 이 문자열은
    ///   `DateFormatter` 클래스에서 정의한 형식 패턴을 사용합니다.
    ///   예시: `"yyyy-MM-dd HH:mm:ss.SSS"`.
    /// - Returns: 포맷된 날짜를 나타내는 `String`입니다.
    ///
    /// - Example:
    ///   ```swift
    ///   let date = Date()
    ///   let formattedString = date.formattedString("yyyy-MM-dd HH:mm:ss.SSS")
    ///   print(formattedString)  // "2024-08-24 12:34:56.789"
    ///   ```
    func formattedString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
