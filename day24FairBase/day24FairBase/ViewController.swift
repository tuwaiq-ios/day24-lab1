//
//  ViewController.swift
//  day24FairBase
//
//  Created by SARA SAUD on 3/21/1443 AH.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let label = UILabel()
    let button = UIButton(type: .system )
    let deletButton = UIButton(type: .close)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupButton()
        setupLabel()
        setupDeletButton()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "image")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
            
        
    }

    @objc func saveData() {
        
        Firestore
            .firestore()
            .document("users/firstUser")
            .setData([
                
                "id" : 10,
                "name" : "Sara",
                "age" : 26
            ])
        
        let alertController = UIAlertController(title: "⚠️", message: "Data Saved ✅", preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @objc func showSavedData() {
        Firestore
            .firestore()
            .collection("users")
            .whereField("name", isEqualTo: "Sara")
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
            .document("users/firstUser")
            .delete()
        self.label.text = "  "

    }
    
    func setupButton() {
        
        button.setTitle("Save", for: .normal)
    //    deletButton.tintColor.ciColor.blue
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
        label.text = "FireBase Lap 🔥"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
        ])
    }
    
    func setupDeletButton(){
        deletButton.setTitle("Delete", for: .normal)
        //deletButton.tintColor.Color.red
        deletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deletButton)
        NSLayoutConstraint.activate([
            deletButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deletButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10)
        ])
        
        deletButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
    }
}


