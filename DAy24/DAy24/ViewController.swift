
import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    
 let tlabel: UILabel = {
  let label = UILabel ( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = " Hi"
     label.textColor = .white
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 45, weight: .heavy)
  return label } ( )
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show()
        view.backgroundColor = UIColor(red: 66/255, green: 98/255, blue: 68/255, alpha: 1)
        view.addSubview(tlabel)
        NSLayoutConstraint.activate([
            tlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            tlabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 190)
        ])
        
        let button = UIButton(frame: CGRect(x: 125, y: 300, width: 150, height: 50))
        button.backgroundColor = UIColor(red: 181/255, green: 218/255, blue: 191/255, alpha: 1)
        button.setTitle("Add New User", for: .normal)
        button.addTarget(self, action: #selector(AddNewUser), for: .touchUpInside)
        self.view.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x: 125, y: 500, width: 150, height: 50))
        button2.backgroundColor = UIColor(red: 181/255, green: 218/255, blue: 191/255, alpha: 1)
        button2.setTitle("Delete User", for: .normal)
        button2.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
    
        self.view.addSubview(button2)

    }
    
    
    
   @objc func AddNewUser(){
       
    Firestore.firestore().document("users/NewUser").setData(["age": 23, "city": "Dammam", "id": "87", "name": "Rawan"])
    }
    
    
    @objc func deleteUser(){
   Firestore.firestore().document("users/NewUser").delete()
        self.tlabel.text = " "
   }
    
    
    @objc func show(){
        Firestore.firestore().document("users/NewUser").addSnapshotListener{ document, error in
            if error != nil {

                print(error)
                return
            }
            let saved = document?.data()
            let singleValue = (saved?["name"] ?? "nothing")
            self.tlabel.text = "\(String(describing: singleValue))"
        }
   }
    


}
