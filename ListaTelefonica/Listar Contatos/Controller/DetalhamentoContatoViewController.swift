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
//    var delegate: CriarContatoViewControllerDelegate!
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
        
    }
    
//        //botando a imagem pelo url:
//    if; let url = contato.avatarUrl {
//           imagemContato.kf.setImage(with: url)
//        }
//

    @objc func irDeUmaPaginaParaAOutra() {
       self.perform(segue: StoryboardSegue.Contados.segueAdicionar)
    }
    
    @objc func editarContato() {
        self.perform(segue: StoryboardSegue.Contados.segueEditar)
    }
    
    //passar da detalhe para a de editar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CriarContatoViewController {
            
            controller.delegate = self
            if segue.identifier == "segueEditar" {
                controller.title = "Editar Contato"
                controller.titleButton = "Atualizar"
                controller.id = self.id
            }
        }
    }

    //esta funcao atualiza a tela cada vez que for aberta:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelNomeContato.text = self.contato.nome
        self.labelTelefoneContato.text = self.contato.telefone
        self.labelEmailContato.text = self.contato.email
        self.imagemContato.kf.setImage(with: self.contato.avatarUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //excluir o contato pelo id:
    @IBAction func buttonExcluir(_ sender: Any) {
        self.service.delContato(id: idContatoPostman)
    }
}

extension DetalhamentoContatoViewController: CriarContatoViewControllerDelegate {
    func atualizar() {
        
    }
    
    
}

extension DetalhamentoContatoViewController: ContatoServiceDelegate {
    func postContatosFailure(error: String) {
        print(error)
    }
    
    //get:
    func getContatosSuccess() {
        
        let alert = UIAlertController(title: "Contato Excluido", message: "O contato \(self.labelNomeContato.text!) foi excluído com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok!", style: UIAlertActionStyle.default) { (_) in
            
//            self.delegate.atualizar()
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getContatosFailure(error: String) {
        print("Errooo")
        
        let alert = UIAlertController(title: "Contato Excluido", message: "O contato \(self.labelNomeContato.text!) foi excluído com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok!", style: UIAlertActionStyle.default) { (_) in
            
//            self.delegate.atualizar()
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //put:
    func putContatosFailure(error: String) {
        
    }
    
    //del:
    func delContatosFailure(error: String) {
        print(error)
    }
    
    func delContatosSuccess() {
        let alert = UIAlertController(title: "Contato Excluido", message: "O contato \(self.labelNomeContato.text!) foi excluído com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok!", style: UIAlertActionStyle.default) { (_) in
//            self.delegate.atualizar()
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
//        delegate.atualizar()
    }

}

