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
import UIKit

class PostListTableViewCell: UITableViewCell {
    @IBOutlet var cellTextLabel: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var videoContainerView: VideoContainerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView.af_cancelImageRequest()
        self.cellImageView.isHidden = false
        self.videoContainerView.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with item: PostViewItemInterface) {
        self.cellTextLabel.text = item.title

        guard let url = item.imageURL else {
            self.cellImageView.image = nil
            self.cellImageView.isHidden = true
            self.videoContainerView.isHidden = true
            return
        }
        guard let mediaType = item.mediaType else { return }
        switch mediaType {
        case .image:
            self.videoContainerView.isHidden = true
            self.cellImageView.af_setImage(withURL: url)
        case .video:
            self.cellImageView.isHidden = true
            let player = AVPlayer(url: url)
            videoContainerView.set(player: player)
            self.videoContainerView.play()
        }
    }
}
