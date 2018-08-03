//
//  CriarContatoViewController.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 01/08/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit

protocol CriarContatoViewControllerDelegate {
    
    func atualizar()
}

class CriarContatoViewController: UIViewController {

    var service: ContatoService!
    var contato: Contato?
    
    //Outlet:
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldImagem: UITextField!
    @IBOutlet weak var buttonAdicionar: UIButton!

    var delegate: CriarContatoViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //buttonAdicionar:
        self.service = ContatoService(delegate: self)
        self.buttonAdicionar.setTitle(L10n.Login.cadastrar, for: .normal)
        self.buttonAdicionar.layer.cornerRadius = self.buttonAdicionar.bounds.height/2
        self.buttonAdicionar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    @IBAction func buttonAdicionar(_ sender: Any) {
        //nome, email,telefone,imagem
        if let salvarNome = self.textFieldNome.text, let salvarEmail = self.textFieldEmail.text, let salvarTelefone = self.textFieldTelefone.text, let salvarImagem = self.textFieldImagem.text {
            
            self.service.postContato(nomeContato: salvarNome, aniversarioContato: 315, emailContato: salvarEmail, telefoneContato: salvarTelefone, imagemContato: salvarImagem)
        }
    }
}

extension CriarContatoViewController: ContatoServiceDelegate {
    
    func getContatosSuccess() {
        print("Salvouuuuuu")
        
        //atualizar a lista de contatos:
        self.delegate.atualizar()
        //volta p a pagina anterior:
        self.navigationController?.popViewController(animated: true)
    }
    
    func getContatosFailure(error: String) {
        
    }
}

