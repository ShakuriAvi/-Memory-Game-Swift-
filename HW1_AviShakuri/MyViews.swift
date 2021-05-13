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
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        layer.cornerRadius = frame.size.height / 2
        setTitleColor(.white, for: .normal)
    }
}
