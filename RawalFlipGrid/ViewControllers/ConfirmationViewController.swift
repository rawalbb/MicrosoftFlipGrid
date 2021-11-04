//
//  ConfirmationViewController.swift
//  RawalFlipGrid
//
//  Created by Bansri Rawal on 10/23/21.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    
    @IBOutlet weak var confirmationStackView: UIStackView!
    
    var headerLabel = "Hello!"
    let subHeaderLabel = "Your super-awesome portfolio has been successfully submitted! The details below will be public within your community!"
    var confirmedData: ConfirmationData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    func setupView(){
        
        var arr = [String]()
        
        if let name = confirmedData?.name{
            if name != "" {
                headerLabel = "Hello, \(name)!"
            }
            arr.append(name)
        }
        if let email = confirmedData?.email{
            arr.append(email)
        }
        if let website = confirmedData?.website{
            arr.append(website)
        }
        
        arr.forEach{
            let label = UILabel()
            label.numberOfLines = 0
            label.style = .appP1
            label.text = $0
            label.lineBreakMode = .byWordWrapping
            self.confirmationStackView.addArrangedSubview(label)
        }
        
        headingLabel.text = headerLabel
        headingLabel.font = .appH1
        subHeadingLabel.text = subHeaderLabel
        subHeadingLabel.font = .appP1
    }
}
