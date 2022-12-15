
import UIKit

class FileManagerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Documents"
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add image", style: .done, target: self, action: #selector(addImageFromGallery))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create folder", style: .done, target: self, action: #selector(createFolder))
        
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        view.backgroundColor = .white
        
        let documentsFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        print(documentsFolder)
        
        let contents = try! FileManager.default.contentsOfDirectory(atPath: documentsFolder.path)
        print(contents)
    }
    
    @objc private func addImageFromGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    @objc private func createFolder() {
        
    }
}

extension FileManagerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            //PhotoFileManager.shared.savingAn(image: image)
            print(image)
            NotificationCenter.default.post(name: NSNotification.Name("saveImageToCurrentFolder"), object: nil)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
