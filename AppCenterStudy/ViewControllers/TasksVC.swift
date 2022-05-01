//
//  TasksVC.swift
//  AppCenterStudy
//
//  Created by 권오준 on 2022/04/07.
//

import UIKit

class TasksVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    var todoViewModel = TodoViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardNofitications()
        todoViewModel.loadTodos()
    }
    
    @IBAction func todayButtonTapped(_ sender: Any) {
        todayButton.isSelected = !todayButton.isSelected
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let isToday = todayButton.isSelected
        guard let detail = inputTextField.text, detail.isEmpty == false else { return }
        let todo = todoViewModel.createTodo(detail: detail, isToday: isToday)
        todoViewModel.addTodo(todo)
        
        var item: Int {
            return isToday ? todoViewModel.todayTodos.count : todoViewModel.upcomingTodos.count
        }
        let section = isToday ? 0 : 1
        let indexPath = [IndexPath(item: item - 1, section: section)]
        collectionView.insertItems(at: indexPath)
        
        inputTextField.text = ""
    }
    
    @IBAction func recognizeTapped(_ sender: Any) {
        inputTextField.resignFirstResponder()
    }
}

extension TasksVC: UICollectionViewDataSource, UICollectionViewDelegate {
    // count of Section Headers
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return todoViewModel.numOfSections
    }

    // count of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return todoViewModel.todayTodos.count
        } else {
            return todoViewModel.upcomingTodos.count
        }
    }
    
    // show cells in Section
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCell", for: indexPath) as? TodoListCell else {
            return UICollectionViewCell() }
        
        var todo: Todo
        if indexPath.section == 0 {
            todo = todoViewModel.todayTodos[indexPath.item]
        } else {
            todo = todoViewModel.upcomingTodos[indexPath.item]
        }
        cell.updateUI(todo: todo)
        
        cell.doneButtonTapHandler = { isDone in
            todo.isDone = isDone
            self.todoViewModel.updateTodo(todo)
            self.collectionView.reloadItems(at:[IndexPath(item: indexPath.item, section: indexPath.section)])
        }
        
        cell.deleteButtonTapHandler = {
            self.collectionView.deleteItems(at: [IndexPath(item: indexPath.item, section: indexPath.section)])
            self.todoViewModel.deleteTodo(todo)
        }
        
        return cell
    }
    
    // show Section Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as? SectionHeaderView else {
                return UICollectionReusableView()
            }
            
            guard let section = TodoViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
            header.headerLabel.text = section.title
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension TasksVC: UICollectionViewDelegateFlowLayout {
    // resize cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}

extension TasksVC {
    // adjust inputView's height
    private func keyboardNofitications() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputViewHeigt), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputViewHeigt), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustInputViewHeigt(noti: Notification) {
        guard let keyboardFrame = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            inputViewBottomConstraint.constant = keyboardFrame.height - view.safeAreaInsets.bottom
        } else {
            inputViewBottomConstraint.constant = 0
        }
    }
}
