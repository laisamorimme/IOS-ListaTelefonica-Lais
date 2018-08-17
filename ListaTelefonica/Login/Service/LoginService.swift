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
import SwiftyJSON

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
                
            case .failure(_):

//                if let data = response.data {
//                   do {
//                        let message = try JSON(data: data)["errors"][0].stringValue
//                        self.delegate?.postLoginFailure(error: message)
//
//                    } catch {
                
                        self.delegate?.postLoginFailure(error: self.getErro(response: response))
//                    }
//                }
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
    
    //pegar o erro:
    private func getStatusCode<T: Any>(response: DataResponse<T>) -> Int {
        
        var statusCode = 0
        
        if let httpResponse = response.response {
            
            statusCode = httpResponse.statusCode
            
        } else {
            
            if let urlError = response.result.error as? URLError {
                
                statusCode = urlError.errorCode
            }
        }
        
        return statusCode
    }
    
    //pega a mensagem que está no postman:
//    private func getMessage(data: Data?, defaultMessage: String) -> String {
//
//        if let data = data {
//
//            do {
//                let message = try JSON(data: data)["message"].stringValue
//                return message
//
//            } catch {
//
//                return defaultMessage
//            }
//        }
//        return defaultMessage
//    }
    
    private func getErrorType(statusCode: Int, data: Data?) -> String {
        
        switch statusCode {
        case -999:
            return "Request cancelado."
        case -1009:
            return "Sem conexão com a internet"
        default:
            return "Tente novamente"
        }
    }
    
    private func getErro<T: Any>(response: DataResponse<T>) -> String {
        
        let statusCode = self.getStatusCode(response: response)
        
        return self.getErrorType(statusCode: statusCode, data: response.data)
    }
    
    
}
