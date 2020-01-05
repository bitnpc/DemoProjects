//
//  UIView+Layout.swift
//  contacts
//
//  Created by tongchao on 2019/12/29.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToSuperview() -> Void {
        guard let superview = self.superview else {
            return
        }
        self.disableAutoresizingMask()
        self.pin(top: superview.topAnchor, leading: superview.leadingAnchor, bottom: superview.bottomAnchor, trailing: superview.trailingAnchor)
    }
    
    func pinToSuperviewCenter() -> Void {
        guard let superview = self.superview else {
            return
        }
        disableAutoresizingMask()
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func pin(top: NSLayoutYAxisAnchor? = nil, offset: CGFloat? = nil) -> Void {
        self.disableAutoresizingMask()
        if top != nil {
            topAnchor.constraint(equalTo: top!, constant: offset ?? 0).isActive = true
        }
    }
    
    func pin(leading: NSLayoutXAxisAnchor? = nil, offset: CGFloat? = nil) -> Void {
        self.disableAutoresizingMask()
        if leading != nil {
            leadingAnchor.constraint(equalTo: leading!, constant: offset ?? 0).isActive = true
        }
    }
    
    func pin(bottom: NSLayoutYAxisAnchor? = nil, offset: CGFloat? = nil) -> Void {
        self.disableAutoresizingMask()
        if bottom != nil {
            bottomAnchor.constraint(equalTo: bottom!, constant: offset ?? 0).isActive = true
        }
    }
    
    func pin(trailing: NSLayoutXAxisAnchor? = nil, offset: CGFloat? = nil) -> Void {
        self.disableAutoresizingMask()
        if trailing != nil {
            trailingAnchor.constraint(equalTo: trailing!, constant: offset ?? 0).isActive = true
        }
    }
    
    func pin(top: NSLayoutYAxisAnchor? = nil,
             leading: NSLayoutXAxisAnchor? = nil,
             bottom: NSLayoutYAxisAnchor? = nil,
             trailing: NSLayoutXAxisAnchor? = nil) -> Void {
        self.disableAutoresizingMask()
        if top != nil {
            topAnchor.constraint(equalTo: top!).isActive = true
        }
        if leading != nil {
            leadingAnchor.constraint(equalTo: leading!).isActive = true
        }
        if bottom != nil {
            bottomAnchor.constraint(equalTo: bottom!).isActive = true
        }
        if trailing != nil {
            trailingAnchor.constraint(equalTo: trailing!).isActive = true
        }
    }
    
    func pin(top: CGFloat? = nil,
             leading: CGFloat? = nil,
             bottom: CGFloat? = nil,
             trailing: CGFloat? = nil) -> Void {
        guard let superview = self.superview else {
            return
        }
        disableAutoresizingMask()
        if top != nil {
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: top!).isActive = true
        }
        if leading != nil {
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: leading!).isActive = true
        }
        if bottom != nil {
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: bottom!).isActive = true
        }
        if trailing != nil {
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: trailing!).isActive = true
        }
    }
    
    func pin(width: CGFloat? = nil, height: CGFloat? = nil) -> Void {
        self.disableAutoresizingMask()
        if width != nil {
            widthAnchor.constraint(equalToConstant: width!).isActive = true
        }
        if height != nil {
            heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
    }
    
    func disableAutoresizingMask() -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
