//
//  TasksVC.swift
//  AppCenterStudy
//
//  Created by 권오준 on 2022/04/07.
//

import UIKit

class TasksVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension TasksVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Section Header의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // cell의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // cell이 어떻게 표현될 것인지 나타냄
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCell", for: indexPath) as? TodoListCell else {
            return UICollectionViewCell() }
        
        return cell
    }
    
    // Section Header가 어떻게 표현될 것인지 나타냄
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as? SectionHeaderView else {
                return UICollectionReusableView() }
            
            header.headerLabel.text = "Today"
            
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

class TodoListCell: UICollectionViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func updateUI(todo: Todo) {
        
    }
    
    private func showStrikeThrough(_ show: Bool) {
        
    }
    
    func reset() {
        
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func deleteButtomTapped(_ sender: Any) {
        
    }
}

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
}
