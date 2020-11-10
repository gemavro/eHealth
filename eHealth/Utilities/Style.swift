//
//  Style.swift
//  HBO
//
//  Created by George Mavroidis on 2020-10-14.
//
import UIKit


// Just a lttle UI helper class to help with code readability

public struct Style<T> {
    private let style: (T) -> Void

    private init(style: @escaping (T) -> Void) {
        self.style = style
    }

    @discardableResult
    public func apply(on subjects: T...) -> Style {
        subjects.forEach { style($0) }
        return self
    }

    @discardableResult
    public func apply(on subjects: T?...) -> Style {
        subjects.forEach {
            guard let sub = $0 else { return }
            style(sub)
        }
        return self
    }

    public static func `for`(_: T.Type) -> Style {
        .init { _ in }
    }

    func with(_ other: @escaping (T) -> Void) -> Style<T> {
        .init { subject in
            self.apply(on: subject)
            other(subject)
        }
    }
}

extension Style where T: UITableView {

    public func separatorStyle(_ separatorStyle: UITableViewCell.SeparatorStyle) -> Style<T> {
        with { tableView in
            tableView.separatorStyle = separatorStyle
        }
    }

    public func register(_ cellClass: AnyClass?, forCellReuseIdentifier reuseIdentifier: String) -> Style<T> {
        with { tableView in
            tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
        }
    }

    public func contentInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Style<T> {
        with { tableView in
            tableView.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        }
    }
}


public extension Style where T: UIView {
    func shadow(color: UIColor = .black,
                alpha: Float = 0.5,
                xOffset: CGFloat = 0,
                yOffset: CGFloat = 5,
                blur: CGFloat = 5) -> Style<T> {
        with { view in
            view.layer.shadowColor = color.cgColor
            view.layer.shadowOpacity = alpha
            view.layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
            view.layer.shadowRadius = blur / 2
            view.layer.masksToBounds = false
        }
    }

    func cornerRadius(_ radius: CGFloat, maskToBounds: Bool = true) -> Style<T> {
        with { view in
            view.layer.cornerRadius = radius
            view.layer.masksToBounds = maskToBounds
        }
    }
    
    func maskToBounds(_ maskToBounds: Bool = true) -> Style<T> {
        with { view in
            view.layer.masksToBounds = maskToBounds
        }
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> Style<T> {
        with { view in
            let maskPath = UIBezierPath(roundedRect: view.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = view.bounds
            maskLayer.path = maskPath.cgPath
            view.layer.mask = maskLayer
        }
    }
    
    func cornerRadius(_ radius: CGFloat, masked: CACornerMask) -> Style<T> {
        with { view in
            view.layer.cornerRadius = radius
            view.layer.maskedCorners = masked
        }
    }

    func borderWidth(_ width: CGFloat) -> Style<T> {
        with { view in
            view.layer.borderWidth = width
        }
    }

    func borderColor(_ color: UIColor) -> Style<T> {
        with { view in
            view.layer.borderColor = color.cgColor
        }
    }

    func backgroundColor(_ color: UIColor) -> Style<T> {
        with { view in
            view.backgroundColor = color
        }
    }

    func translatesAutoresizingMaskIntoConstraints(_ value: Bool) -> Style<T> {
        with { view in
            view.translatesAutoresizingMaskIntoConstraints = value
        }
    }

    func clipsToBounds(_ value: Bool) -> Style<T> {
        with { view in
            view.clipsToBounds = value
        }
    }

    func tintColor(_ tintColor: UIColor) -> Style<T> {
        with { view in
            view.tintColor = tintColor
        }
    }

    func isHidden(_ isHidden: Bool) -> Style<T> {
        with { control in
            control.isHidden = isHidden
        }
    }

    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Style<T> {
        with { view in
            view.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }

    func contentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Style<T> {
        with { view in
            view.setContentHuggingPriority(priority, for: axis)
        }
    }

    func contentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Style<T> {
        with { view in
            view.setContentCompressionResistancePriority(priority, for: axis)
        }
    }

    func backgroundImage(_ image: UIImage) -> Style<T> {
        with { view in
            let backgroundImageView = UIImageView(image: image)
            backgroundImageView.isUserInteractionEnabled = true
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            view.insertSubview(backgroundImageView, at: 0)
            NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}


extension Style where T: UILabel {
    public func font(_ font: UIFont) -> Style<T> {
        with { label in
            label.font = font
        }
    }

    public func text(_ text: String?) -> Style<T> {
        with { label in
            label.text = text
        }
    }

    public func attributedText(_ attributedText: NSAttributedString?) -> Style<T> {
        with { label in
            label.attributedText = attributedText
        }
    }

    public func textColor(_ color: UIColor) -> Style<T> {
        with { label in
            label.textColor = color
        }
    }

    public func textAlignment(_ alignment: NSTextAlignment) -> Style<T> {
        with { label in
            label.textAlignment = alignment
        }
    }

    public func numberOfLines(_ numberOfLines: Int) -> Style<T> {
        with { label in
            label.numberOfLines = numberOfLines
        }
    }

    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Style<T> {
        with { label in
            label.lineBreakMode = lineBreakMode
        }
    }

    public func lineSpacing(_ lineSpacing: CGFloat) -> Style<T> {
        with { label in
            guard let text = label.text else { return }
            let attr = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attr.addAttribute(.paragraphStyle,
                              value: paragraphStyle,
                              range: NSRange(location: 0, length: attr.length))
            label.attributedText = attr
        }
    }

    public func lineHeight(_ lineHeight: CGFloat) -> Style<T> {
        with { label in
            guard let text = label.text else { return }
            let attr = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            let lineSpacing = lineHeight - label.font.pointSize - (label.font.lineHeight - label.font.pointSize)
            paragraphStyle.lineSpacing = lineSpacing
            attr.addAttribute(.paragraphStyle,
                              value: paragraphStyle,
                              range: NSRange(location: 0, length: attr.length))
            label.attributedText = attr
        }
    }

    public func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Style<T> {
        with { label in
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        }
    }

    public func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> Style<T> {
        with { label in
            label.minimumScaleFactor = minimumScaleFactor
        }
    }

    public func baselineAdjustment(_ baselineAdjustment: UIBaselineAdjustment) -> Style<T> {
        with { label in
            label.baselineAdjustment = baselineAdjustment
        }
    }
}

extension Style where T: UIImageView {

    public func image(_ image: UIImage?) -> Style<T> {
        with { imageView in
            imageView.image = image
        }
    }

    public func contentMode(_ mode: UIView.ContentMode) -> Style<T> {
        with { imageView in
            imageView.contentMode = mode
        }
    }
}
