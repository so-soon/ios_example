//
//  Todo.swift
//  Todos
//
//  Created by soonhyuk on 2020/04/08.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import Foundation
import UserNotifications

struct Todo: Codable{
    var title: String
    var due: Date
    var memo: String?
    var shouldNotify: Bool
    var id: String
    
}

extension Todo {
    
    static var all: [Todo] = Todo.loadTodosFromJSONFile()
    
    
    private static var todosPathURL: URL {
        return try! FileManager.default.url(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("todos.json")
    }
    
    private static func loadTodosFromJSONFile() -> [Todo]{
        do{
            let jsonData: Data = try Data(contentsOf: self.todosPathURL)
            let todos: [Todo] = try JSONDecoder().decode([Todo].self, from: jsonData)
            return todos
        }catch{
            print(error.localizedDescription)
        }
        
        return []
    }
    
    @discardableResult private static func saveToJSONFile() -> Bool {
        do{
            let data: Data = try JSONEncoder().encode(self.all)
            try data.write(to: self.todosPathURL, options: Data.WritingOptions.atomicWrite)
            return true
        }catch{
            print(error.localizedDescription)
        }
        return false
    }
}

extension Todo {
    
    @discardableResult static func remove(id: String) -> Bool {
        
        guard let index: Int = self.all.firstIndex(where: { (todo: Todo) -> Bool in todo.id == id }) else { return false }
        self.all.remove(at: index)
        return self.saveToJSONFile()
        
    }
    
    @discardableResult func save(completion: () -> Void) -> Bool {
        if let index = Todo.index(of: self) {
            Todo.removeNotification(todo: self)
            Todo.all.replaceSubrange(index...index, with: [self])
        } else {
            Todo.all.append(self)
        }
        
        let isSuccess: Bool = Todo.saveToJSONFile()
        
        if isSuccess{
            if self.shouldNotify{
                Todo.addNotification(todo: self)
            } else {
                Todo.removeNotification(todo: self)
            }
            completion()
        }
        
        return isSuccess
        
    }
    
    private static func index(of target: Todo) ->Int? {
        guard let index: Int = self.all.firstIndex(where: { (todo: Todo) -> Bool in todo.id == target.id})  else { return nil }
        
        return index
        
    }
}

extension Todo {
    
    private static func addNotification(todo: Todo){
        
        let center: UNUserNotificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "todo"
        content.body = todo.title
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let dateInfo = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute], from: todo.due)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let request = UNNotificationRequest(identifier: todo.id, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: { (error: Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        })
    }

    private static func removeNotification(todo: Todo){
        let center: UNUserNotificationCenter = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [todo.id])
    }
}
