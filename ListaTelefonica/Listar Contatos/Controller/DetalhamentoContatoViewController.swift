//
//  DetalhamentoContatoViewController.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 03/08/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation
import Reusable
import Kingfisher
import SVProgressHUD


class DetalhamentoContatoViewController: UIViewController {
    
    //Outlet:
    @IBOutlet weak var imagemContato: UIImageView!
    @IBOutlet weak var labelNomeContato: UILabel!
    @IBOutlet weak var labelEmailContato: UILabel!
    @IBOutlet weak var labelTelefoneContato: UILabel!
    @IBOutlet weak var buttonExcluir: UIButton!
    
    var idContatoPostman : Int!
    var contato : ContatoView!
    var service: ContatoService!
    var id: Int = 0
    var delegate: CriarContatoViewControllerDelegate!
    var programVar: Int?
    
     //metodo que é chamado toda vez que se carrega uma tela:
    override func viewDidLoad() {
        super.viewDidLoad()

        //trazendo do banco para o label:
        contato = ContatoViewModel.get(id: idContatoPostman)
        labelNomeContato.text = contato.nome
        labelEmailContato.text = contato.email
        labelTelefoneContato.text = contato.telefone
        imagemContato.kf.setImage(with: contato.avatarUrl)
        
        //button aditar:
        let buttonEditar = UIBarButtonItem(title: L10n.Contatos.editar, style: .plain, target: self, action: #selector(DetalhamentoContatoViewController.irDeUmaPaginaParaAOutra))
        self.navigationItem.rightBarButtonItem = buttonEditar

        self.service = ContatoService(delegate: self)
        self.contato = ContatoViewModel.get(id: id)
        self.title = "\(contato.nome)"
        self.labelNomeContato.text = contato.nome
        self.labelEmailContato.text = contato.email
        self.labelTelefoneContato.text = contato.telefone
          //continuar aquiiiiiiiiiiiiiiii
    }

    @objc func irDeUmaPaginaParaAOutra() {
       self.perform(segue: StoryboardSegue.Contados.segueAdicionar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CriarContatoViewController {
            
          //  controller.delegate = self
            
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonExcluir(_ sender: Any) {
    
        self.service.delContato(id: idContatoPostman)
    }
}

extension DetalhamentoContatoViewController: ContatoServiceDelegate {
    func putContatosFailure(error: String) {
        
    }
    
    func delContatosFailure(error: String) {
        print("Errooo mais ta certo")
        
        let alert = UIAlertController(title: "Contato Excluido", message: "O contato \(self.labelNomeContato.text!) foi excluído com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok!", style: UIAlertActionStyle.default) { (_) in
            
            self.delegate.atualizar()
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        delegate.atualizar()
    }
    
    func postContatosFailure(error: String) {
        
    }
    func delContatosSuccess() {
        
        let alert = UIAlertController(title: "Contato Excluido", message: "O contato \(self.labelNomeContato.text!) foi excluído com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok!", style: UIAlertActionStyle.default) { (_) in
            
            self.delegate.atualizar()
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getContatosSuccess() {
      
    }
    
    func getContatosFailure(error: String) {
     
    }
  
}
