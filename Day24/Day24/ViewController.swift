//
//  ViewController.swift
//  Day24
//
//  Created by Fawaz on 27/10/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
  
  let label = UILabel()
  let button = UIButton(type: .system)
  let deletButton = UIButton(type: .system)
  
  //--------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupButton()
    setupLabel()
    setupDelet()
  }
  //--------------------------------------------------------------------
  
  @objc func showData() {
    
    Firestore.firestore()
      .collection("users")
      .whereField("name", isEqualTo: "Fawaz")
      .addSnapshotListener{Snapshot, error in
        if error != nil {
          print (error!)
          return
        }
        
        let x = Snapshot?.documents.first?.data()
        
        let x1 = (x?["name"] ?? "nothing")
        let x2 = (x?["id"] ?? "nothing")
        let x3 = (x?["age"] ?? "nothing")
        
        self.label.text = "Name: \(String(describing: x1)), ID: \(String(describing: x2)), Age: \(String(describing: x3))"
      }
  }
  
  //--------------------------------------------------------------------
  
  func setupLabel(){
    label.text = "Hi"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 20)
    
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
    ])
  }
  
  //--------------------------------------------------------------------
  @objc func saveData() {
    
    Firestore
      .firestore()
      .document("users/firstUser")
      .setData(["id" : 1, "name" : "Fawaz", "age" : 25])
    
    let alertController = UIAlertController(title: "add", message: "Data Saved", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "ok Saved", style: .default, handler: nil)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
  //--------------------------------------------------------------------
  
  @objc func deleteData(){
    
    Firestore
      .firestore()
      .document("users/firstUser")
      .delete()
    
    let alertController = UIAlertController(title: "remove", message: "Data Delete", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "ok Delete", style: .default, handler: nil)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
  //--------------------------------------------------------------------
  
  func setupButton() {
    
    button.setTitle("save", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    button.addTarget(self, action: #selector(showData), for: .touchDown)
  }
  //--------------------------------------------------------------------
  
  func setupDelet(){
    deletButton.setTitle("delete", for: .normal)
    deletButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(deletButton)
    
    NSLayoutConstraint.activate([
      deletButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      deletButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10)
    ])
    deletButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
    deletButton.addTarget(self, action: #selector(showData), for: .touchDown)
  }
}
