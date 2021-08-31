//
//  Video.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 24.08.2021.
//

import Foundation

struct Video: Codable {
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

struct DataClass: Codable {
    let newest: Newest

    enum CodingKeys: String, CodingKey {
        case newest = "Newest"
    }
}

struct Newest: Codable {
    let data: [VideoInfo]

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

struct VideoInfo: Codable {
    let videos: [VideoElement]
    let title: String
    let image2: String
    let shortContent: String
    let duration: String?
    let createDateWellFormed: String
    let nImage: NImage
    let colorAvarage: String
    let category: Category
    let textColor: String


    enum CodingKeys: String, CodingKey {
        case videos = "Videos"
        case title = "Title"
        case image2 = "Image2"
        case shortContent = "ShortContent"
        case duration = "Duration"
        case category = "Category"
        case createDateWellFormed = "CreateDateWellFormed"
        case nImage = "NImage"
        case colorAvarage = "ColorAvarage"
        case textColor = "TextColor"
    }
}

struct NImage: Codable {
    let width, height: Int
    let value: String
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case width = "Width"
        case height = "Height"
        case value = "Value"
        case thumbnail = "Thumbnail"
    }
}

struct Category: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}

struct VideoElement: Codable {
    let value: String
    let size: Int

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case size = "Size"
    }
}
