//
//  AvatarImageView.swift
//  GDEBank
//
//  Created by incetro on 2/8/23.
//

import UIKit
import Layout
import Kingfisher

// MARK: - AvatarImageView

final class AvatarImageView: UIView {
    
    // MARK: - Properties
    
    private let avatarImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }

    private var url: URL?
    private var placeholderImageName: String?

    init(url: URL?, placeholderImageName: String? = nil) {
        self.url = url
        super.init(frame: .zero)
        setupAvatarImageView()
        updateAvatarImageView()
        backgroundColor = Colors.bg4.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAvatarImageView() {
        avatarImageView.clipsToBounds = true
        clipsToBounds = true
        backgroundColor = .clear
        avatarImageView.backgroundColor = .clear
        addSubview(avatarImageView.prepareForAutolayout())
        avatarImageView
            .pinToSuperview()
    }

    @objc func updateAvatarImageView(avatarURL: URL? = nil) {
        avatarImageView.kf.setImage(with: url, placeholder: placeholderImageName.map(UIImage.init), options: [
            .processor(DownsamplingImageProcessor(size: CGSize(width: 500, height: 500))),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage,
            .keepCurrentImageWhileLoading
        ])
    }
}
