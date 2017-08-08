//
//  ViewController.swift
//  新氦Pass
//
//  Created by Chih-Hao on 2017/8/8.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import UIKit
import EFQRCode
class ViewController: UIViewController {

    @IBOutlet weak var QRimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshbtnClicked(_ sender: Any) {
        refresh ()
    }
    
    func refresh (){
        var pass = "52674|13162978698|"+(getNow())+"|310110B006"
        
        if let tryImage = EFQRCode.generate(
            content: pass,
            magnification: EFIntSize(width: 9, height: 9),
            watermark: EFWatermark(image: UIImage(named: "WWF")?.toCGImage(), mode: .scaleAspectFill, isColorful: false)
            ) {
            QRimg.image =  UIImage(cgImage: tryImage)
        } else {
            print("Create QRCode image failed!")
        }
    }
    
    
    func getNow() -> String{
        
        var now = Date()
        
        let dformatter = DateFormatter()
     
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        print(String(timeStamp)+"999")
        return String(timeStamp)+"999"
        
        
    }

    
    
   

}

