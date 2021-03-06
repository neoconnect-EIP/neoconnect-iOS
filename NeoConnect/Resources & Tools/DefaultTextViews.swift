//
//  DefaultTextViews.swift
//  NeoConnect
//
//  Created by EIP on 19/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class DefaultTextViews: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: nil)
        setupField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupField()
    }
    
    func setupField() {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, self.frame.size.height - 1, self.frame.size.width - 1, 1.0)
        bottomLine.backgroundColor = UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0).cgColor
        layer.addSublayer(bottomLine)
        
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
