//
//  PostListTableViewCell.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import AlamofireImage
import AssetsLibrary
import AVFoundation
import Material
import UIKit

class PostListTableViewCell: UITableViewCell {
    @IBOutlet var card: PresenterCard!

    /// Conent area.
    fileprivate var presenterView: UIView?
    fileprivate var contentsView: UILabel!

    /// Bottom Bar views.
    fileprivate var bottomBar: Bar!
    fileprivate var dateFormatter: DateFormatter!
    fileprivate var dateLabel: UILabel!
    fileprivate var favoriteButton: IconButton!
    fileprivate var shareButton: IconButton!

    /// Toolbar views.
    fileprivate var toolbar: Toolbar!
    fileprivate var moreButton: IconButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with item: PostViewItemInterface) {
        self.preparePresenterView(item)
        self.prepareDateFormatter()
        self.prepareDateLabel(item)
        self.prepareFavoriteButton()
        self.prepareShareButton()
        self.prepareMoreButton()
        self.prepareToolbar(item)
        self.prepareContentView(item)
        self.prepareBottomBar()
        self.preparePresenterCard()
    }

    fileprivate func preparePresenterView(_ item: PostViewItemInterface) {
        guard let url = item.imageURL else {
            self.presenterView = nil
            return
        }
        guard let mediaType = item.mediaType else { return }
        switch mediaType {
        case .image:
            let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300)))
            imageView.af_setImage(withURL: url)
            imageView.contentMode = .scaleAspectFill
            self.presenterView = imageView
        case .video:
            let videoContainerView = VideoContainerView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300)))
            let player = AVPlayer(url: url)
            videoContainerView.set(player: player)
            videoContainerView.play()
            self.presenterView = videoContainerView
        }
    }

    fileprivate func prepareContentView(_ item: PostViewItemInterface) {
        self.contentsView = UILabel()
        self.contentsView.numberOfLines = 0
        self.contentsView.text = item.detail
        self.contentsView.font = RobotoFont.regular(with: 14)
    }

    fileprivate func prepareDateFormatter() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .none
    }

    fileprivate func prepareDateLabel(_ item: PostViewItemInterface) {
        self.dateLabel = UILabel()
        self.dateLabel.font = RobotoFont.regular(with: 12)
        self.dateLabel.textColor = Color.blueGrey.base
        self.dateLabel.textAlignment = .center
        self.dateLabel.text = item.timeStamp
    }

    fileprivate func prepareFavoriteButton() {
        self.favoriteButton = IconButton(image: Icon.favorite, tintColor: Color.red.base)
    }

    fileprivate func prepareShareButton() {
        self.shareButton = IconButton(image: Icon.cm.share, tintColor: Color.blueGrey.base)
    }

    fileprivate func prepareMoreButton() {
        self.moreButton = IconButton(image: Icon.cm.moreHorizontal, tintColor: Color.blueGrey.base)
    }

    fileprivate func prepareToolbar(_ item: PostViewItemInterface) {
        self.toolbar = Toolbar(rightViews: [moreButton])

        self.toolbar.title = item.title
        self.toolbar.titleLabel.textAlignment = .left

        self.toolbar.detail = "Build Beautiful Software"
        self.toolbar.detailLabel.textAlignment = .left
        self.toolbar.detailLabel.textColor = Color.blueGrey.base
    }

    fileprivate func prepareBottomBar() {
        self.bottomBar = Bar(leftViews: [favoriteButton], rightViews: [shareButton], centerViews: [dateLabel])
    }

    fileprivate func preparePresenterCard() {
        self.card.toolbar = self.toolbar
        self.card.toolbarEdgeInsetsPreset = .wideRectangle2

        self.card.presenterView = self.presenterView

        self.card.contentView = self.contentsView
        self.card.contentViewEdgeInsetsPreset = .square3

        self.card.bottomBar = self.bottomBar
        self.card.bottomBarEdgeInsetsPreset = .wideRectangle2
        contentView.layout(self.card).center()
    }
}
