//
//  DetailTableViewController.swift
//  IOS Test Assessment
//
//  Created by Abhishek Saralaya on 30/04/24.
//

import UIKit

class DetailViewController: ViewController {
    
    @IBOutlet weak var postId: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var _listData : ListData?
    private var listCount = 20
    
    var listData : ListData? {
        get{
            return _listData
        }
        set {
            _listData = newValue
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let listData = _listData {
            postId.text = "\(listData.id)"
            if let title = listData.title {
                postTitle.text = title
            }
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if DetailViewModel.detailDatas.count < listCount {
            return DetailViewModel.detailDatas.count
        }
        return listCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            let detailData = DetailViewModel.detailDatas[indexPath.section]
            // Configure the cell...
            if indexPath.row == 0 {
                cell.labelName.text = "ID"
                cell.labelName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                if let title = detailData.name {
                    cell.labelText.text = title
                    cell.labelText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                }
            } else if indexPath.row == 1 {
                cell.labelName.text = "Name"
                cell.labelName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                if let title = detailData.name {
                    cell.labelText.text = title
                    cell.labelText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                }
            } else if indexPath.row == 2 {
                cell.labelName.text = "Email"
                cell.labelName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                if let title = detailData.email {
                    cell.labelText.text = title
                    cell.labelText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                }
            } else if indexPath.row == 2 {
                cell.labelName.text = "Body"
                cell.labelName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                if let title = detailData.body {
                    cell.labelText.text = title
                    cell.labelText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(listCount,indexPath.row,indexPath.section)
        if indexPath.row == listCount - 1 {
            if listCount < DetailViewModel.detailDatas.count {
                listCount += 20
                tableView.reloadSections([1], with: .automatic)
            } else {
                tableView.tableFooterView?.isHidden = true
            }
        } else if listCount >= DetailViewModel.detailDatas.count {
            tableView.tableFooterView?.isHidden = true
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}

extension DetailViewController {
    func getDetailData(postId: Int, onSuccess: @escaping(_ success : Bool)->Void, onError: @escaping(_ error : String)->Void) {
        DetailViewModel.callAPI(postId: postId, onSuccess: {listDatas in
            if DetailViewModel.detailDatas.count == 0 {
                onSuccess(false)
            } else {
                onSuccess(true)
            }
        }, onError: { error in
            onError(error?.localizedDescription ?? "Network issue")
        })
    }
}

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commentTitle: UILabel!
    @IBOutlet weak var postDetail: UILabel!
}
