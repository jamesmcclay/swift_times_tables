//
//  TimesTableViewController.swift
//  TimesTables
//
//  Created by James McClay on 12/3/21.
//

import UIKit

class TimesTableViewController: UIViewController {
    
    var table:Int = {
        if let table = UserDefaults.standard.value(forKey: "table") as? Int {
            return table
        }else{
            return 2
        }
        
    }()
    var multiplier:Int = {
        if let table = UserDefaults.standard.value(forKey: "multiplier") as? Int {
            return table
        }else{
            return 2
        }
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = false
        //self.navigationController!.navigationBar.backItem?.title = "Back"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(table)
        print(multiplier)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

