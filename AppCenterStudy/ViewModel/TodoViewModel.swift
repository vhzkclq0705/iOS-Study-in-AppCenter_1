//
//  TodoViewModel.swift
//  AppCenterStudy
//
//  Created by 권오준 on 2022/05/01.
//

import Foundation

class TodoViewModel {
    
    static let shared = TodoViewModel()
    
    private init() { }
    
    var lastId: Int = 0
    
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    
    var todos = [Todo]()
    
    var todayTodos: [Todo] {
        return todos.filter{ $0.isToday == true }
    }
    
    var upcomingTodos: [Todo] {
        return todos.filter{ $0.isToday == false }
    }
    
    var numOfSections: Int {
        return Section.allCases.count
    }
    
    func createTodo(detail: String, isToday: Bool) -> Todo {
        let nextId = lastId + 1
        lastId = nextId
        
        return Todo(id: nextId, isDone: false, detail: detail, isToday: isToday)
    }
    
    func addTodo(_ todo: Todo) {
        todos.append(todo)
        saveTodo()
    }
    
    func deleteTodo(_ todo: Todo) {
        todos = todos.filter{ $0.id != todo.id }
        saveTodo()
    }
    
    func updateTodo(_ todo: Todo) {
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
        saveTodo()
    }
    
    func saveTodo() {
        Storage.saveTodo(todo: todos, fileName: "TodoList.json")
    }
    
    func loadTodos() {
        todos = Storage.loadTodo(fileName: "TodoList.json") ?? []
        
        let loadLastId = todos.last?.id ?? 0
        lastId = loadLastId
    }
}
