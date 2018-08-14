//
//  ViewController.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 17/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var service: LoginSevice!
    
    //Outlet:
    @IBOutlet weak var imagemTelefone: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldSenha: UITextField!
    @IBOutlet weak var buttonEntrar: UIButton!
    @IBOutlet weak var buttonCadastrar: UIButton!
    
    
    //Metodo de inicializacao:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Inicializando:
        self.service = LoginSevice(delegate: self)
        
        //setando o usuario:
        self.textFieldEmail.text = "lais@gmail.com"
        self.textFieldSenha.text = "12345678"

        //trazendo a imagem:
        self.imagemTelefone.image = Asset.telefoneImagem.image
        
        //TextFiel Email:
        self.textFieldEmail.placeholder = L10n.Login.email
        self.textFieldSenha.placeholder = L10n.Login.senha
        
        //button Entrar:
        self.buttonEntrar.setTitle(L10n.Login.entrar, for: .normal)
        self.buttonEntrar.layer.cornerRadius = self.buttonEntrar.bounds.height/2
        self.buttonEntrar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
    }

    //button entrar:
    @IBAction func buttonEntrar(_ sender: Any) {
        
        if let email = self.textFieldEmail.text, let senha = self.textFieldSenha.text {
            self.service.postLogin(email: email, senha: senha)
        }
    }
    //button cadastrar:
    @IBAction func buttonCadastrar(_ sender: Any) {
        
    }
}

extension ViewController: LoginServiceDelegate {
    func postUserSuccess() {
        
    }
    
    func postUserFailure(error: String) {
        
    }
    
    
    func postLoginSuccess() {

        self.perform(segue: StoryboardSegue.Main.segueEntrar)
    }
    
    func postLoginFailure(error: String) {
        
        print(error)
    }
}

