//
//  CustomButton.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import UIKit

public class CustomButton: UIButton {
   public enum BackgroundFill {
       case fill
       case empty
   }
    
    struct Constants {
        struct Button {
            static let font = UIFont.systemFont(ofSize: 17)
            static let borderWidth: CGFloat = 1
            static let cornerRadius: CGFloat = 7
            static let backgroundColor: UIColor = .blue
            static let backgroundColorNonFill: UIColor = .clear
            static let titleColorFill: UIColor = .white
            static let titleColorNonFill: UIColor = .blue
            static let borderColor: UIColor = .blue
        }
    }
    
    private var title: String
    private var fill: BackgroundFill
    private var completion: () -> ()
    
    public required init(title: String, fill: BackgroundFill, completion: @escaping () -> ()) {
        self.title = title
       self.fill = fill
       self.completion = completion
       super.init(frame: CGRect.zero)
       createButton()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   private func createButton() {
       layer.cornerRadius = Constants.Button.cornerRadius
       setTitle(title, for: .normal)
       titleLabel?.font = Constants.Button.font
       if fill == .fill {
           backgroundColor = Constants.Button.backgroundColor
           setTitleColor(Constants.Button.titleColorFill, for: .normal)
       } else {
           backgroundColor = Constants.Button.backgroundColorNonFill
           setTitleColor(Constants.Button.titleColorNonFill, for: .normal)
       }
       layer.borderWidth = Constants.Button.borderWidth
       layer.borderColor = Constants.Button.borderColor.cgColor
       addTarget(self, action: #selector(buttonTapped), for: .touchDown)
   }
   
   @objc private func buttonTapped() {
       completion()
   }
}

