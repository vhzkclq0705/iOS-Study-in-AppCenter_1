//
//  TasksVC.swift
//  AppCenterStudy
//
//  Created by 권오준 on 2022/04/07.
//

import UIKit

class TasksVC: UIViewController {

    var todoViewModel = TodoViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoViewModel.loadTodos()
    }
}

extension TasksVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Section Header의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return todoViewModel.numOfSections
    }

    // cell의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return todoViewModel.todayTodos.count
        } else {
            return todoViewModel.upcomingTodos.count
        }
    }
    
    // cell이 어떻게 표현될 것인지 나타냄
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
        
        return cell
    }
    
    // Section Header가 어떻게 표현될 것인지 나타냄
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
    // cell의 size를 나타냄
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}
