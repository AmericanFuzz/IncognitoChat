//
//  Settings.swift
//  FuzzChat
//
//  Created by Teymur Kazakov on 7/2/22.
//

import UIKit
import BackgroundTasks

class SettingsForFuzzChat: UIViewController, UITextFieldDelegate {
    
    var label = UILabel()
    var label2 = UILabel()
    //the settings popup accessible through the press of the gear n' wrench

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ChatRoomChange(_ sender: Any) {
        
        let AnotherSheet = UIAlertController(title: "Enter Country name", message: "No Acronyms", preferredStyle: .alert)
      
        AnotherSheet.addTextField { textThing in
            textThing.delegate = self
             textThing.placeholder = "Enter a name"
            textThing.autocorrectionType = UITextAutocorrectionType.yes
        
        }
        
        
        
        AnotherSheet.addAction(UIAlertAction(title: "SUBMIT", style: .default, handler: {(action) in
             ChatName = String("\(AnotherSheet.textFields?.first?.text ?? "None")")
             print(String("\(ChatName)"))
             userDefault2.set(ChatName, forKey: "ChatName")
            self.label2.text = ChatName
             
        }))
        
        AnotherSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(AnotherSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func UserDefaultsChange(_ sender: Any) {
        
        let AnotherSheet = UIAlertController(title: "Enter Phone Number", message: "This will be emergency contact, only enter the 10 numbers, no dashes, parantheses, +1, no emojis and no spaces", preferredStyle: .alert)
      
        AnotherSheet.addTextField { textThing in
             textThing.placeholder = "Enter Phone Number"
        }
        
        AnotherSheet.addAction(UIAlertAction(title: "SUBMIT", style: .default, handler: {(action) in
             PhoneNumber = String("\(AnotherSheet.textFields?.first?.text ?? "None")")
             print(String("\(PhoneNumber)"))
             userDefault.set(PhoneNumber, forKey: "PhoneNumber")
            self.label.text = PhoneNumber
             
        }))
        
        AnotherSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(AnotherSheet, animated: true, completion: nil)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         if let number = userDefault.value(forKey: "PhoneNumber") as? String{
           
                 PhoneNumber = String(number)
             
             label = UILabel(frame: CGRect(x: -50, y: 120, width: 500, height: 500))
                label.textAlignment = .center
                label.textColor = UIColor.black
             label.font = UIFont.boldSystemFont(ofSize: 30.0)
                label.text = String(number)

                self.view.addSubview(label)

              
         }
         if let name = userDefault2.value(forKey: "ChatName") as? String{
              
              ChatName = String(name)
             
             label2 = UILabel(frame: CGRect(x: -50, y: 320, width: 500, height: 500))
                label2.textAlignment = .center
                label2.textColor = UIColor.black
             label2.font = UIFont.boldSystemFont(ofSize: 30.0)
                label2.text = String(name)

                self.view.addSubview(label2)
              
         }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        if (string == ".") {
            return false
        }
        if (string == ":") {
            return false
        }
        if (string == ";") {
            return false
        }
        if (string == "1") {
            return false
        }
        if (string == "2") {
            return false
        }
        if (string == "3") {
            return false
        }
        if (string == "4") {
            return false
        }
        if (string == "5") {
            return false
        }
        if (string == "6") {
            return false
        }
        if (string == "7") {
            return false
        }
        if (string == "8") {
            return false
        }
        if (string == "9") {
            return false
        }
        if (string == "0") {
            return false
        }
        if (string == "(") {
            return false
        }
        if (string == ")") {
            return false
        }
        if (string == "-") {
            return false
        }
        if (string == "_") {
            return false
        }
        if (string == "@") {
            return false
        }
        if (string == "?") {
            return false
        }
        if (string == "/") {
            return false
        }
        if (string == "|") {
            return false
        }
        if (string == "+") {
            return false
        }
        if (string == "=") {
            return false
        }
        if (string == "*") {
            return false
        }
        if (string == "&") {
            return false
        }
        if (string == "^") {
            return false
        }
        if (string == "%") {
            return false
        }
        if (string == "#") {
            return false
        }
        if (string == "!") {
            return false
        }
        if (string == "`") {
            return false
        }
        if (string == "~") {
            return false
        }
        if (string == ",") {
            return false
        }
        if (string == ">") {
            return false
        }
        if (string == "<") {
            return false
        }
        if (string == "{") {
            return false
        }
        if (string == "}") {
            return false
        }
        if (string == "[") {
            return false
        }
        if (string == "]") {
            return false
        }
        if (string == "$") {
            return false
        }
        return true
    }

}
