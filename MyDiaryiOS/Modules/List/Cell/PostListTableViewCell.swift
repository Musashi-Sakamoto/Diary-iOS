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

protocol PostListTableViewCellDelegate {
    func deleteClicked(item: PostViewItemInterface?)
    func editClicked(item: PostViewItemInterface?)
}

class PostListTableViewCell: UITableViewCell {
    var delegate: PostListTableViewCellDelegate?

    @IBOutlet var card: PresenterCard!
    var item: PostViewItemInterface?

    /// Conent area.
    fileprivate var presenterView: UIView?
    fileprivate var contentsView: UILabel!

    /// Bottom Bar views.
    fileprivate var bottomBar: Bar!
    fileprivate var dateFormatter: DateFormatter!
    fileprivate var dateLabel: UILabel!
    fileprivate var fabMenu: FABMenu!

    /// Toolbar views.
    fileprivate var toolbar: Toolbar!
    fileprivate var moreButton: FABButton!

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
        self.item = item
        self.preparePresenterView(item)
        self.prepareDateFormatter()
        self.prepareDateLabel(item)
        self.prepareMoreButton()
        self.prepareFabMenu()
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

    fileprivate func prepareMoreButton() {
        self.moreButton = FABButton(image: Icon.cm.moreHorizontal, tintColor: Color.white)
        self.moreButton.backgroundColor = .gray
    }

    fileprivate func prepareFabMenu() {
        self.fabMenu = FABMenu()
        self.fabMenu.delegate = self
        self.contentView.layout(self.fabMenu).width(40).height(40).bottomRight(bottom: 20, right: 20)
        self.fabMenu.fabButton = self.moreButton

        let deleteFabMenuItem = FABMenuItem()
        deleteFabMenuItem.fabButton.image = Icon.cm.clear
        deleteFabMenuItem.fabButton.tintColor = .white
        deleteFabMenuItem.fabButton.pulseColor = .white
        deleteFabMenuItem.fabButton.backgroundColor = Color.red.darken1
        deleteFabMenuItem.fabButton.addTarget(self, action: #selector(handleDeleteFABMenuItem(button:)), for: .touchUpInside)

        let editFabMenuItem = FABMenuItem()
        editFabMenuItem.fabButton.image = Icon.cm.edit
        editFabMenuItem.fabButton.tintColor = .white
        editFabMenuItem.fabButton.pulseColor = .white
        editFabMenuItem.fabButton.backgroundColor = Color.green.darken1
        editFabMenuItem.fabButton.addTarget(self, action: #selector(handleEditFABMenuItem(button:)), for: .touchUpInside)

        self.fabMenu.fabMenuItems = [deleteFabMenuItem, editFabMenuItem]
    }

    fileprivate func prepareToolbar(_ item: PostViewItemInterface) {
        self.toolbar = Toolbar(rightViews: nil)

        self.toolbar.title = item.title
        self.toolbar.titleLabel.textAlignment = .left

        self.toolbar.detail = "Build Beautiful Software"
        self.toolbar.detailLabel.textAlignment = .left
        self.toolbar.detailLabel.textColor = Color.blueGrey.base
    }

    fileprivate func prepareBottomBar() {
        self.bottomBar = Bar(leftViews: nil, rightViews: nil, centerViews: [dateLabel])
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

extension PostListTableViewCell {
    @objc
    fileprivate func handleEditFABMenuItem(button: FABButton) {
        self.fabMenu.close()
        self.fabMenu.fabButton?.animate(.rotate(0))
        self.delegate?.editClicked(item: self.item)
    }

    @objc
    fileprivate func handleDeleteFABMenuItem(button: FABButton) {
        self.fabMenu.close()
        self.fabMenu.fabButton?.animate(.rotate(0))
        self.delegate?.deleteClicked(item: self.item)
    }
}

extension PostListTableViewCell: FABMenuDelegate {
    func fabMenuWillOpen(fabMenu: FABMenu) {
        fabMenu.fabButton?.animate(.rotate(180))
    }

    func fabMenuWillClose(fabMenu: FABMenu) {
        fabMenu.fabButton?.animate(.rotate(0))
    }
}
