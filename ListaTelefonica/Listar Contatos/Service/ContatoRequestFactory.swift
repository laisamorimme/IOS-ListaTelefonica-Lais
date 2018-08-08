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
    
    static func criarContato(nome:String,aniversario:Int,email:String,telefone:String,imagem:String) -> DataRequest {
        
        let parametros: Parameters = ["name":nome,"birth":aniversario,"email":email,"phone":telefone,"picture":imagem]
        
        return Alamofire.request(baseUrl + "contacts", method: .post, parameters: parametros, encoding: JSONEncoding.default, headers: header)
    }
    
    static func getContato() -> DataRequest {
       
        return Alamofire.request(baseUrl + "contacts", method: .get, headers: header)
    }
    
    static func del(contatoId: Int) -> DataRequest {
        
        return Alamofire.request(baseUrl + "contacts/\(contatoId)", method: .delete, headers: header)
    }
    
    static func put(contatoId: Int, nome: String, aniversario: Int, email: String, telefone: String, imagem: String) -> DataRequest{
        let parametros:Parameters = ["nome": nome, "birth": aniversario, "email": email, "phone": telefone, "picture": imagem]
        
        return Alamofire.request(baseUrl + "contacts/\(contatoId)",method: .put, parameters: parametros, encoding: JSONEncoding.default, headers: header)
    }
  }
