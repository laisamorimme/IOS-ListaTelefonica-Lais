//
//  ContatoViewModel.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 19/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import RealmSwift

// construtor ?
struct ContatoView {
    
    var id : Int = 0
    var nome: String = ""
    var email: String = ""
    var avatar: String = ""
    var telefone: String = ""
    var aniversario: String = ""

    var avatarUrl: URL? {
        
        return URL(string: self.avatar)
    }
}

class ContatoViewModel {
    
    // pegar apenas uma pessoa:
    static func getAsView(_ contato: Contato?) -> ContatoView {
        
        guard let contato = contato else {
            
            return ContatoView()
        }
        
        var contatoView = ContatoView()
        
        contatoView.nome = contato.nome ?? ""
        contatoView.email = contato.email ?? ""
        contatoView.telefone = contato.telefone ?? ""
        contatoView.avatar = contato.avatar ?? ""
        contatoView.id = contato.id.value ?? 0
        
        return contatoView
    }
    
    // pegar o vertor de todas as pessoas:
    static func getAsView(sequence contatos: [Contato]) -> [ContatoView] {
        
        var contatosView = [ContatoView]()
        
        for contato in contatos {
            
            contatosView.append(self.getAsView(contato))
        }
        
        return contatosView
    }
    
    //tem a posibilidade de salvar o vertor de contatos (quando dar o clear na tela, ela busca tudos os contatos listados) ou apenas um contado (na adicao):
    static func save(contato: Contato) {
        try! uiRealm.write {
            uiRealm.add(contato, update: true)
        }
    }
    
    static func save(contatos: [Contato]) {
        try! uiRealm.write {
            uiRealm.add(contatos, update: true)
        }
    }
    
    static func clear() {
        //toda vez que eu for modificar no banco local:
        try! uiRealm.write {
            uiRealm.delete(uiRealm.objects(Contato.self))
        }
    }
    
    //pega do banco a lista de contatos ou apenas um contato:
    static func get() -> [ContatoView] {
        
        let contatosModel = uiRealm.objects(Contato.self)
        
        var contatos: [Contato] = []
        contatos.append(contentsOf: contatosModel)
        
        return self.getAsView(sequence: contatos)
    }
    
    static func get(id: Int) -> ContatoView{
        let contatoDetalhes = uiRealm.object(ofType: Contato.self, forPrimaryKey: id)
        return getAsView(contatoDetalhes)
    }
    
    //apagando um contato do banco local depois de apagar do servico:
    static func delete(by contatoId: Int) {
        
        let result = uiRealm.object(ofType: Contato.self, forPrimaryKey: contatoId)
        
        if let contato = result {
            
            try! uiRealm.write {
                
                uiRealm.delete(contato)
            }
        }
    }
}

