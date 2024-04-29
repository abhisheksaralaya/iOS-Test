//
//  ViewController.swift
//  IOS Test Assessment
//
//  Created by Abhishek Saralaya on 29/04/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let listTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListTableViewController") as? ListTableViewController {
            listTableViewController.getListData(onSuccess: {success in
                DispatchQueue.main.async {
                    if !success {
                        let label = UILabel(frame: self.view.frame)
                        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                        
                        label.text = "No Posts Available"
                        listTableViewController.tableView.backgroundView = label
                    }
                    self.navigationController?.pushViewController(listTableViewController, animated: true)
                    self.navigationController?.viewControllers.removeFirst()
                }
            }, onError: {error in
                
                DispatchQueue.main.async {
                    let label = UILabel(frame: self.view.frame)
                    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                    
                    label.text = error
                    listTableViewController.tableView.backgroundView = label
                    self.navigationController?.pushViewController(listTableViewController, animated: true)
                }
            })
        }
    }


}

