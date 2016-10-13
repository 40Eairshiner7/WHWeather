//
//  sideMenu.swift
//  WHWeather
//
//  Created by airshiner on 10/12/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import UIKit

class sideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sideMenuImage: UIImageView!
    @IBOutlet weak var sideMenuLabel: UILabel!
    @IBOutlet weak var sideMenuTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTable.delegate = self
        sideMenuTable.dataSource = self
        sideMenuTable.tableFooterView = UIView()
        sideMenuImage.image = UIImage(named: "Icon")
        sideMenuLabel.text = "Fuzhouuuuuuuuuuuuuuuuuuuuu"
        sideMenuLabel.font = UIFont.systemFontOfSize(30)
        sideMenuTable.separatorStyle = .None
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("sideMenuCell", forIndexPath: indexPath)
        cell.textLabel!.text = "unknownnnnnnnnnnnnnnnn"
        cell.tintColor = UIColor.blackColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(30)
        return cell
    }
}
