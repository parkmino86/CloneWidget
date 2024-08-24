//
//  AppLog.swift
//  CloneWidget
//
//  Created by minoh.park on 8/24/24.
//

import Foundation

/// 앱의 디버깅을 돕기 위해 로그를 기록하는 유틸리티 구조체입니다.
///
/// `AppLog`는 디버그 모드에서만 동작하며, 로그 메시지와 함께 타임스탬프, 파일 이름, 메서드 이름, 라인 번호를 출력합니다.
public enum AppLog {
    /// 로그 메시지를 출력합니다.
    ///
    /// 이 메서드는 디버그 모드에서만 동작하며, 로그 메시지와 함께 타임스탬프, 파일 이름, 메서드 이름, 라인 번호를 출력합니다.
    ///
    /// - Parameters:
    ///   - message: 출력할 로그 메시지입니다.
    ///   - file: 로그를 호출한 파일의 이름입니다. 기본값은 호출된 파일의 경로입니다.
    ///   - function: 로그를 호출한 메서드의 이름입니다. 기본값은 호출된 메서드의 이름입니다.
    ///   - line: 로그가 호출된 라인의 번호입니다. 기본값은 호출된 라인의 번호입니다.
    ///
    /// - Example:
    ///   ```swift
    ///   AppLog.log("This is a test log message")
    ///   ```
    ///   이 코드를 호출하면 콘솔에 다음과 같은 출력이 표시됩니다:
    ///   `[2024-08-24 12:34:56.789] [ViewController.swift:23] viewDidLoad() - This is a test log message`
    public static func log(_ message: String,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line)
    {
        #if DEBUG
            let fileName = (file as NSString).lastPathComponent
            let timestamp = Date().formattedString("yyyy-MM-dd HH:mm:ss.SSS")
            print("[\(timestamp)] [\(fileName):\(line)] \(function) - \(message)")
        #endif
    }
}
