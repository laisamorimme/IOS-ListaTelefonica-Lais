//
//  LoginService.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 18/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol LoginServiceDelegate: class {
    
    func postLoginSuccess()
    func postLoginFailure(error: String)
    func postUserSuccess()
    func postUserFailure(error: String)
}

class LoginSevice{
    
    weak var delegate: LoginServiceDelegate?
    
    required init(delegate: LoginServiceDelegate){
        self.delegate = delegate
    }
    
    func postLogin(email: String, senha: String){
        
        LoginRequestFactory.postLogin(email: email, senha: senha).validate().responseObject(keyPath: "data") { (response: DataResponse<User>) in
         
            switch response.result {
            case .success:
                
                if let user = response.result.value {
                    user.setHeaderParams(header: response.response?.allHeaderFields)
                    SessionControl.setHeadersParams(headers:  response.response?.allHeaderFields)
                    UserViewModel.clear()
                    UserViewModel.save(usuario: user)
                }
                
                self.delegate?.postLoginSuccess()
                
            case .failure(let error):
                
                self.delegate?.postLoginFailure(error: error.localizedDescription)
            }
        }
    }
    
    func postUsuario(email: String, senha: String, confirmarSenha: String){
        
        LoginRequestFactory.postUsuario(email: email, senha: senha, confirmarSenha: confirmarSenha).validate().responseJSON { (response: DataResponse<Any>) in
            
            switch response.result{
            case .success:
                
                self.delegate?.postUserSuccess()
                
            case .failure(let error):
                
                self.delegate?.postUserFailure(error: error.localizedDescription)
            }
        }
    }
}
