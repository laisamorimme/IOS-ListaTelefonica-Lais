//
//  ContatoService.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 19/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

//metodos que seram implementados lá em baixo mas nem sempre sao usados:
protocol ContatoServiceDelegate {
    func getContatosSuccess()
    func getContatosFailure(error: String)
    func postContatosSuccess()
    func postContatosFailure(error: String)
    func delContatosSuccess()
    func delContatosFailure(error: String)
    func putContatosSuccess()
    func putContatosFailure(error: String)
}

//apois fazer isso pode usar eles no protocolo:
extension ContatoServiceDelegate {
    //get:
    func getContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func getContatosFailure(error: String) {
        fatalError("Precisa ser implementado")
    }
    //post:
    func postContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func postContatosFailure(error: String) {
        fatalError("Precisa ser implementado")
    }
    //del:
    func delContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func delContatosFailure(error: String) {
        fatalError("Precisa ser implementado")
    }
    //put:
    func putContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func putContatosFailure(error: String) {
        fatalError("Precisa ser implementado")
    }
}

class ContatoService{
    
    var delegate:ContatoServiceDelegate
    
    var getContatoRequest: Request?
    
    //init: construtor
    required init(delegate: ContatoServiceDelegate){
        self.delegate = delegate
    }
    
    //get:
    func getContato(){
        
        self.getContatoRequest?.cancel()
        
        self.getContatoRequest = ContatoRequestFactory.getContato().validate().responseArray { (response: DataResponse<[Contato]>) in
            switch response.result{
                
            case .success:
                if let contatos = response.result.value {
                    ContatoViewModel.clear()
                    ContatoViewModel.save(contatos: contatos)
                }
                
                self.delegate.getContatosSuccess()
                
            case .failure(let error):
                
                self.delegate.getContatosFailure(error: error.localizedDescription)
            }
        }
    }
    
    //post:
    func postContato(contato: ContatoView){
//    func postContato(nomeContato: String, aniversarioContato: Int, emailContato: String, telefoneContato: String, imagemContato: String) {
        
        ContatoRequestFactory.postContato(contato: contato).validate().responseObject { (response: DataResponse<Contato>) in
        
            switch response.result{
                
            case .success:
                
                if let contato = response.result.value{
                    ContatoViewModel.save(contato: contato)
                }
                
                self.delegate.postContatosSuccess()
                
            case .failure(let error):
                
                self.delegate.postContatosFailure(error: error.localizedDescription)
            }
        }
    }
    
    //del:
    func delContato(id: Int) {
        ContatoRequestFactory.delContato(contatoId: id).validate().responseJSON { (response: DataResponse<Any>) in
            switch response.result {
            case .success:
               self.delegate.delContatosSuccess()
            case .failure(let error):
                self.delegate.delContatosFailure(error: error.localizedDescription)
            }
        }
    }
    
    //put:
//   func putContato(id: Int,nomeContato: String, aniversarioContato: Int, emailContato: String, telefoneContato: String, imagemContato: String) {
    func putContato(contato: ContatoView){
        ContatoRequestFactory.putContato(contato: contato).validate().responseObject { (response: DataResponse<Contato>) in
            switch response.result{
            case .success:
                if let contato = response.result.value {
                    ContatoViewModel.save(contato: contato)
                }
                self.delegate.putContatosSuccess()
            case .failure(let error):
                self.delegate.putContatosFailure(error: error.localizedDescription)
            }
        }
    }
}
