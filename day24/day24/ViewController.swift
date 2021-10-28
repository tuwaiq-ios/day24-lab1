//
//  ViewController.swift
//  day24
//
//  Created by Macbook on 21/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore


class ViewController: UIViewController {
    

    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "32")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //view.backgroundColor = UIColor (named: "32")
        view.addSubview(Button)
        
        NSLayoutConstraint.activate([
            Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            Button.heightAnchor.constraint(equalToConstant: 70)
            
        ])
        view.addSubview(Button1)
        
        NSLayoutConstraint.activate([
            Button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170),
            Button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            Button1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            Button1.heightAnchor.constraint(equalToConstant: 70)
            
        ])
        
        view.addSubview(Label)
        
        NSLayoutConstraint.activate([
            Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            Label.heightAnchor.constraint(equalToConstant: 70)
            
        ])
        
    }
    let Button : UIButton = {
        $0.backgroundColor = .darkGray
        $0.setTitle("Add to firebase", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(B), for: .touchUpInside)
        $0.addTarget(self, action: #selector(Show), for: .touchDown)
        return $0
    }(UIButton())
    
    let Button1 : UIButton = {
        $0.backgroundColor = .darkGray
        $0.setTitle("delete", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(Deletedata), for: .touchDown)
        $0.addTarget(self, action: #selector(C), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    let Label : UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    @objc func B() {
        Firestore.firestore().document("users/ali3").setData([
            "name" : "ali",
            "id" :3,
            "number of card" :6
        ])
    }
    
    @objc func C() {
        Firestore.firestore().document("users/ali3").delete()

    }
    
    @objc func Show() {
        Firestore.firestore().collection("users").whereField("name", isEqualTo: "ali")
            .addSnapshotListener{Snapshot, error in
                if error != nil {
                    print (error)
                    return
                }
                let sh = Snapshot?.documents[0].data()
                var Value = (sh!["name"] ?? "nothing")
                var Value1 = (sh!["id"] ?? "nothing")
                var Value2 = (sh!["number of card"] ?? "nothing")
                self.Label.text = "name :\(String(describing: Value)),id :\(String(describing: Value1)),number of card: \(String(describing: Value2))"
            }
    }
    @objc func Deletedata() {
        var re =      Firestore.firestore().collection("users").whereField("name", isEqualTo: "ali")
            .addSnapshotListener { Snapshot, error in
                if error != nil {
                    print (error)
                    return
                }
                var de = Snapshot?.documents[0].data()
                de?.removeAll()
                self.Label.text = ""
            }
    }
    
}
