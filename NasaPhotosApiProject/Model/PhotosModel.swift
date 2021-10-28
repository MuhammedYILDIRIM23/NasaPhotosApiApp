//
//  PhotosModel.swift
//  NasaPhotosApiProject
//
//  Created by Muhammed YILDIRIM  on 28.10.2021.
//

import Foundation





// MARK: - Photos
struct Photos: Codable {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - Camera
struct Camera: Codable {
    let name: CameraName
    let roverID: Int
    let fullName: FullName

    enum CodingKeys: String, CodingKey {
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

enum FullName: String, Codable {
    case chemistryAndCameraComplex = "Chemistry and Camera Complex"
    case frontHazardAvoidanceCamera = "Front Hazard Avoidance Camera"
    case mastCamera = "Mast Camera"
    case navigationCamera = "Navigation Camera"
    case rearHazardAvoidanceCamera = "Rear Hazard Avoidance Camera"
}

enum CameraName: String, Codable {
    case chemcam = "CHEMCAM"
    case fhaz = "FHAZ"
    case mast = "MAST"
    case navcam = "NAVCAM"
    case rhaz = "RHAZ"
}

// MARK: - Rover
struct Rover: Codable {
    let name: RoverName
    let landingDate, launchDate: String
    let status: Status

    enum CodingKeys: String, CodingKey {
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}

enum RoverName: String, Codable {
    case curiosity = "Curiosity"
}

enum Status: String, Codable {
    case active = "active"
}
