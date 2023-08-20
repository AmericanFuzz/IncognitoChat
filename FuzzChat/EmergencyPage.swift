//
//  EmergencyPage.swift
//  FuzzChat
//
//  Created by Teymur Kazakov on 6/16/22.
//

import UIKit
import MessageUI
import AVFoundation


class EmergencyPage: UIViewController, MFMessageComposeViewControllerDelegate {
    
    
    

    var label = UILabel()
    var TimerValue = Int()
   
  
    var volume: Float = 0.1
    
    // the emergency popup that can be accesible by the emergency button
    
    @IBOutlet var AbortButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TimerValue = 30
        
    
        
        
        label = UILabel(frame: CGRect(x: -50, y: 130, width: 500, height: 500))
           label.textAlignment = .center
           label.textColor = UIColor.red
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
    
            label.text = String(TimerValue)
        
           

           self.view.addSubview(label)
        
        
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(COUNTDOWN), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(FLASH), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         if let number = userDefault.value(forKey: "PhoneNumber") as? String{
              
           
                 label.text = String(number)
             PhoneNumber = String(number)

              
         }
         if let name = userDefault2.value(forKey: "ChatName") as? String{
              
              ChatName = String(name)
              
         }
    }
    
    func makeAFuzzCall()  {
        let urlSchema = "tel:"
        let numberToCall = "\(PhoneNumber)"
        if let numberToCallURL = URL(string: "\(urlSchema)\(numberToCall)")
        {
            if UIApplication.shared.canOpenURL(numberToCallURL)
            {
                UIApplication.shared.open(numberToCallURL)
            }
        }
        
        
        
    }
 
    
        
   
         
    
    
    
    
    
    @objc func COUNTDOWN(){
        userDefault4.set(true, forKey: "flash")
        TimerValue -= 1
        label.text = String(TimerValue)
        HapticsManager.shared.beginVibration(type: .success)
        
        if TimerValue < 11{
            AbortButton.isEnabled = false
            AbortButton.alpha = 0.5
        }
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
             guard device.hasTorch else { return }

         do {
                 try device.lockForConfiguration()

                 if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                     device.torchMode = AVCaptureDevice.TorchMode.off
                 } else {
                     do {
                         try device.setTorchModeOn(level: 1.0)
                     } catch {
                         print(error)
                     }
                 }

                 device.unlockForConfiguration()
             } catch {
                 print(error)
             }
        
        if TimerValue == 0{
            self.makeAFuzzCall()
            timer.invalidate()
            timer2.invalidate()
            /*if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
                        controller.body = "Message Body"
                        controller.recipients = ["\(PhoneNumber)"]
                        controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
            
            }
             */
        }
        
    }
    
        
    @objc func FLASH(){
  
        
        self.view.backgroundColor = UIColor.red
        
        timer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(FLASH2), userInfo: nil, repeats: false)
        
       
               
        }
    
    
    
    @objc func FLASH2(){
        
        self.view.backgroundColor = UIColor.black
        
       
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func AbortButton(_ sender: Any) {
        
        let urlScheme = "tel:"
        let numberToCall = "\(PhoneNumber)"
        if let numberToCallURL = URL(string: "\(urlScheme)\(numberToCall)")
        {
            if UIApplication.shared.canOpenURL(numberToCallURL)
            {
                UIApplication.shared.open(numberToCallURL)
                
            }
           }
          }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        timer.invalidate()
        timer2.invalidate()
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
            guard device.hasTorch else { return }

        do {
                try device.lockForConfiguration()

                if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                    device.torchMode = AVCaptureDevice.TorchMode.off
                     print("off")
                } else {
                    do {
                        try device.setTorchModeOn(level: 0.1)
                    } catch {
                        print(error)
                    }
                }

                device.unlockForConfiguration()
            } catch {
                print("error")
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    


}
