//
//  ViewController.swift
//  FuzzChat
//
//  Created by Teymur Kazakov on 6/27/21.
//

import UIKit
import MultipeerConnectivity
import UserNotifications
import AVKit
import BackgroundTasks
import Foundation
import SpriteKit

/*extension Notification.Name {
  static let newPokemonFetched = Notification.Name("com.TeymurKazakov.fetchFuzzChat")
}

public protocol VideoPickerDelegate: AnyObject {
    func didSelect(url: URL?)
}*/


class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate {
    
    // The main page: the motherfuzzin' god of FuzzChat
     
    @IBOutlet weak var ConnectionLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var GoodByeButton: UIButton!
    @IBOutlet weak var ThankYouButton: UIButton!
    @IBOutlet weak var NopeButton: UIButton!
    @IBOutlet weak var LoveYouButton: UIButton!
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var TextBox: UITextView!
    @IBOutlet weak var InputBox: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet var ViewController: UIView!
    @IBOutlet weak var ConnectionButton: UIButton!
    
    
    let FuzzyChatServiceType = "FuzzCenter"
    var img2 = UIImage()
    var messageInfoFormIsString = Int()
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var advertiserAssistant: MCNearbyServiceAdvertiser!
    var browser: MCNearbyServiceBrowser!
    var recordMessage: String!
    var sendMessage: String!
    var hosting: Bool!
    var DidjaDoIt: Bool!
    let center = UNUserNotificationCenter.current()
    var background = UIBackgroundTaskIdentifier(rawValue: 0)
    var publicVideo = AVMovie()
    var IsItAnImage = Bool()
    var placeholder = UILabel()
    var friendEnd = Bool()
    var goneEnd = Bool()
    var otherEnd = Bool()
    var backup = Bool()
    

    var textThing = UITextField()
    
    
    static let urlSession = URLSession(configuration: .default)
    
     
     override func viewDidLoad() {
        super.viewDidLoad()
          
          

        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.removeKeyboard(_:)))
        view.addGestureRecognizer(tap)
        SendButton.isEnabled = true
        TextBox.isEditable = false
        hosting = false
        mcSession.disconnect()
        DidjaDoIt = false
        center.requestAuthorization(options: [.alert, .sound]){
             (granted, error) in
        }
          
        ImageView.alpha = 0
        friendEnd = false
        goneEnd = false
        otherEnd = false
     
        checkBackgroundRefreshStatus()
          
         NotificationCenter.default.addObserver(
               self,
               selector: #selector(backgroundRefreshStatusDidChange2),
               name: UIApplication.backgroundRefreshStatusDidChangeNotification, object: nil)
         //setup for the real operation
          
      
          
          
          if let state = userDefault3.value(forKey: "submittedNum") as? String{
               print("\(state)")
               if state == "empty"{
                    userDefault3.set("empty", forKey: "submittedNum")
                    print("\(state)")
               }else if state == "true"{
                    userDefault3.set("true", forKey: "submittedNum")
                    print("\(state)")
               }else if state == "false"{
                    userDefault3.set("false", forKey: "submittedNum")
                    print("\(state)")
               }else{
                    userDefault3.set("empty", forKey: "submittedNum")
                    print("\(state)")
               }
          }
          
          if let state = userDefault3.value(forKey: "submittedNum") as? String{
               print("\(state)2")
               if state == "empty"{
                    userDefault3.set("false", forKey: "submittedNum")
                    print("false")
               }else{
                    userDefault3.set("true", forKey: "submittedNum")
                    print("true")
                    
               }
          }

          
          if let submitted = userDefault3.value(forKey: "submittedNum") as? String{
               
               
               
               if submitted == "false"{
                    userDefault2.set("FuzzCenter", forKey: "ChatName")
                    let PhoneNumberSheet = UIAlertController(title: "Enter Phone Number", message: "This will be emergency contact, only enter the 10 numbers, no dashes, parantheses, +1, no emojis and no spaces", preferredStyle: .alert)
                    
                    
                    PhoneNumberSheet.addTextField { textThing in
                         textThing.placeholder = "Enter Phone Number"
                    }
                    
                    
                    
                    PhoneNumberSheet.addAction(UIAlertAction(title: "SUBMIT", style: .default, handler: {(action) in
                         PhoneNumber = String("\(PhoneNumberSheet.textFields?.first?.text ?? "None")")
                         print(String("\(PhoneNumber)"))
                         userDefault.set(PhoneNumber, forKey: "PhoneNumber")
                         
                    }))
                    
                    PhoneNumberSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(PhoneNumberSheet, animated: true, completion: nil)
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    
                    self.present(PhoneNumberSheet, animated: true, completion: nil)
                    
               }else if submitted == "true"{
                    
                    print("hwat")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    userDefault3.set("true", forKey: "submittedNum")
                    
               }else{
                    print("mep")
               }
          }
          
          
         
          
          UserDefaults.standard.register(defaults: ["submittedNum" : "empty"])
          
     }
    

    
    
    
    @objc func backgroundRefreshStatusDidChange2() {
       print("New status: \(UIApplication.shared.backgroundRefreshStatus)")
     }
    
    func checkBackgroundRefreshStatus() {
      switch UIApplication.shared.backgroundRefreshStatus {
      case .available:
        print("Background fetch is enabled")
      case .denied:
        print("Background fetch is explicitly disabled")
        
        // Redirect user to Settings page only once; Respect user's choice is important
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
      case .restricted:
        // Should not redirect user to Settings since he / she cannot toggle the settings
        print("Background fetch is restricted, e.g. under parental control")
      default:
        print("Unknown property")
      }
    }

   
     /*@IBAction func SendVideo(_ sender: Any) {
        
        IsItAnImage = false
        
      let videoPickerController = UIImagePickerController()
        
        videoPickerController.delegate = self
        videoPickerController.sourceType = .savedPhotosAlbum
        videoPickerController.mediaTypes = ["public.movie"]
        videoPickerController.allowsEditing = false
        present(videoPickerController, animated: true){
            
           print("boom, video")
            
        }
    }*/
    
     @IBAction func EMERGENCY(_ sender: Any) {
          
          print("yay!")
          
     }
     
    @IBAction func SendImage(_ sender: Any) {
        
        IsItAnImage = true
        
        let image2 = UIImagePickerController()
        image2.delegate = self
        
        image2.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image2.allowsEditing = false
        
        print("preparing")
        
        self.present(image2, animated: true){
            
            print("ready")
            
        }
        
        
        
            
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                self.dismiss(animated: true, completion: nil)
            }



        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            print("yay!")
            let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            ImageView.image = image
        }
    }
    

    
    @IBAction func YesButton(_ sender: Any) {
        sendMessage = "\n\(peerID.displayName) : Yes \n"
 
        let message = sendMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        do {
            
            try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
            
        }
        catch {
                
                print("error sending message")
                
            }
        
        TextBox.text = "\nMe: Yes \n" + TextBox.text
        
        
    }
    
    
    
    @IBAction func NopeButton(_ sender: Any) {
        sendMessage = "\n\(peerID.displayName) : No \n"

        let message = sendMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        do {
            
            try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
            
        }
        catch {
                
                print("error sending message")
                
            }
        
        TextBox.text =  "\nMe: No \n" + TextBox.text
        
        }
    
    
    
    @IBAction func LoveYouButton(_ sender: Any) {
        sendMessage = "\n\(peerID.displayName) : Love you \n"

        let message = sendMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        do {
            
            try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
            
        }
        catch {
                
                print("error sending message")
                
            }
        
        TextBox.text = "\nMe: Love you \n" + TextBox.text
        
    }
    
    
    @IBAction func GoodByeButton(_ sender: Any) {
        sendMessage = "\n\(peerID.displayName) : Goodbye \n"
    
        let message = sendMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        do {
            
            try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
            
        }
        catch {
                
                print("error sending message")
                
            }
        
        TextBox.text = "\nMe: Goodbye \n" + TextBox.text
    }
    
    
    
    @IBAction func ThankYouButton(_ sender: Any) {
        sendMessage = "\n\(peerID.displayName) : Thank you \n"
     
        let message = sendMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        do {
            
            try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
            
        }
        catch {
                
                print("error sending message")
                
            }
        
        TextBox.text = "\nMe: Thank you\n" + TextBox.text
        
       
    }
    
    
    
    
    @objc func removeKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    
    @IBAction func Sent(_ sender: Any) {
        if InputBox.text != ""{
            
            view.endEditing(true)
            
            
            sendMessage = "\n\(peerID.displayName) : \(InputBox.text!)\n"
     
            
            let message = sendMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
            
            do {
                
                try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
                
            }
            catch {
                    
                    print("error sending message")
                    
                }
            
            TextBox.text = "\nMe: \(InputBox.text!)\n" + TextBox.text
            
            InputBox.text = ""
                
            
            
        }
    }

     // action buttons setup
     
     
    @IBAction func ConnectionButton(_ sender: Any) {
        if mcSession.connectedPeers.count == 0 {
             if let name = userDefault2.value(forKey: "ChatName") as? String{
                  
                  ChatName = String(name)
                  
             }
            
             let mcBrowser = MCBrowserViewController(serviceType: "\(ChatName)", session: self.mcSession)
                mcBrowser.delegate = self
                self.present(mcBrowser, animated: true, completion: nil)
            self.hosting = true
             
        }else{
            
            let disconnectActionSheet = UIAlertController(title: "Are you sure you want to disconnect?", message: nil, preferredStyle: .actionSheet)
            disconnectActionSheet.addAction(UIAlertAction(title: "Disconnect", style: .destructive, handler: {(action:UIAlertAction) in
                self.mcSession.disconnect()
                self.DidjaDoIt = true
                self.hosting = false
                self.friendEnd = true
            }))
                    disconnectActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(disconnectActionSheet, animated: true, completion: nil)
        }
    }
    
     //operation after using the connection button
     @objc func fadething(){
          
          
          self.ImageView.alpha -= 0.01
          print("beep")
          
     }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected!!!")
            
            DispatchQueue.main.async {

                self.ConnectionLabel.font = UIFont.systemFont(ofSize: 18.0)
                self.ConnectionLabel.text = "Connected to: \(peerID.displayName)"
                
                let ConnectionWarning = UIAlertController(title: """
                Do you want to connect \(peerID.displayName)
                """, message: nil, preferredStyle: .actionSheet)
                
                ConnectionWarning.addAction(UIAlertAction(title: "Connect", style: .cancel, handler: nil))
                
                ConnectionWarning.addAction(UIAlertAction(title: "Block!", style: .destructive, handler: {(action: UIAlertAction) in
                    self.mcSession.disconnect()
                     print("tata!")
                }))
                
                self.present(ConnectionWarning, animated: true, completion: nil)
                
            }
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        case MCSessionState.connecting:
            print("working...")
            
            
            
        case MCSessionState.notConnected:
            
            DispatchQueue.main.async {

                self.ConnectionLabel.font = UIFont.systemFont(ofSize: 38.0)
                self.ConnectionLabel.text = "Connect Now"
                
            }
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

        DispatchQueue.main.async {
             
             if self.friendEnd == true{
                     let disconnectedAlert = UIAlertController(title: "Thread Ended", message: nil, preferredStyle: .alert)
                  
                  disconnectedAlert.addAction(UIAlertAction(title: "Alright", style: .cancel, handler: nil))
                  
                  self.present(disconnectedAlert, animated: true, completion: nil)
                  
             }else{
                   let disconnectedAlert = UIAlertController(title: "Connection Lost", message: nil, preferredStyle: .alert)
                  
                  disconnectedAlert.addAction(UIAlertAction(title: "Alright", style: .cancel, handler: nil))
                  
                  self.present(disconnectedAlert, animated: true, completion: nil)
             }
                    
                    
                    
                }
            
        default:
            print("wtf")
        }
        
        
        
    }
     
     //session operations set up
     
     
     override func viewWillAppear(_ animated: Bool) {
          
          
          
          if let number = userDefault.value(forKey: "PhoneNumber") as? String{
               
            
                  PhoneNumber = String(number)

               
          }
          
          if let name = userDefault2.value(forKey: "ChatName") as? String{
               
               ChatName = String(name)
               label.text = String(name)
               
          }
          
          self.advertiserAssistant = MCNearbyServiceAdvertiser(peer: self.peerID, discoveryInfo: nil, serviceType: "\(ChatName)")
         self.advertiserAssistant.delegate = self
         self.advertiserAssistant.startAdvertisingPeer()
     }
     //userdefaults, keeping all info and loading it before it's too late
  
     
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        
    
         DispatchQueue.main.async { [self] in
                
            if let _ = UIImage(data: data) {
                
                print("it works!!!")
                
                let dataEmbassidor: Data?? = data
               
                let stringsDataEmbassidor = String("\(dataEmbassidor)")
                
                  print(String(describing: stringsDataEmbassidor))
                 
                 self.ImageView.alpha = 1.0
                 
                 
                self.ImageView.image = UIImage(data: data)
                 
                 
                                            
                                            guard let inputImage = self.ImageView.image else { return }
                                            
                                            UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
                        
                 Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.fadething), userInfo: nil, repeats: true)
                        
            } else if let _ = String(data: data, encoding: String.Encoding.utf8){
                
                print("it works... in a way...")
                
                    
                self.recordMessage = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
                                        self.TextBox.text = self.recordMessage + self.TextBox.text
                
            }else {
                
           
                 /*UISaveVideoAtPathToSavedPhotosAlbum(nil, nil, nil, nil)*/

                
            }
             

                
            let content = UNMutableNotificationContent()
            content.body = "Your friend is trying to call you!"
            content.title = "Go to FuzzChat!"
            
             let date = Date().addingTimeInterval(2)
            
            let DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents, repeats: false)
            
            
            let uuidStringg = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: uuidStringg, content: content, trigger: trigger)
            
            self.center.add(request) { (error) in
                
            }
        }
    }
     
     //handling data
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, mcSession)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        dismiss(animated: true)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        dismiss(animated: true)
    }
    //meh
 
    
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     
     }
     
    // finilization for the class
       
    
}






extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
self.dismiss(animated: true)
}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
print("lll")
self.dismiss(animated: true, completion: {

    
    
    switch self.IsItAnImage{
    
                          case true:
    
        let img:UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
         
         self.ImageView.alpha = 1.0
            
           self.ImageView.image = img

            self.img2 = img!
         
         Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.fadething), userInfo: nil, repeats: true)
         
                    
            let message2 = img!.pngData()

                    do {
                        
                        try self.mcSession.send(message2!, toPeers: self.mcSession.connectedPeers, with: .reliable)
                        
                    }
                    catch {
                            
                            print("error sending message")
                            
            }
    
                        case false:
    
        do {
            
            let vid:AVMovie? = info[UIImagePickerController.InfoKey.originalImage] as? AVMovie
            
            let message3 = vid!.data
            
            try self.mcSession.send(message3!, toPeers: self.mcSession.connectedPeers, with: .reliable)
            
        }catch {
            
            print("error sending message")
    
     }
    }
  })
 }
}


// compressing photos and videos, but for now, just photots.
