//
//  String + Extension.swift
//  Recipe Jar
//
//  Created by Othman Shahrouri on 27/02/2024.
//

import UIKit
extension String {
    func limited(to maxLength: Int) -> String {
        if self.count > maxLength {
            return String(self.prefix(maxLength))
        } else {
            return self
        }
    }
}
