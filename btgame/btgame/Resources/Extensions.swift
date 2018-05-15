//  Extensions.swift
import UIKit
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func epYellow() -> UIColor {
        return UIColor(red: 253.0/255.0, green: 255.0/255.0, blue: 130.0/255.0, alpha: 1.0)
    }
    static func epComplement() -> UIColor {
        return UIColor(red: 132.0/255.0, green: 130.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    static func buttonDisabled() -> UIColor {
        return UIColor(red: 132.0/255.0, green: 130.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    static func buttonEnabled() -> UIColor {
        return UIColor(red: 132.0/255.0, green: 130.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    
    static func mainSchemeColor1() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 162.0/255.0, alpha: 1.0)
    }
    static func mainSchemeColor2() -> UIColor {
        return UIColor(red: 106.0/255.0, green: 106.0/255.0, blue: 11.0/255.0, alpha: 1.0)
    }
    static func mainSchemeColor3() -> UIColor {
        return UIColor(red: 18.0/255.0, green: 18.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    static func textFieldColor() -> UIColor {
        return UIColor.white
    }
    
    
}
// Remember, you must always satisfy X,Y,Width,Height
//If not using one of the anchors put nil, if not using padding or width/height input '0'
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
