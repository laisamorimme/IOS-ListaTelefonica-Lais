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

extension ContatoServiceDelegate {
    //get:
    func getContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func getContatosFailure() {
        fatalError("Precisa ser implementado")
    }
    //post:
    func postContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func postContatosFailure() {
        fatalError("Precisa ser implementado")
    }
    //del:
    func delContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func delContatosFailure() {
        fatalError("Precisa ser implementado")
    }
    //put:
    func putContatosSuccess() {
        fatalError("Precisa ser implementado")
    }
    func putContatosFailure() {
        fatalError("Precisa ser implementado")
    }
}

class ContatoService{
    
    var delegate:ContatoServiceDelegate
    
    //init: construtor
    required init(delegate: ContatoServiceDelegate){
        self.delegate = delegate
    }
    
    //get:
    func getContato(){
        
        ContatoRequestFactory.getContato().validate().responseArray{ (response: DataResponse<[Contato]>) in
            switch response.result{
                
            case .success:
                if let contatos = response.result.value{
                    
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
    func postContato(nomeContato: String, aniversarioContato: Int, emailContato: String, telefoneContato: String, imagemContato: String){
        
        ContatoRequestFactory.criarContato(nome: nomeContato, aniversario: aniversarioContato, email: emailContato, telefone: telefoneContato, imagem: imagemContato).validate().responseObject { (response: DataResponse<Contato>) in
        
            switch response.result{
                
            case .success:
                
                if let contato = response.result.value{
                    
                    ContatoViewModel.save(contatos: [contato])
                }
                
                self.delegate.postContatosSuccess()
                
            case .failure(let error):
                
                self.delegate.postContatosFailure(error: error.localizedDescription)
            }
        }
    }
    
    //del:
    func delContato(id: Int) {
        
        ContatoRequestFactory.del(contatoId: id).validate().responseJSON { (response: DataResponse<Any>) in
            
            switch response.result{
            
            case .success:
                
                self.delegate.delContatosSuccess()
                
            case .failure(let error):
                
                self.delegate.delContatosFailure(error: error.localizedDescription)
            }
        }
    }
    
    //put:
    func putContato(id: Int,nomeContato: String, aniversarioContato: Int, emailContato: String, telefoneContato: String, imagemContato: String) {
        
        ContatoRequestFactory.put(contatoId: id, nome: nomeContato, aniversario: 0, email: emailContato, telefone: telefoneContato, imagem: imagemContato).validate().responseObject { (response: DataResponse<Contato>) in
            
            switch response.result{
            case .success:
                if let contato = response.result.value{
                    ContatoViewModel.save(contatos: [contato])
                }
            case .failure(let error):
                self.delegate.putContatosFailure(error: error.localizedDescription)
            }
        }
    }
}
