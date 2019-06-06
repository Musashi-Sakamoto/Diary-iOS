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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView.af_cancelImageRequest()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with item: PostViewItemInterface) {
        self.cellTextLabel.text = item.title

        guard let url = item.imageURL else { return }
        guard let mediaType = item.mediaType else { return }
        switch mediaType {
        case .image:
            self.cellImageView.af_setImage(withURL: url)
        case .video:
            let avAsset = AVURLAsset(url: url, options: ["AVURLAssetOutOfBandMIMETypeKey": "video/mp4"])
            let generator = AVAssetImageGenerator(asset: avAsset)
            let capturedImage = try! generator.copyCGImage(at: avAsset.duration, actualTime: nil)
            self.cellImageView.image = UIImage(cgImage: capturedImage)
        }
    }
}
