//
//  CustomAlertView.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import UIKit

public class DDAlert {
    fileprivate var customAlert: CustomAlertView?
    
    public init() {
        customAlert = CustomAlertView()
    }
    
    public func SingleButton(title: String, body: String, buttonTitle: String, completion: (() -> ())? = nil) {
        let singleButton = CustomButton(title: buttonTitle, fill: .fill) {
            self.customAlert?.dismiss()
            completion?()
        }
        customAlert = CustomAlertView(title: title, body: body, buttons: [singleButton])
        customAlert?.present()
    }
    
    public func DoubleButton(title: String, body: String, leftButtonTitle: String, rightButtonTitle: String, leftButtonCompletion: (() -> ())? = nil, rightButtonCompletion: (() -> ())? = nil) {
        let leftButton = CustomButton(title: leftButtonTitle, fill: .empty) {
            self.customAlert?.dismiss()
            leftButtonCompletion?()
        }
        let rightButton = CustomButton(title: rightButtonTitle, fill: .fill) {
            self.customAlert?.dismiss()
            rightButtonCompletion?()
        }
        customAlert = CustomAlertView(title: title, body: body, buttons: [leftButton, rightButton])
        customAlert?.present()
    }
}

fileprivate class CustomAlertView {
    var view: UIView!
    var title: String
    var body: String
    var buttons: [CustomButton]
    var backGroundView: UIView!
    var container: UIView!
    var containerHeight: NSLayoutConstraint!
    var titleLabel: UILabel!
    var bodyLabel: UILabel!
    var stackViewButtons: UIStackView!
    
    struct Constants {
        struct Container {
            static let minHeight: CGFloat = 50
            static let maxWidht: CGFloat = 0.8
            static let cornerRadious: CGFloat = 15
            static let backgroundColor: UIColor = .white
        }
        
        struct Title {
            static let font: UIFont = UIFont.boldSystemFont(ofSize: 19)
            static let numberOfLines = 0
            static let topMargin: CGFloat = 20
            static let paddingX: CGFloat = 16
            static let textColor: UIColor = .black
        }
        
        struct Body {
            static let topMargin: CGFloat = 13
            static let paddingX: CGFloat = 16
            static let font = UIFont.systemFont(ofSize: 15)
            static let numberOfLines = 0
            static let textColor: UIColor = .darkGray
        }
        
        struct Button {
            static let topMargin: CGFloat = 20
            static let paddingX: CGFloat = 16
            static let height: CGFloat = 40
        }
        
        struct Animation {
            static let scaleX: CGFloat = 0.01
            static let scaleY: CGFloat = 0.01
            static let initialDuration: TimeInterval = 0.15
            static let dismissDuration: TimeInterval = 0.25
            static let usingSpringWithDamping: CGFloat = 0.5
            static let initialSpringVelocity: CGFloat = 5
        }
    }
    
    required init() {
        self.title = ""
        self.body = ""
        self.buttons = []
    }
    
    required init(title: String, body: String, buttons: [CustomButton]) {
        self.title = title
        self.body = body
        self.buttons = buttons
    }
    
    public func present() {
        DispatchQueue.main.async {
            self.draw()
        }
    }
    
    public func dismiss() {
        DispatchQueue.main.async {
            self.removeAlert()
        }
    }
    
    private func draw() {
        setupView()
        drawBackgroundView()
        drawContainer()
        drawTitle()
        drawBody()
        drawButtons()
        drawShadow()
        animate()
    }
    
    private func setupView() {
        guard let view = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.view = view
    }
    
    private func drawBackgroundView() {
        backGroundView = UIView()
        backGroundView.frame = view.frame
        backGroundView.backgroundColor = .clear
        view.addSubview(backGroundView)
    }
    
    private func drawContainer() {
        container = UIView(frame: .zero)
        view.addSubview(container)
        container.layer.cornerRadius = Constants.Container.cornerRadious
        container.backgroundColor = Constants.Container.backgroundColor
        container.translatesAutoresizingMaskIntoConstraints = false
        
        containerHeight = container.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.Container.minHeight)
        containerHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: view.frame.width * Constants.Container.maxWidht),
            containerHeight,
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func drawShadow() {
        container.layer.shouldRasterize = true
        container.layer.rasterizationScale = UIScreen.main.scale
        container.layer.shadowColor = UIColor.darkGray.cgColor
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 10
    }
    
    private func animate() {
        self.container.transform = CGAffineTransform(scaleX: Constants.Animation.scaleX, y: Constants.Animation.scaleY)
        UIView.animate(withDuration: Constants.Animation.initialDuration, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.container.transform = .identity
        }, completion: nil)
    }
    
    private func drawTitle() {
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = Constants.Title.font
        titleLabel.numberOfLines = Constants.Title.numberOfLines
        titleLabel.textColor = Constants.Title.textColor
        container.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let padding = Constants.Title.paddingX
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.Title.topMargin),
            titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -padding)
            
        ])
    }
    
    private func drawBody() {
        if body.isEmpty { return }
        bodyLabel = UILabel()
        bodyLabel.text = body
        bodyLabel.textAlignment = .center
        bodyLabel.font = Constants.Body.font
        bodyLabel.numberOfLines = Constants.Body.numberOfLines
        bodyLabel.textColor = Constants.Body.textColor
        container.addSubview(bodyLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        let padding = Constants.Body.paddingX
        NSLayoutConstraint.activate([
            bodyLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Body.topMargin),
            bodyLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: padding),
            bodyLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -padding)
        ])
    }
    
    private func drawButtons() {
        addButtonStackView()
        buttons.forEach({button in
            stackViewButtons.addArrangedSubview(button)
        })
    }
    
    private func addButtonStackView() {
        let padding = Constants.Button.paddingX
        stackViewButtons = UIStackView(frame: .zero)
        stackViewButtons.alignment = .fill
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.axis = .horizontal
        stackViewButtons.spacing = padding
        container.addSubview(stackViewButtons)
        
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        var anchor: NSLayoutYAxisAnchor!
        bodyLabel == nil ? (anchor = titleLabel.bottomAnchor): (anchor = bodyLabel.bottomAnchor)
        
        NSLayoutConstraint.activate([
            stackViewButtons.leftAnchor.constraint(equalTo: container.leftAnchor, constant: padding),
            stackViewButtons.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -padding),
            stackViewButtons.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            stackViewButtons.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
            stackViewButtons.topAnchor.constraint(equalTo: anchor, constant: Constants.Button.topMargin)
        ])
    }
    
    private func removeAlert() {
        UIView.animate(withDuration: Constants.Animation.dismissDuration,
                       delay: 0,
                       usingSpringWithDamping: Constants.Animation.usingSpringWithDamping,
                       initialSpringVelocity: Constants.Animation.initialSpringVelocity,
                       options: .curveEaseInOut,
                       animations: {
                        self.backGroundView.alpha = 0
                        self.container.alpha = 0
                       }) { _ in
            self.backGroundView.removeFromSuperview()
            self.container.removeFromSuperview()
        }
    }
}
 
