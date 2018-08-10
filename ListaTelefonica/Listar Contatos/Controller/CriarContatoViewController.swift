//
//  CriarContatoViewController.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 01/08/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import Kingfisher
import SVProgressHUD

protocol CriarContatoViewControllerDelegate {
    func atualizar()
}

class CriarContatoViewController: UIViewController {

    var service: ContatoService!
    var contato: Contato?
    
    //nao endenti:
    var contacForEdit: ContatoView!
    var id: Int = 0
    var titleButton:String = ""
    
    //Outlet:
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldImagem: UITextField!
    @IBOutlet weak var buttonAdicionar: UIButton!

    var delegate: CriarContatoViewControllerDelegate!
    
    //metodo que é chamado toda vez que se carrega uma tela:
    override func viewDidLoad() {
        super.viewDidLoad()

        //buttonAdicionar:
        self.service = ContatoService(delegate: self)
        self.contacForEdit = ContatoViewModel.get(id: id)
        self.buttonAdicionar.setTitle(L10n.Login.cadastrar, for: .normal)
        self.buttonAdicionar.layer.cornerRadius = self.buttonAdicionar.bounds.height/2
        self.buttonAdicionar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        
    }

    //esta funcao atualiza a tela cada vez que for aberta:
    override func viewWillAppear(_ animated: Bool) {
        self.buttonAdicionar.setTitle(self.titleButton, for: .normal)
        if id != 0 {
            self.textFieldNome.text = self.contacForEdit.nome
            self.textFieldEmail.text = self.contacForEdit.email
            self.textFieldTelefone.text = self.contacForEdit.telefone
            self.textFieldImagem.text = self.contacForEdit.avatar
        }
    }
    //metodo do button:
    @IBAction func buttonAdicionar(_ sender: Any) {
        //caso a variavel ainda seja 0 tem q criar se n vai editar:
        if id != 0 {
            self.editarContato()
        }else {
            self.criarContato()
        }
        
   }
    
    //post, pois vai adicionar:
    func criarContato(){
        //atribuir as variaveis com os valores do textFiel:
        if let salvarNome = self.textFieldNome.text, let salvarEmail = self.textFieldEmail.text, let salvarTelefone = self.textFieldTelefone.text, let salvarImagem = self.textFieldImagem.text {
            
            //adiciona esses valores no postman:
            self.service.postContato(nomeContato: salvarNome, aniversarioContato: 315, emailContato: salvarEmail, telefoneContato: salvarTelefone, imagemContato: salvarImagem)
        }
        
    }
    
    // put, pois vai editar:
    func editarContato(){
        if let salvarNome = self.textFieldNome.text, let salvarEmail = self.textFieldEmail.text, let salvarTelefone = self.textFieldTelefone.text, let salvarImagem = self.textFieldImagem.text{
            
            self.service.putContato(id: self.id, nomeContato: salvarNome, aniversarioContato: 315, emailContato: salvarEmail, telefoneContato: salvarTelefone, imagemContato: salvarImagem)
            
        }
    }
}
    


extension CriarContatoViewController: ContatoServiceDelegate {
    //put:
    func putContatosSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
    func putContatosFailure(error: String) {
        
    }
    //del:
    func delContatosSuccess() {
        
    }
    func delContatosFailure(error: String) {
        
    }
    //post:
    func postContatosSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
    func postContatosFailure(error: String) {
        
    }
    //get:
    func getContatosSuccess() {
   
    }
    
    func getContatosFailure(error: String) {
        
    }
}

