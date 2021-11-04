//
//  ActionButton.swift
//  RawalFlipGrid
//
//  Created by Bansri Rawal on 10/23/21.
//

import UIKit

class ActionButton: UIButton {

    open var gradientColors: [CGColor] = [UIColor.red.cgColor, UIColor.systemPink.cgColor] {
        didSet { setNeedsDisplay() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = bounds
        gradientLayer.masksToBounds = true
        return gradientLayer
    }()

    // called when creating via storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        setTitleColor(.white, for: .normal)

        backgroundColor = .clear
        contentHorizontalAlignment = .center
        gradientLayer.cornerRadius = 12.0
        layer.insertSublayer(gradientLayer, at: 0)
        layer.cornerRadius = 12.0
    }
    
    override func draw(_ rect: CGRect) {
        gradientLayer.colors = gradientColors
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
