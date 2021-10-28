//
//  ViewController.swift
//  NasaPhotosApiProject
//
//  Created by Muhammed YILDIRIM  on 23.10.2021.
//

import UIKit

class CuriosityVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    var photosArray: [Photo] = []
    
    
    var selectedImage: String?
    var selectedearthDate : String?
    var selectedStatus : String?
    var selectedVehicleName : String?
    var selectedCameraName: String?
    var selectedLaunchDate: String?
    var selectedLandingDate: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kamera Seç", style: .plain, target: self, action: #selector(navigationButton))
       
        
    }
    
    
    @objc func navigationButton() {
        
        self.alertActionCameraName()
        
    }
    
    func fetchPhotos(cameraName: String) {
        let urlstring = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY"
        guard let url = URL(string: urlstring) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(Photos.self, from: data)
                let filter = jsonResult.photos.filter { $0.camera.name.rawValue == cameraName}
                DispatchQueue.main.async {
                    if filter.isEmpty == false {
                        self?.photosArray = filter
                        self?.collectionView.reloadData()
                    } else {
                        self?.alertMessage()
                    }
                     
                    //self?.photosArray = jsonResult.photos
                    
                }
                
            } catch {
                print(err ?? "Error")
            }
        }.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CuriosityViewCell
        let imageUrl = photosArray[indexPath.row].imgSrc
        newCell.configure(with: imageUrl)
        return newCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectedImage = photosArray[indexPath.row].imgSrc
        selectedearthDate = photosArray[indexPath.row].earthDate
        selectedStatus = photosArray[indexPath.row].rover.status.rawValue
        selectedCameraName = photosArray[indexPath.row].rover.name.rawValue
        selectedVehicleName = photosArray[indexPath.row].camera.name.rawValue
        selectedLaunchDate = photosArray[indexPath.row].rover.launchDate
        selectedLandingDate = photosArray[indexPath.row].rover.landingDate
        
        performSegue(withIdentifier: "toDetailVC", sender: nil)
        
        
        
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DetailVC
            destinationVC.choosenImage = selectedImage ?? ""
            destinationVC.choosenEarthDate = selectedearthDate ?? ""
            destinationVC.choosenStatus = selectedStatus ?? ""
            destinationVC.choosenCameraName = selectedCameraName ?? ""
            destinationVC.choosenVehicleName = selectedVehicleName ?? ""
            destinationVC.choosenLaunchDate = selectedLaunchDate ?? ""
            destinationVC.choosenLandingDate = selectedLandingDate ?? ""
            
            
            
            
            
        }
    }
    
    
    
    
    
    
    func alertActionCameraName() {
        
        let alert = UIAlertController(title: "Bir Kamera seçiniz. ", message: "", preferredStyle: .actionSheet)
        let rahzCamera = UIAlertAction(title: "RAHZ", style: .default) { UIAlertAction in
            self.fetchPhotos(cameraName: "RHAZ")
        }
        let fahzCamera = UIAlertAction(title: "FAHZ", style: .default) { UIAlertAction in
            self.fetchPhotos(cameraName: "FHAZ")
        }
        let mastCamera = UIAlertAction(title: "MAST", style: .default) { UIAlertAction in
            self.fetchPhotos(cameraName: "MAST")
        }
        let navcamCamera = UIAlertAction(title: "NAVCAM", style: .default) { UIAlertAction in
            self.fetchPhotos(cameraName: "NAVCAM")
        }
        let chemcamCamera = UIAlertAction(title: "CHEMCAM", style: .default) { UIAlertAction in
            self.fetchPhotos(cameraName: "CHEMCAM")
        }

        let cancelButton = UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil)
        
        alert.addAction(rahzCamera)
        alert.addAction(fahzCamera)
        alert.addAction(mastCamera)
        alert.addAction(navcamCamera)
        alert.addAction(chemcamCamera)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func alertMessage() {
        let alert = UIAlertController(title: "ERROR!", message: "Veri bulunamadı.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}




