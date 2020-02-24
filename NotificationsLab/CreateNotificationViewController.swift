//
//  CreateNotificationViewController.swift
//  NotificationsLab
//
//  Created by Jaheed Haynes on 2/20/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit

protocol CreateNotificationControllerDelegate: AnyObject {
    func didCreateNotification(_ createNotificationController: CreateNotificationViewController)
}

class CreateNotificationViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    weak var delegate: CreateNotificationControllerDelegate?
       
       private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func createLocalNotification() {
        // MARK: Step 1
        let content = UNMutableNotificationContent()
        content.title = titleTextField.text ?? "something"
        content.body = "Hey you there...Yeah You"
        content.subtitle = "Local Notification Lab"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "GOT-Theme.mp3"))
        
        
        
        // MARK: Step 2
        let identifier = UUID().uuidString
        
        if let imageURL = Bundle.main.url(forResource: "tickle the dragon", withExtension: "png"){
            do {
                let attachment = try UNNotificationAttachment(identifier: identifier, url: imageURL, options: nil)
                content.attachments = [attachment]
            } catch {
                print("error with attachment: \(error)")
            }
        } else {
            print("image resource could not be found")
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        
  
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
     
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error adding request: \(error)")
            } else {
                print("request added")
            }
        }
    }
    
    @IBAction func timePickerChanged(_ sender: UIDatePicker) {
        guard sender.date > Date() else {return}
        timeInterval = sender.date.timeIntervalSinceNow
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        createLocalNotification()
        delegate?.didCreateNotification(self)
        dismiss(animated: true)
    }
    
    

}
