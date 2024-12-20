//
//  DXDropdownButton.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 09.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import UIKit
import Layout
import Then

struct Country {
    var flag: UIImage
    var code: String
}

class DXDropdownButton: UIButton {
    
    private let button = UIButton(type: .custom)
    private let chevronImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Assets.chevronDown.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = Colors.gray2.color
    }
    var countries: [Country] = []
    
    var selectedCountry: Country = Country(flag: Assets.ru.image, code: " +7") {
        didSet {
            countryDidChanged?(selectedCountry)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    var countryDidChanged: ((Country) -> ())?
    private var isChevronRotated = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        prepareForAutolayout()
        button.setTitle(selectedCountry.code, for: .normal)
        button.frame = self.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.setImage(selectedCountry.flag, for: .normal)
        addSubview(button.prepareForAutolayout())
        button
            .pin(to: self, excludingSide: .right, usingInset: 12)
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = Colors.gray2.color.cgColor
        button.imageEdgeInsets = .right(5)
        configureCountries()
        button.titleLabel?.font = .inter(size: 16, weight: .medium)
        button.setTitleColor(Colors.textDefault.color, for: .normal)
        
        addSubview(chevronImageView.prepareForAutolayout())
        chevronImageView
            .centerY(to: centerY)
            .right(to: self.right - 12)
            .width(18)
        let menuItems: [UIAction] = countries.map { country in
            return UIAction(title: country.code, image: country.flag, handler: { action in
                self.button.setImage(country.flag, for: .normal)
                self.button.setTitle(country.code, for: .normal)
                self.selectedCountry = country
            })
        }
        chevronImageView.image = Assets.chevronUp.image
        let menu = UIMenu(children: menuItems)
        self.menu = menu
        showsMenuAsPrimaryAction = true
    }
    
    private func configureCountries() {
        countries = [
            Country(flag: Assets.ru.image, code: " +7"),
            Country(flag: Assets.uk.image, code: " +44"),
            Country(flag: Assets.en.image, code: " +380"),
        ]
    }
}
