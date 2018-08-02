//
//  LinhaTableViewCell.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 30/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class LinhaTableViewCell: UITableViewCell, NibReusable {
    
    //Foto e label:
    @IBOutlet weak var imagemPerfil: UIImageView!
    @IBOutlet weak var LabelNomePessoa: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(contato: ContatoView) {
        
        self.LabelNomePessoa.text = contato.nome
        
        if let url = contato.avatarUrl {
            
            self.imagemPerfil.kf.setImage(with: url)
        }
    }
}
