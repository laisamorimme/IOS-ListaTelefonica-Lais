//
//  CadastroViewController.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 14/08/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    var service: LoginSevice!
    
    //outlet:
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelSenha: UILabel!
    @IBOutlet weak var labelConfirmarSenha: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldSenha: UITextField!
    @IBOutlet weak var textFieldConfirmarSenha: UITextField!
    @IBOutlet weak var buttonCadastar: UIButton!
    
    //Metodo de inicializacao:
    override func viewDidLoad() {
        super.viewDidLoad()

        self.service = LoginSevice(delegate: self)
        
        //botando os nomes do codigo na tela:
        // textFieldEmail.placeholder = L10n.Cadastrar.nome  (se fosse textField fazia assim)
        labelEmail.text = L10n.Cadastrar.email
        labelSenha.text = L10n.Cadastrar.senha
        labelConfirmarSenha.text = L10n.Cadastrar.confirmarSenha
        
        //button cadastra:
        self.buttonCadastar.setTitle(L10n.Login.entrar, for: .normal)
        self.buttonCadastar.layer.cornerRadius = self.buttonCadastar.bounds.height/2
        self.buttonCadastar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
    }
    
    //action do button:
    @IBAction func buttonCadatrar(_ sender: Any) {
        
        if let cadastroEmail = self.textFieldEmail.text, let cadastroSenha = self.textFieldSenha.text, let cadastroConfirmarSenha = self.textFieldConfirmarSenha.text{
            
            self.service.postUsuario(email: cadastroEmail, senha: cadastroSenha, confirmarSenha: cadastroConfirmarSenha)
        }
    }
}

extension CadastroViewController: LoginServiceDelegate{
    func postLoginSuccess() {
        
    }
    
    func postLoginFailure(error: String) {
        
    }
    
    func postUserSuccess() {
        self.dismiss(animated: true)
    }
    
    func postUserFailure(error: String) {
        print(error)
    }
    
    
}
