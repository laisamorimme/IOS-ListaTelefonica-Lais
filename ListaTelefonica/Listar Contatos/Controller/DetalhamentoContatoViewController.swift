//
//  DetalhamentoContatoViewController.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 03/08/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit

protocol DetalhamentoContatoViewControllerDelegate {
    func atualizar()
}
class DetalhamentoContatoViewController: UIViewController {
    
    //Outlet:
    @IBOutlet weak var imagemContato: UIImageView!
    @IBOutlet weak var labelNomeContato: UILabel!
    @IBOutlet weak var labelEmailContato: UILabel!
    @IBOutlet weak var labelTelefoneContato: UILabel!
    
    @IBOutlet weak var buttonExcluir: UIButton!
    var idContatoPostman : Int!
    var contato : ContatoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //trazendo do banco para o label:
        contato = ContatoViewModel.get(id: idContatoPostman)
        labelNomeContato.text = contato.nome
        labelEmailContato.text = contato.email
        labelTelefoneContato.text = contato.telefone
        imagemContato.kf.setImage(with: contato.avatarUrl)
        
        //button aditar:
        let buttonEditar = UIBarButtonItem(title: L10n.Contatos.editar, style: .plain, target: self, action: #selector(DetalhamentoContatoViewController.irDeUmaPaginaParaAOutra))
        self.navigationItem.rightBarButtonItem = buttonEditar

        
       
    }

     @objc func irDeUmaPaginaParaAOutra(){
        
    }
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonExcluir(_ sender: Any) {
        
    }
    
    
}
