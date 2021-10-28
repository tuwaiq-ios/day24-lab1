//
//  ViewController.swift
//  day24-FireBase
//
//  Created by  HANAN ASIRI on 21/03/1443 AH.
import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let label = UILabel()
    let button = UIButton(type: .system)
    let deletButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupLabel()
        setupDeletButton()
        
        view.backgroundColor = .cyan
    }
    
    @objc func saveData() {
        
        Firestore
            .firestore()
            .document("users/firstUser")
            .setData([
                
                "id" : 1,
                "name" : "Hanan",
                "age" : 28
            ])
        
        let alertController = UIAlertController(title: " ",
        message: " Data Save ", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @objc func showSavedData() {
        Firestore
            .firestore()
            .collection("users")
            .whereField("name", isEqualTo: "Hanan")
            .addSnapshotListener { sanpshot, error in
                if error != nil {
                    print(error)
                    return
                }
                let saved = sanpshot?.documents.first?.data()
                let singleValue = (saved!["name"] ?? "nothing")
                self.label.text = "\(String(describing: singleValue))"
            }
    }

    @objc func deleteData(){
        Firestore
            .firestore()
            .collection("users")
            .whereField("name", isEqualTo: "Hanan")
            .addSnapshotListener { snapshot, error in
                if error != nil {
                    print(error)
                    return
                }
                var remove = snapshot?.documents.first?.data()
                remove?.removeAll()
                self.label.text = " "
            }
        
    }
    
    func setupButton() {
        
        button.setTitle("Save your name ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
         
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        button.addTarget(self, action: #selector(showSavedData), for: .touchDown)
        
    }
    
    func setupLabel(){
        label.text = " Welcome .. "
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
        ])
    }
    
    func setupDeletButton(){
        deletButton.setTitle("Delete your name", for: .normal)
        deletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deletButton)
        NSLayoutConstraint.activate([
            deletButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deletButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30)
        ])
        
        deletButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
    }
}
