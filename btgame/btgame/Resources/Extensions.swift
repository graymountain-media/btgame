//  Extensions.swift
import UIKit
import MultipeerConnectivity

extension UIColor {

    static func mainScheme1() -> UIColor {
        return UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    }
    static func mainScheme2() -> UIColor {
        return UIColor(red: 69.0/255.0, green: 123.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    }
    static func mainScheme3() -> UIColor {
        return UIColor(red: 168.0/255.0, green: 218.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    }
    static func mainHighlight() -> UIColor {
        return UIColor(red: 238.0/255.0, green: 86.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    }
    static func mainComplement1() -> UIColor {
        return UIColor(red: 244.0/255.0, green: 251.0/255.0, blue: 242.0/255.0, alpha: 1.0)
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

