//
//  Help.swift
//  FuzzChat
//
//  Created by Teymur Kazakov on 7/6/22.
//

import Foundation
import UIKit
import BackgroundTasks

class Help: UIViewController {
    
    var label = UILabel()
    var label2 = UILabel()
    //the settings popup accessible through the press of the gear n' wrench

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
        override func viewWillAppear(_ animated: Bool) {
         if let number = userDefault.value(forKey: "PhoneNumber") as? String{
           
                 PhoneNumber = String(number)
            

              
         }
         if let name = userDefault2.value(forKey: "ChatName") as? String{
              
              ChatName = String(name)
         
              
         }
        
    }
    
 

}
