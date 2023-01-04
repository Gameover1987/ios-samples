//
//  OneNoteViewController.swift
//  Notes
//
//  Created by Вячеслав on 04.01.2023.
//

import UIKit

final class OneNoteViewController: UIViewController {

    var note: Note!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = note.text
        textView.delegate = self
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !textView.hasText {
            CoreDataManager.shared.deleteNote(note: note)
        }
    }
}

extension OneNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        note.setText(text: textView.text)
    }
}
