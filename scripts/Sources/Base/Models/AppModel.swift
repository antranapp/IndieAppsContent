//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation

struct App: Identifiable, Codable, Equatable, Hashable {
    let version: Int
    let id: String
    let name: String
    let shortDescription: String
    let description: String
    let category: Category
    let links: [Link]
    let previews: [Preview]?
    let releaseNotes: [ReleaseNote]
    let createdAt: Date
    let updatedAt: Date
    
    private enum CodingKeys: String, CodingKey {
        case version, id, name, shortDescription, description, category, links, previews, releaseNotes, createdAt, updatedAt
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        version = try container.decode(Int.self, forKey: .version)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        description = try container.decode(String.self, forKey: .description)
        category = try container.decode(Category.self, forKey: .category)
        links = try container.decode([Link].self, forKey: .links)
        previews = try container.decodeIfPresent([Preview].self, forKey: .previews)
        releaseNotes = try container.decode([ReleaseNote].self, forKey: .releaseNotes)
        
        let dateTransformer = DateDecodableTransformer()
        if version >= 2 {
            createdAt = try container.decode(.createdAt, transformer: dateTransformer)
            updatedAt = try container.decode(.updatedAt, transformer: dateTransformer)
        } else {
            createdAt = Date.from(yyyyMMdd: "2020-06-06") ?? Date()
            updatedAt = Date.from(yyyyMMdd: "2020-06-06") ?? Date()
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(version, forKey: .version)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(shortDescription, forKey: .shortDescription)
        try container.encode(description, forKey: .description)
        try container.encode(category, forKey: .category)
        try container.encode(links, forKey: .links)
        try container.encode(previews, forKey: .previews)
        try container.encode(releaseNotes, forKey: .releaseNotes)

        let dateTransformer = DateEncodableTransformer()

        try container.encode(createdAt, forKey: .createdAt, transformer: dateTransformer)
        try container.encode(updatedAt, forKey: .updatedAt, transformer: dateTransformer)

    }

    init(
        version: Int,
        id: String,
        name: String,
        shortDescription: String,
        description: String,
        category: Category,
        links: [Link],
        previews: [Preview]? = nil,
        releaseNotes: [ReleaseNote],
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.version = version
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.description = description
        self.category = category
        self.links = links
        self.previews = previews
        self.releaseNotes = releaseNotes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

struct ReleaseNote: Identifiable, Codable, Equatable, Hashable {
    var version: String
    var note: String
    
    var id: String {
        version
    }
}

struct Link: Identifiable, Equatable, Hashable {
    
    enum LinkType: String {
        case homepage
        case testflight
        case appstore
        case sourcecode
    }
    
    var value: String
    var type: LinkType
    
    var id: String {
        type.rawValue
    }
}

extension Link: Codable {
    
    enum Key: String, CodingKey {
        case type
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawType = try container.decode(String.self, forKey: .type)
        let value = try container.decode(String.self, forKey: .value)
        
        switch rawType {
            case "homepage":
                self = Link(value: value, type: .homepage)
            case "testflight":
                self = Link(value: value, type: .testflight)
            case "appstore":
                self = Link(value: value, type: .appstore)
            case "sourcecode":
                self = Link(value: value, type: .sourcecode)
            default:
                throw DecodingError.unknownType
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(value, forKey: .value)
    }
}

struct Preview: Identifiable, Equatable, Hashable {
    
    enum PreviewType: String {
        case web
        case macOS
        case iOS
        case iPadOS
        case watchOS
        case tvOS
        
        var description: String {
            switch self {
                case .web:
                    return "web"
                case .macOS:
                    return "macOS"
                case .iOS:
                    return "iOS"
                case .iPadOS:
                    return "iPadOS"
                case .watchOS:
                    return "watchOS"
                case .tvOS:
                    return "tvOS"
            }
        }
    }
    
    let type: PreviewType
    let links: [URL]
    
    var id: String {
        type.description
    }
}

extension Preview: Codable {
    
    enum Key: String, CodingKey {
        case type
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawType = try container.decode(String.self, forKey: .type)
        let rawValue = try container.decode([String].self, forKey: .value)
        let urls = rawValue.compactMap { URL(string: $0) }
        
        guard let type = PreviewType(rawValue: rawType) else {
            throw DecodingError.unknownType
        }
        
        self = Preview(type: type, links: urls)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(type.description, forKey: .type)
        try container.encode(links.compactMap { $0.absoluteString }, forKey: .value)
    }
}

enum Category: String, Codable {
    case arApps = "AR Apps"
    case books = "Books"
    case developerTools = "Developer Tools"
    case education = "Education"
    case entertainment = "Entertainment"
    case finance = "Finance"
    case foodAndDrink = "Food & Drink"
    case graphicsAndDesign = "Graphics & Design"
    case healthAndFitness = "Health & Fitness"
    case kids = "Kids"
    case lifestyle = "Lifestyle"
    case magazinesAndNewspapers = "Magazines & Newspapers"
    case medical = "Medical"
    case music = "Music"
    case navigation = "Navigation"
    case news = "News"
    case photoAndVideo = "Photo & Video"
    case productivity = "Productivity"
    case reference = "Reference"
    case shopping = "Shopping"
    case socialNetworking = "Social Networking"
    case sports = "Sports"
    case travel = "Travel"
    case utilities = "Utilities"

    static func from(rawValue: String) throws -> Self {
        guard let category = Category(rawValue: rawValue) else {
            throw DecodingError.unknownCategory
        }

        return category
    }
}

enum DecodingError: Error {
    case unknownCategory
    case unknownType
    case invalidDate
}
