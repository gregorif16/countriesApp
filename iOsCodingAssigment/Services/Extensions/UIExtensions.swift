//
//  UIExtensions.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias  on 19/3/24.
//

import Foundation
import UIKit


//Initially I was gonna underline the capitals, but later changed my mind. This function might be useful for other porposes
extension UILabel {
    func underline() {
        if let textUnwrapped = self.text {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute)
            self.attributedText = underlineAttributedString
        }
    }
}
