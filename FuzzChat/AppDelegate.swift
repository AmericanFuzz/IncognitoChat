//
//  AppDelegate.swift
//  FuzzChat
//
//  Created by Teymur Kazakov on 6/27/21.
//

import UIKit
import BackgroundTasks

let appRefreshTaskId = "com.TeymurKazakov.refresh"
let appProcessingTaskId = "com.TeymurKazakov.BackgroundAppProcessingIdentifier"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //handles states of the application
    
    
    
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
        
        func scheduleAppRefresh() {
            
            
            let request = BGAppRefreshTaskRequest(identifier: "com.TeymurKazakov.refresh")
            request.earliestBeginDate = Date(timeIntervalSinceNow: 1) // Fetch no earlier than 1 second from now
            
            do {
                try BGTaskScheduler.shared.submit(request)
            } catch {
                print("Could not schedule app refresh: \(error)")
            }
        }//submitted a request for background tasks
        
        
        registerBackgroundTasks()
        
        func registerBackgroundTasks() {
            
            func handleAppRefresh(task: BGAppRefreshTask) {
                scheduleAppRefresh()
                
            }
            
            
         
          
            
            
            BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.TeymurKazakov.refresh", using: nil) { task in
                print("BackgroundAppRefreshTaskScheduler is executed NOW!")
                print("Background time remaining: \(UIApplication.shared.backgroundTimeRemaining)s")
                 handleAppRefresh(task: task as! BGAppRefreshTask)
                 task.setTaskCompleted(success: true)
                 task.expirationHandler = {
                          task.setTaskCompleted(success: false)
                     
                     
             }
            }
           }
      
        
        
        
        

   return true
}
    
    
   
 
    // MARK: FuzzKit

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
        
        
        
            }
    

    


}


