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
import DatePickerDialog

class CriarContatoViewController: UIViewController {

    var service: ContatoService!
    
    //nao endenti:
    var contacForEdit: ContatoView!
    var id: Int?
    
    //Outlet:
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldImagem: UITextField!
    @IBOutlet weak var buttonAdicionar: UIButton!
    @IBOutlet weak var textFieldData: UITextField!
    
    private var datePicker = UIDatePicker()
    
    //metodo que é chamado toda vez que se carrega uma tela:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = ContatoService(delegate: self)
        
        self.showDatePicker()
        
        if let _ = id {
            //editar:
            self.title = L10n.Contatoseditar.title
            self.buttonAdicionar.setTitle(L10n.Contatos.finalizar, for: .normal)
        } else {
            //adicionar:
            self.title = L10n.Contatoscadrastra.title
            self.buttonAdicionar.setTitle(L10n.Contatos.adicionar, for: .normal)
        }
        
       //buttonAdicionar:
        self.buttonAdicionar.layer.cornerRadius = self.buttonAdicionar.bounds.height/2
        self.buttonAdicionar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        
        if let id = self.id {
            self.contacForEdit = ContatoViewModel.get(id: id)
            self.textFieldNome.text = self.contacForEdit.nome
            self.textFieldEmail.text = self.contacForEdit.email
            self.textFieldTelefone.text = self.contacForEdit.telefone
            self.textFieldImagem.text = self.contacForEdit.avatar
        }
    }
    //
    func showDatePicker(){
        //passando p o formato Date:
        datePicker.datePickerMode = .date
        
        datePicker.locale = Locale(identifier: "pt_BR")
        
        //criando toolBar:
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //criando o button de criar:
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(CriarContatoViewController.salvarData))
        
        //criando um spaco entre os buttons:
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        //criando o button de cancelar:
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.done, target: self, action: #selector(CriarContatoViewController.cancelarData))
        
        //ordem de como vai ficar na storyboard:
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        //adicionar toolbar no textField:
        self.textFieldData.inputAccessoryView = toolbar
        
        //adicionar datepicker no textField:
        textFieldData.inputView = datePicker
    }
    
    //metodo do button salvar:
    @objc func salvarData(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textFieldData.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    //metodo do button cancelar:
    @objc func cancelarData(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    //metodo do button:
    @IBAction func buttonAdicionar(_ sender: Any) {
        //caso a variavel ainda seja 0 tem q criar se n vai editar:
       
        self.montarContato()
   }
    
    func montarContato() {
        
        //atribuir as variaveis com os valores do textFiel:
        if let nome = self.textFieldNome.text, let email = self.textFieldEmail.text, let telefone = self.textFieldTelefone.text, let image = self.textFieldImagem.text {
            
            var contato = ContatoView(id: -1, nome: nome, email: email, avatar: image, telefone: telefone, aniversario: "")
            
            if let id = self.id{
                //editar os valores no postman:
                contato.id = id
                
                self.service.putContato(contato: contato)
                
            }else {
                //criar um contato:
                self.service.postContato(contato: contato)
            }
        }
    }
}

extension CriarContatoViewController: ContatoServiceDelegate {
    //put:
    func putContatosSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
    func putContatosFailure(error: String) {
         print(error)
   }
    //post:
    func postContatosSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
    func postContatosFailure(error: String) {
        print(error)
    }
}
