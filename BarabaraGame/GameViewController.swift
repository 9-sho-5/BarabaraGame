//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by Kusunose Hosho on 2020/05/14.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var imageViewUpper: UIImageView!
    @IBOutlet var imageViewMiddle: UIImageView!
    @IBOutlet var imageViewBottom: UIImageView!
    
    @IBOutlet var resultLabel: UILabel!
    
    var timer: Timer!
    var score: Int = 1000
    let defaults: UserDefaults = UserDefaults.standard  //値を保存する時に使用する
    
    let width: CGFloat = UIScreen.main.bounds.size.width  //画面横幅  //UIScreen.main.bounds.size.widthで現在のiPhoneの画面サイズの取得
    
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]  //画像の位置の配列
    
    var dx: [CGFloat] = [1.0, 0.5, -1.0]  //画像の動かす幅の配列
    
    @objc func up() {
        for i in 0..<3 {
            //端にきたら動かす向きを逆にする
            if positionX[i] > width +  imageViewUpper.frame.size.width/2 || positionX[i] > width +  imageViewMiddle.frame.size.width/2 || positionX[i] > width +  imageViewBottom.frame.size.width/2 || positionX[i] < 0 - imageViewUpper.frame.size.width/2 || positionX[i] < 0 - imageViewMiddle.frame.size.width/2 || positionX[i] < 0 - imageViewBottom.frame.size.width/2{
                dx[i] = dx[i] * (-1)
            }
            //画像に位置をdx分ずらす
            positionX[i] += dx[i]
        }
        imageViewUpper.center.x = positionX[0]
        imageViewMiddle.center.x = positionX[1]
        imageViewBottom.center.x = positionX[2]
    }
    
    @IBAction func stop() {
        if timer.isValid == true {  //タイマーが動いていたら
            //タイマーを止める
            timer.invalidate()
            
            for i in 0..<3 {
                //absは真ん中からどれだけずれているか　ズレ分だけ減点
                score = score - abs(Int(width/2 - positionX[i]))*2
            }
            resultLabel.text = "Score : " + String(score)
            resultLabel.isHidden = false
            
            let highScore1: Int = defaults.integer(forKey: "score1")
            let highScore2: Int = defaults.integer(forKey: "score2")
            let highScore3: Int = defaults.integer(forKey: "score3")
            
            if score > highScore1 { //もしランキング１位の記録を更新したら
                defaults.set(score, forKey: "score1")  //score1をscoreに更新
                defaults.set(highScore1, forKey: "score2")  //元のhighScore1をscore2に更新
                defaults.set(highScore2, forKey: "score3")  //元のhighScore2をscore3に更新
            } else if score > highScore2 {
                defaults.set(score, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
            } else if score > highScore3 {
                defaults.set(score, forKey: "score3")
            }
            
        }else if timer.isValid == false{
            retry()
        }
    }
    
    func start() {
        resultLabel.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        
        timer.fire()
        
    }
    
    @IBAction func retry() {
        score = 1000 //スコアのリセット
        positionX = [width/2, width/2, width/2]
        if timer.isValid == false {  //タイマーが動いていなかったら
            self.start()
        }
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]
        self.start()
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
