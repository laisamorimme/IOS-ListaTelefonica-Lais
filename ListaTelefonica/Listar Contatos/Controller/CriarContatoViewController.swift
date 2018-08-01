//
//  CriarContatoViewController.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 01/08/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit

class CriarContatoViewController: UIViewController {

    //Outlet:
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    
    @IBOutlet weak var textFieldImagem: UITextField!

    @IBOutlet weak var buttonAdicionar: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //buttonAdicionar:
        self.buttonAdicionar.setTitle(L10n.Login.cadastrar, for: .normal)
        self.buttonAdicionar.layer.cornerRadius = self.buttonAdicionar.bounds.height/2
        self.buttonAdicionar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    @IBAction func buttonAdicionar(_ sender: Any) {
        
    }
    
    
}

