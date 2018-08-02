//
//  ContatosViewController.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 19/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import UIKit
import Reusable

class ContatosViewController: UIViewController, CriarContatoViewControllerDelegate {
    
    //tabela:
    @IBOutlet weak var tableView: UITableView!
    
    //variavel servico que herda os metodos da classe ContatoService:
    var service: ContatoService!
    
    //vetor de contatos:
    var contatos: [ContatoView] = []
    
    //metodo que é chamado toda vez que se carrega uma tela:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = L10n.Contatos.title
        
        self.service = ContatoService(delegate: self)
        
        self.tableView.register(cellType: LinhaTableViewCell.self)
        
        self.service.getContato()
        
        self.title = "Contatos"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //buttonCadastrar:
//        self.buttonCadastrar.setTitle(L10n.Login.cadastrar, for: .normal)
//        self.buttonCadastrar.layer.cornerRadius = self.buttonCadastrar.bounds.height/2
//        self.buttonCadastrar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        
        
    }
    
    @IBAction func abrirAdicionar(_ sender: Any) {
        //passando da listar contanto para a de adicionar contato
        self.perform(segue: StoryboardSegue.Contados.segueAdicionar)
    }
    
    //passa para outra tela ? para poder atualizar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? CriarContatoViewController {
            
            controller.delegate = self
        }
    }
    
    func atualizar() {
        
        self.contatos = ContatoViewModel.get()
        
        self.tableView.reloadData()
    }
}

extension ContatosViewController: ContatoServiceDelegate {
    
    func getContatosSuccess() {
        
        self.contatos = ContatoViewModel.get()
        
        self.tableView.reloadData()
        
        //        for contato in ContatoViewModel.get() {
        //            print(contato.nome)
        //        }
    }
    
    func getContatosFailure(error: String) {
        print("Errooo")
    }
}

extension ContatosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as LinhaTableViewCell
        
        cell.bind(contato: self.contatos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
}
