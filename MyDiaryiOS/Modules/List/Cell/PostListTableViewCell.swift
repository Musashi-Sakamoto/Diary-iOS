//
//  PostListTableViewCell.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import AlamofireImage
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

        if let url = item.imageURL {
            self.cellImageView.af_setImage(withURL: url)
        }
    }
}
