//
//  ViewController.swift
//  memoria
//
//  Created by Randell Quitain on 26/5/21.
//

import UserNotifications
import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var models = [Reminder<Date>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        // Get user's existing reminders
        let ref = PostService.shared.userRef()
        
        ref.observeSingleEvent(of: .value, with: { [self] snapshot in
            
            let container = "reminders"
            
            if snapshot.hasChild(container) {
                
                let value = snapshot.value as! [String: Any]
                let reminders = value[container] as! [String: Any]
                
                for r in reminders {
                    
                    let id = (r.value as! [String: Any])["id"]
                    let title = (r.value as! [String: Any])["title"]
                    let body = (r.value as! [String: Any])["body"]
                    let date = Date(timeIntervalSince1970: ((r.value as! [String: Any])["date"]) as! TimeInterval)
                    let reminder = Reminder(id: id as! String, title: title as! String, body: body as! String, date: date)
                    
                    models.append(reminder)
                    
                    if date >= Date() {
                        notify(id: id as! String, title: title as! String, body: body as! String, date: date)
                    }
                }
                
                models = models.sorted(by: {$0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970})
                table.reloadData()
            }
        })
    }
    
    @IBAction func didTapAdd() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { [self] id, title, body, date in
            
            DispatchQueue.main.async {
                
                let newReminder = Reminder(id: id, title: title, body: body, date: date)
                
                navigationController?.popToRootViewController(animated: true)
                models.append(newReminder)
                table.reloadData()
                
                notify(id: newReminder.id, title: title, body: body, date: date)
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func notify(id: String, title: String, body: String, date: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = body
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: date
            ),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
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
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY / hh:mm"
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
}

struct User {
    let id: String
    let reminders: [Reminder<Date>]
}

struct Reminder<T> {
    let id: String
    let title: String
    let body: String
    let date: T
}
