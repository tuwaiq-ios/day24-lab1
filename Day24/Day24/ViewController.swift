//
//  ViewController.swift
//  Day24
//
//  Created by Sana Alshahrani on 21/03/1443 AH.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let label = UILabel()
    let button = UIButton(type: .system)
    let deletButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupButton()
        setupLabel()
        setupDeletButton()
        
        Firestore
            .firestore()
            .collection("users")
            .whereField("name", isEqualTo: "maram")
            .addSnapshotListener { sanpshot, error in
                if error != nil {
                    print(error)
                    return
                }
                let saved = sanpshot?.documents.first?.data()
                let singleValue = (saved?["name"] ?? "nothing")
                self.label.text = "\(String(describing: singleValue))"
            }
    }
    
    @objc func saveData() {

        Firestore
            .firestore()
            .document("users/second_user")
            .setData([
                
                "id" :2,
                "name" : "maram",
                "age" : 26
            ])
        
        
        let alertController = UIAlertController(title: "🗳", message: "Data Saved", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }

    @objc func deleteData(){
        Firestore
            .firestore()
            .document("users/second_user")
            .delete()
    }
    
    func setupButton() {
        
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
         
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
//        button.addTarget(self, action: #selector(showSavedData), for: .touchDown)
        
    }
    
    func setupLabel(){
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    func setupDeletButton(){
        deletButton.setTitle("Delete", for: .normal)
        deletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deletButton)
        NSLayoutConstraint.activate([
            deletButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deletButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10)
        ])
        
        deletButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
    }
}

