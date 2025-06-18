//
//  objects.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//

import Foundation
import UIKit

extension UIView {
    
    var defaultColor: UIColor {
        UIColor(red: 49/255, green: 54/255, blue: 140/255, alpha: 1)
    }
    
    static func createLabel(
        text: String,
        color: UIColor = .black,
        size: CGFloat = 17,
        weight: UIFont.Weight = .regular,
        textAlignment: NSTextAlignment = .left
        
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = .systemFont(ofSize: size, weight: weight)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }
    
    func createCustomButton(title: String, titleColor: UIColor, borderColor: UIColor, backgroundColor: UIColor, target: Any, action: Selector ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    static func createStackView(
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 10,
        distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = distribution
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

}
