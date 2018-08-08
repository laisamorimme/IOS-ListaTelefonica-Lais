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
import Kingfisher
import SVProgressHUD

class ContatosViewController: UIViewController, CriarContatoViewControllerDelegate {
    
    //outlet tabela:
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
        
//        buttonCadastrar:
//        self.buttonCadastrar.setTitle(L10n.Login.cadastrar, for: .normal)
//        self.buttonCadastrar.layer.cornerRadius = self.buttonCadastrar.bounds.height/2
//        self.buttonCadastrar.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        
        
    }
    
    //passando da listar contanto para a de adicionar contato:
    @IBAction func abrirAdicionar(_ sender: Any) {
        self.perform(segue: StoryboardSegue.Contados.segueAdicionar)
    }
    
    //esta funcao atualiza a tela cada vez que for aberta:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.service.getContato()
    }
    
    //passa para outra tela ? para poder atualizar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? CriarContatoViewController {
            controller.delegate = self
            controller.title = "Criar Contato"
            controller.titleButton = "Adicionar"
        } else if let controller = segue.destination as? DetalhamentoContatoViewController {
            
            if let id = sender as? Int {
                controller.idContatoPostman = id
            }
        }
    }
    
    //metodo para a table view se refazer, ou seja, atualizar:
    func atualizar() {
        
        self.contatos = ContatoViewModel.get()
        
        self.tableView.reloadData()
    }
}

extension ContatosViewController: ContatoServiceDelegate {
    //put:
    func putContatosSuccess() {
        
    }
    func putContatosFailure(error: String) {
        
    }
    //del:
    func delContatosSuccess() {
        
    }
    func delContatosFailure(error: String) {
        
    }
    //post
    func postContatosSuccess() {
        
    }
    func postContatosFailure(error: String) {
        
    }
    //get:
    func getContatosSuccess() {
        
        self.contatos = ContatoViewModel.get()
        
        self.tableView.reloadData()
    }
    
    func getContatosFailure(error: String) {
        print("Errooo")
    }
}

extension ContatosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.contatos.count
    }
    
    //desenho da celula personalizada:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as LinhaTableViewCell
        
        cell.bind(contato: self.contatos[indexPath.row])
        
        return cell
    }
    
    //altura da celula da table view:
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    //quando apertar em uma linha da table view ela vai pegar o id dela para poder pegar os dados dela:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        //ao apertar na cell ela n fica selecionada:
        self.tableView.deselectRow(at: indexPath, animated: true)
        //emcaminha para a outra tela:
        self.perform(segue: StoryboardSegue.Contados.segueDetalhe, sender: self.contatos[indexPath.row].id)
        
    }
}

