//
//  ContatoRequestFactory.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 19/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import Alamofire

class ContatoRequestFactory {
    
    //de acordo com o postman:
    
   static func postContato(contato: ContatoView) -> DataRequest {
  //  static func postContato(nome: String, aniversario: Int, email: String,telefone: String, avatar: String) -> DataRequest {
        
        let parametros: Parameters = ["name": contato.nome , "birth": 321, "email": contato.email, "phone": contato.telefone, "picture": contato.avatar ]
        
        return Alamofire.request(baseUrl + "contacts", method: .post, parameters: parametros, encoding: JSONEncoding.default, headers: header)
    }
    
    static func getContato() -> DataRequest {
        return Alamofire.request(baseUrl + "contacts", method: .get, headers: header)
    }
    
    static func delContato(contatoId: Int) -> DataRequest {
        return Alamofire.request(baseUrl + "contacts/\(contatoId)", method: .delete, headers: header)
    }
    
    static func putContato(contato: ContatoView) -> DataRequest {
//    static func putContato(contatoId: Int, nome: String, aniversario: Int, email: String, telefone: String, avatar: String) -> DataRequest{
        let parametros:Parameters = ["name": contato.nome, "birth": contato.aniversario, "email": contato.email, "phone": contato.telefone, "picture": contato.avatar]
        return Alamofire.request(baseUrl + "contacts/\(contato.id)",method: .put, parameters: parametros, encoding: JSONEncoding.default, headers: header)
    }
  }
