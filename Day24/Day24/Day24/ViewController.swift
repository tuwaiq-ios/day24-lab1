//
//  ViewController.swift
//  Day24
//
//  Created by sally asiri on 22/03/1443 AH.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore
class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSV()
      }
  let dataStackView : UIStackView = {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.axis = .vertical
      $0.distribution = .fillEqually
      $0.spacing = 10
      return $0
    }(UIStackView())
  let label1 : UILabel = {
    $0.text = "title"
    return $0
  }(UILabel())
  let buttonadd : UIButton = {
    $0.setTitle("add", for: .normal)
    $0.backgroundColor = .darkGray
    $0.addTarget(self, action: #selector(addButton), for: .touchUpInside)
    return $0
  }(UIButton())
  let buttondedlet : UIButton = {
    $0.setTitle("delet", for: .normal)
    $0.backgroundColor = .darkGray
    $0.addTarget(self, action: #selector(delButton), for: .touchUpInside)
    return $0
  }(UIButton())
  @objc func addButton() {
      Firestore.firestore().document("Twain/fristuser").setData([
        "id": 1,
        "name": "sally"
      ])
      Firestore.firestore().collection("users").whereField("name", isEqualTo: "sally").addSnapshotListener { snapshot, error in
        if error != nil {
          print(error as Any)
          return
        }
        // to show data in Lable
        let save = snapshot?.documents.first?.data()
        let value = (save!["name"] ?? "nothing")
        self.label1.text = "\(value)"
      }
    }
    @objc func delButton() {
      Firestore.firestore().document("Twain/fristuser").delete()
      self.label1.text = ""
        }
  func setupSV() {
      view.addSubview(dataStackView)
      dataStackView.addArrangedSubview(buttonadd)
      dataStackView.addArrangedSubview(buttondedlet)
    dataStackView.addArrangedSubview(label1)
      NSLayoutConstraint.activate([
        dataStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
        dataStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
        dataStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
        dataStackView.heightAnchor.constraint(equalToConstant: 250)
      ])
    }
}
