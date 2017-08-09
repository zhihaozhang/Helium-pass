//
//  TodayViewController.swift
//  楼小二Pass
//
//  Created by Chih-Hao on 2017/8/8.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var img: UIImageView!
        
    @IBAction func btnClicked(_ sender: Any) {
        refresh ()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:270)
            
        
        refresh ()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        refresh ()
        completionHandler(NCUpdateResult.newData)
    }
    
    func createQRForString(qrString: String?, qrImageName: String?) -> UIImage?{
        if let sureQRString = qrString{
            let stringData = sureQRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //创建一个二维码的滤镜
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")
            qrFilter?.setValue(stringData, forKey: "inputMessage")
            qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
            let qrCIImage = qrFilter?.outputImage
            
            // 创建一个颜色滤镜,黑白色
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(qrCIImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            // 返回二维码image
            let codeImage = UIImage(ciImage: (colorFilter.outputImage!.applying(CGAffineTransform(scaleX: 5, y: 5))))
            
            // 中间一般放logo
            if let iconImage = UIImage(named: qrImageName!) {
                let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
                
                UIGraphicsBeginImageContext(rect.size)
                codeImage.draw(in: rect)
                let avatarSize = CGSize(width: rect.size.width*0.25, height: rect.size.height*0.25)
                
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
                
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                return resultImage
            }
            return codeImage
        }
        return nil
    }
    
    
    
    func getNow() -> String{
        
        var now = Date()
        
        let dformatter = DateFormatter()
        
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970 * 1000
        let timeStamp = Int(timeInterval)

        return String(timeStamp)
        
        
    }
    
    
    func refresh (){
        var pass = "52746|18616022533|"+getNow()+"|310110B006"
        
        img.image=createQRForString(qrString: pass, qrImageName: "")
        
//        print(pass)
//        if let tryImage = EFQRCode.generate(
//            content: pass,
//            magnification: EFIntSize(width: 9, height: 9),
//            watermark: EFWatermark(image: UIImage(named: "WWF")?.toCGImage(), mode: .scaleAspectFill, isColorful: false)
//            ) {
//            img.image =  UIImage(cgImage: tryImage)
//        } else {
//            print("Create QRCode image failed!")
//        }
    }
    
}
