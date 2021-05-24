//
//  MyViews.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 06/05/2021.
//

import Foundation
import UIKit

class RoundedButton : UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        setupButton();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setupButton();
    }

    private func setupButton() {
        backgroundColor = UIColor.systemOrange
        layer.cornerRadius = frame.size.height / 2
        setTitleColor(.white, for: .normal)
    }
}
