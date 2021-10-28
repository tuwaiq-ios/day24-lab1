//
//  ViewController.swift
//  day24
//
//  Created by ibrahim asiri on 21/03/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSV()
    }
    
    let dataStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    let dataLbl : UILabel = {
        $0.text = "Result"
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.textColor = .label
        return $0
    }(UILabel())
    
    let button1 : UIButton = {
        $0.backgroundColor = .lightGray
        $0.setTitle("Add", for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(addButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let button2 : UIButton = {
        $0.backgroundColor = .lightGray
        $0.setTitle("Delete", for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(delButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc func addButton() {
        Firestore.firestore().document("users/thirdU").setData([
            "id": 2,
            "name": "Asiri"
        ])
        
        Firestore.firestore().collection("users").whereField("name", isEqualTo: "Asiri").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error as Any)
                return
            }
            //  to show data in Lable
            let save = snapshot?.documents.first?.data()
            let value = (save!["name"] ?? "nothing")
            self.dataLbl.text = "\(value)"
        }
    }
    
    @objc func delButton() {
        Firestore.firestore().document("users/thirdU").delete()

        self.dataLbl.text = ""
            }
    
    func setupSV() {
        view.addSubview(dataStackView)
        dataStackView.addArrangedSubview(button1)
        dataStackView.addArrangedSubview(button2)
        dataStackView.addArrangedSubview(dataLbl)
        NSLayoutConstraint.activate([
            dataStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            dataStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            dataStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            dataStackView.heightAnchor.constraint(equalToConstant: 250)
            
        ])
    }
}


//extension ViewController {





