//
//  LoginRequestFactory.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 18/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import Alamofire

class LoginRequestFactory{
    
    //criando um login:
    static func postLogin(email: String, senha: String) -> DataRequest {
        
        let param: Parameters = ["email": email, "password": senha]
        
        return Alamofire.request(baseUrl + "auth/sign_in", method: .post, parameters: param, encoding: JSONEncoding.default)
        
    }
    //criar usuario:
    static func postUsuario(email: String, senha: String, confirmarSenha: String) -> DataRequest {
        
        let param: Parameters = ["email": email, "password": senha, "password_confirmation": confirmarSenha]
        
        return Alamofire.request(baseUrl + "auth", method: .post, parameters: param, encoding: JSONEncoding.default)
        
    }
    
}
