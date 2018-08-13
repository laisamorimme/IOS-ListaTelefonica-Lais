//
//  Contato.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 19/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import RealmSwift
import  ObjectMapper

class Contato: Object,Mappable{
    
    // quando for usar um optional inteiro:
    var id = RealmOptional<Int>()
    
    //variaveis:
    @objc dynamic var nome: String?
    @objc dynamic var aniversario: String?
    @objc dynamic var email: String?
    @objc dynamic var telefone: String?
    @objc dynamic var avatar: String?
    
    //inicializando o map:
    required convenience init?(map: Map){
        self.init()
    }
    
    //sertar a primaryKey do banco:
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //mapiando o JSON, pegando o nome que ta no postan e trazendo para essa variavel:
    func mapping(map: Map) {
        self.id.value         <- map["id"]
        self.nome             <- map["name"]
        self.aniversario      <- map["birth"]
        self.email            <- map["email"]
        self.telefone         <- map["phone"]
        self.avatar           <- map["picture"]
    }
}
