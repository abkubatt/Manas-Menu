//
//  Title.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 31.01.23.
//
import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let original_language: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_data: String?
    let vote_average: Double
}
