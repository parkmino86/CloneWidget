//
//  UINavigationController+SwipeGesture.swift
//  CloneWidget
//
//  Created by minoh.park on 9/26/24.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
