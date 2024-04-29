//
//  ListTableViewController.swift
//  IOS Test Assessment
//
//  Created by Abhishek Saralaya on 29/04/24.
//

import UIKit

class ListTableViewController: UITableViewController {

    private var listCount = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if ListViewModel.listDatas.count < listCount {
            return ListViewModel.listDatas.count
        }
        return listCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            let listData = ListViewModel.listDatas[indexPath.row]
            print("indexPath.row",indexPath.row)
            // Configure the cell...
            cell.labelName.text = "\(listData.id)"
            if let title = listData.title {
                cell.labelText.text = title
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(listCount,indexPath.row,indexPath.section)
        if indexPath.row == listCount - 1 {
            if listCount < ListViewModel.listDatas.count {
                listCount += 20
                tableView.reloadData()
            } else {
                tableView.tableFooterView?.isHidden = true
            }
        } else if listCount >= ListViewModel.listDatas.count {
            tableView.tableFooterView?.isHidden = true
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.getDetailData(postId: (ListViewModel.listDatas[indexPath.row].id), onSuccess: {success in
                DispatchQueue.main.async {
                    if !success {
                        let label = UILabel(frame: self.view.frame)
                        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                        
                        label.text = "No Coments Available"
                        detailViewController.tableView.backgroundView = label
                    }
                    detailViewController.listData = ListViewModel.listDatas[indexPath.row]
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
            }, onError: {error in
                DispatchQueue.main.async {
                    let label = UILabel(frame: self.view.frame)
                    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                    
                    label.text = error
                    detailViewController.tableView.backgroundView = label
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
            })
        }
    }

}

extension ListTableViewController {
    func getListData(onSuccess: @escaping(_ success : Bool)->Void, onError: @escaping(_ error : String)->Void) {
        ListViewModel.callAPI(onSuccess: {listDatas in
            if ListViewModel.listDatas.count == 0 {
                onSuccess(false)
            } else {
                onSuccess(true)
            }
        }, onError: { error in
            onError(error?.localizedDescription ?? "Network issue")
        })
    }
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelText: UILabel!
}
