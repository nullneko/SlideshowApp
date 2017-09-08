//
//  ViewController.swift
//  SlideshowApp
//
//  Created by HiroshiKitahara on 2017/09/05.
//  Copyright © 2017年 HiroshiKitahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slideActionButton: UIButton!
    
    // segueを使用して戻って来た値を格納する変数
    var imageName: String = ""
    
    // 画像の配列を作成します
    let imageNameArray: [Int: String] = [
        1: "husky",
        2: "cat",
        3: "white_lion"
    ]
    
    // 画像表示の際に何番目を選択しているの判断するために初期値として0を代入
    var selectImgNum: Int = 1
    
    // 表示する画像を格納する変数
    var name: String = ""
    
    // 自動Slideさせるための変数を定義
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 関数化し初期画像を表示
        displayImage("default")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // segueを使用し遷移先に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        resultViewController.imgName = imageNameArray[selectImgNum]!
    }
    
    // 戻るボタン押した際
    @IBAction func backButton(_ sender: Any) {
        selectImgNum -= 1
        selectImgNum == 0 ? displayImage("last") : displayImage("back")
    }
    
    // 再生 or 停止を押した際
    @IBAction func slideButton(_ sender: Any) {

        if slideActionButton.currentTitle! == "再生" {
            slideActionButton.setTitle("停止", for: UIControlState.normal)
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextButton), userInfo: nil, repeats: true)
        }else if slideActionButton.currentTitle! == "停止" {
            slideActionButton.setTitle("再生", for: UIControlState.normal)
            timer.invalidate()
        }
    }
    
    // 進むボタン押した際
    @IBAction func nextButton(_ sender: Any) {
        selectImgNum += 1
        selectImgNum <= imageNameArray.count ? displayImage("next") : displayImage("default")
    }
    
    // 画像がタップされた際
    @IBAction func tapImage(_ sender: Any) {
        performSegue(withIdentifier: "enlargedImage", sender: nil)
    }
    
        // 遷移で戻って来た際
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        name = imageNameArray[selectImgNum]!
        let backImg = UIImage(named: name)!
        imageView.image = backImg
    }
    
    func displayImage(_ mode: String){
        
        switch mode {
        case "default":
            name = imageNameArray[1]!
            selectImgNum = 1
        case "last":
            name = imageNameArray[imageNameArray.count]!
            selectImgNum = imageNameArray.count
        default:
            name = imageNameArray[selectImgNum]!
        }

        let imgData = UIImage(named: name)
        imageView.image = imgData
    }
    
   
}

