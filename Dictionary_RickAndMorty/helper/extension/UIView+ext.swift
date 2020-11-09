//
//  UIView+ext.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import UIKit

extension UIView{
    
    convenience init(_ view: UIView) {
        self.init(frame: .zero)
        self.addSubview(view)
    }
    
    convenience init(backgroundColor color: UIColor) {
        self.init(frame: .zero)
        backgroundColor = color
    }
    
    func safeTopAnchor() -> NSLayoutAnchor<NSLayoutYAxisAnchor>{
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }else{
            return self.topAnchor
        }
    }
    
    func safeLeftAnchor() -> NSLayoutAnchor<NSLayoutXAxisAnchor>{
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        }else{
            return self.leftAnchor
        }
    }
    
    func safeRightAnchor() -> NSLayoutAnchor<NSLayoutXAxisAnchor>{
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        }else{
            return self.rightAnchor
        }
    }
    
    func safeBottomAnchor() -> NSLayoutAnchor<NSLayoutYAxisAnchor>{
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }else{
            return self.bottomAnchor
        }
    }
    
    func anchorCenter(centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, xConstant: CGFloat = 0.0, yConstant: CGFloat = 0.0){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX, constant: xConstant).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY, constant: yConstant).isActive = true
        }
    }
    
    open func centerToSuperview(){
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            self.anchorCenter(centerX: superviewCenterXAnchor)
        }
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            self.anchorCenter(centerY: superviewCenterYAnchor)
        }
    }
    
    open func centerXToSuperview() {
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            self.anchorCenter(centerX: superviewCenterXAnchor)
        }
    }
    
    open func centerYToSuperview() {
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            self.anchorCenter(centerY: superviewCenterYAnchor)
        }
    }
    
    func anchor(byView view: UIView, topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0) {
        anchorWithConstants(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    func anchorSafe(byView view: UIView, topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0) {
        if #available(iOS 11.0, *) {
            anchorWithConstants(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
        }else{
            anchor(byView: view, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
        }
    }
    
    func anchor(top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil){
        
        anchorWithConstants(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstants(top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0){
        
        _ = anchor(top: top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: 0.0, heightConstant: 0.0)
        
    }
    
    @discardableResult
    func anchor(top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, topConstant: CGFloat = 0.0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0.0, rightConstant: CGFloat = 0.0, widthConstant: CGFloat = 0.0, heightConstant: CGFloat = 0.0) -> [NSLayoutConstraint]?{
        
        var anchors = [NSLayoutConstraint]()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if heightConstant > 0{
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        anchors.forEach { (c) in
            c.isActive = true
        }
        
        return anchors
    }
    
    open func fillSuperview(padding: UIEdgeInsets = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return
        }
        
        topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
    }
    
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        addSubview(stackView)
        stackView.fillSuperview()
        return stackView
    }
    
    @discardableResult
    open func stack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        return _stack(.vertical, views: views, spacing: spacing, alignment: alignment)
    }
    
    @discardableResult
    open func hstack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        return _stack(.horizontal, views: views, spacing: spacing, alignment: alignment)
    }
    
    @discardableResult
    open func withSize<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self as! T
    }
    
    @discardableResult
    open func withHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func withHeightLessOrEqual(constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    open func withHeightGreaterOrEqual(constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    open func withHeight(_ constraint: NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: constraint, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    open func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    open func withWidth(_ constraint: NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: constraint, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func withBorder(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func clearBorder() -> UIView {
        layer.borderWidth = 0.0
        return self
    }
    
}

