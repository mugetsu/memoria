//
//  ViewController.swift
//  memoria
//
//  Created by Randell Quitain on 26/5/21.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var models = [Reminder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func didTapAdd() {
        // show add controller
    }
    
    @IBAction func didTapTest() {
        
        UNUserNotificationCenter
            .current()
            .requestAuthorization(
                options: [.alert, .badge, .sound],
                completionHandler: { [self] success, error in
                    
                    if success {
                        scheduleTest()
                    }
                    else if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                })
    }
    
    func scheduleTest() {
        
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.sound = .default
        content.body = "A body text"
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: targetDate
            ),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if error != nil {
                print("Error")
            }
        })
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        return cell
    }
}

struct Reminder {
    let title: String
    let date: Date
    let identifier: String
}
