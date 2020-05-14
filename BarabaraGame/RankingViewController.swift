//
//  RankingViewController.swift
//  BarabaraGame
//
//  Created by Kusunose Hosho on 2020/05/14.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var rankingLabe2: UILabel!
    @IBOutlet var rankingLabe3: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard  //スコアをh保存するための変数
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rankingLabel.text = String(defaults.integer(forKey: "score1"))
        rankingLabe2.text = String(defaults.integer(forKey: "score2"))
        rankingLabe3.text = String(defaults.integer(forKey: "score3"))
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
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
