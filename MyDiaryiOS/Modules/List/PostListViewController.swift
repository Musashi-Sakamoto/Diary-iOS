//
//  PostListViewController.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import PKHUD
import UIKit

class PostListViewController: UIViewController {
    var presenter: PostListPresenterInterface!
    @IBOutlet var postTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._setupView()
        self.presenter.viewDidLoad()
    }

    private func _setupView() {
        self.postTableView.estimatedRowHeight = 100
        let nib = UINib(nibName: "PostListTableViewCell", bundle: nil)
        postTableView.register(nib, forCellReuseIdentifier: "cell")
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */

    @IBAction func logoutButtonActionHandler(_: UIButton) {
        self.presenter.didSelectLogoutAction()
    }
}

extension PostListViewController: PostListViewInterface {
    func reloadData() {
        self.postTableView.reloadData()
    }

    func setEmptyPlaceholderHidden(_: Bool) {}

    func setLoadingVisible(_ visible: Bool) {
        if visible {
            HUD.show(.progress)
        } else {
            HUD.hide()
        }
    }
}

extension PostListViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return self.presenter.numberOfSections()
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOrItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PostListTableViewCell
        let item = self.presenter.item(at: indexPath)
        cell.configure(with: item)
        return cell
    }
}

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 450
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didSelectItem(at: indexPath)
    }
}
