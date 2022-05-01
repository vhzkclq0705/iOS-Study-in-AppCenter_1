//
//  TodoListCell.swift
//  AppCenterStudy
//
//  Created by 권오준 on 2022/05/01.
//

import Foundation
import UIKit

class TodoListCell: UICollectionViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func updateUI(todo: Todo) {
        checkButton.isSelected = todo.isDone
        descriptionLabel.text = todo.detail
        descriptionLabel.alpha = todo.isDone ? 0.2 : 1
        deleteButton.isHidden = !todo.isDone
        showStrikeThrough(todo.isDone, detail: descriptionLabel.text!)
    }
    
    private func showStrikeThrough(_ show: Bool, detail: String) {
        let attributedText: NSAttributedString
        if show {
            attributedText = NSAttributedString(string: detail,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        } else {
            attributedText = NSAttributedString(string: detail)
        }
        descriptionLabel.attributedText = attributedText
    }
    
    func reset() {
        descriptionLabel.alpha = 1
        deleteButton.isHidden = true
        showStrikeThrough(false, detail: "")
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
        let isDone = checkButton.isSelected
        showStrikeThrough(isDone, detail: descriptionLabel.text!)
        descriptionLabel.alpha = isDone ? 0.2 : 1
        deleteButton.isHidden = !isDone
        
        doneButtonTapHandler?(isDone)
    }
    
    @IBAction func deleteButtomTapped(_ sender: Any) {
        deleteButtonTapHandler?()
    }
}
