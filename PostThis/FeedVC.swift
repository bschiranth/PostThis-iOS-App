//
//  FeedVC.swift
//  PostThis
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/22/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController?.popViewController(animated: true)
    }
    
    /// table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell)!
    }
}
