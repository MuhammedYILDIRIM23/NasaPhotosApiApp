//
//  DetailVC.swift
//  NasaPhotosApiProject
//
//  Created by Muhammed YILDIRIM  on 26.10.2021.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailEarthDate: UILabel!
    @IBOutlet weak var detailStatus: UILabel!
    @IBOutlet weak var detailCameraDate: UILabel!
    @IBOutlet weak var detailVehicleName: UILabel!
    @IBOutlet weak var detailLaunchDate: UILabel!
    @IBOutlet weak var detailLandingDate: UILabel!
    
    
    var choosenImage = ""
    var choosenEarthDate = ""
    var choosenStatus = ""
    var choosenCameraName = ""
    var choosenVehicleName = ""
    var choosenLaunchDate = ""
    var choosenLandingDate = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailEarthDate.text = "EarthDate:  \(choosenEarthDate)"
        detailStatus.text = "Status:  \(choosenStatus)"
        detailCameraDate.text = "RoverName:  \(choosenCameraName)"
        detailVehicleName.text = "CameraName:  \(choosenVehicleName)"
        detailLaunchDate.text = "LaunchDate:  \(choosenLaunchDate)"
        detailLandingDate.text = "LandingDate:  \(choosenLandingDate)"
        
        let urlImg = URL(string: choosenImage)
        if urlImg != nil {
            if let data = try? Data(contentsOf: urlImg!) {
                detailImageView.image = UIImage(data: data)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
