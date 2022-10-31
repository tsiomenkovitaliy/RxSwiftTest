import Foundation
import RealmSwift

final class NewsModel: Object, Codable {
    dynamic var articles : List<ArticleModel> = List<ArticleModel>()
    @objc dynamic var status : String = String()
    @objc dynamic var totalResults : Int = Int()


    enum CodingKeys: String, CodingKey {
        case articles = "articles"
        case status = "status"
        case totalResults = "totalResults"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent(List<ArticleModel>.self, forKey: .articles)!
        status = try values.decodeIfPresent(String.self, forKey: .status)!
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)!
    }
}

@objcMembers class ArticleModel : Object, Codable {
    @objc dynamic var author : String = String()
    @objc dynamic var content : String = String()
    @objc dynamic var descriptionField : String = String()
    @objc dynamic var publishedAt : String = String()
//    dynamic var source : SourceModel?
    @objc dynamic var title : String = String()
    @objc dynamic var url : String = String()
    @objc dynamic var urlToImage : String? = String()


    enum CodingKeys: String, CodingKey {
        case author = "author"
        case content = "content"
        case descriptionField = "description"
        case publishedAt = "publishedAt"
//        case source = "source"
        case title = "title"
        case url = "url"
        case urlToImage = "urlToImage"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? ""
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
//        source = try values.decodeIfPresent(SourceModel.self, forKey: .source)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
    }
}

@objcMembers class SourceModel: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var name: String!
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
    

//// MARK: - NewsModel
//@objcMembers class NewsData: Object, Codable {
//    dynamic var status: String!
//    dynamic var totalResults: Int!
//    var articles = RealmSwift.List<ArticleData>()
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case totalResults
//        case articles
//    }
//
////    init(status: String, totalResults: Int, articles: [ArticleData]) {
////        self.status = status
////        self.totalResults = totalResults
////        self.articles = articles
////    }
//
////    override static func primaryKey() -> String?
////    {
////        return "id"
////    }
//
//    required init(from decoder: Decoder) throws
//    {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        status = try container.decode(String.self, forKey: .status)
//        totalResults = try container.decode(Int.self, forKey: .totalResults)
//
//        let articleList = try container.decode([ArticleData].self, forKey: .articles)
//        articles.append(objectsIn: articleList)
//
//        super.init()
//    }
//}
//
//// MARK: - Article
//@objcMembers class ArticleData: Object, Codable {
////    dynamic var source: SourceData!
//    dynamic var author: String?
//    dynamic var title: String!
//    dynamic var articleDescription: String!
//    dynamic var url: String!
//    dynamic var urlToImage: String?
//    dynamic var publishedAt: String!
//    dynamic var content: String!
//
//    enum CodingKeys: String, CodingKey {
////        case source
//        case author, title
//        case articleDescription = "description"
//        case url, urlToImage, publishedAt, content
//    }
//
//    required init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
////        source = try container.decode(SourceData.self, forKey: .source)
//        author = try container.decode(String.self, forKey: .author)
//        title = try container.decode(String.self, forKey: .title)
//        articleDescription = try container.decode(String.self, forKey: .articleDescription)
//        url = try container.decode(String.self, forKey: .url)
//        urlToImage = try container.decode(String.self, forKey: .urlToImage)
//        publishedAt = try container.decode(String.self, forKey: .publishedAt)
//        content = try container.decode(String.self, forKey: .content)
//
//        super.init()
//    }
//
////    init(source: SourceData, author: String?, title: String, articleDescription: String, url: String, urlToImage: String?, publishedAt: String, content: String) {
////        self.source = source
////        self.author = author
////        self.title = title
////        self.articleDescription = articleDescription
////        self.url = url
////        self.urlToImage = urlToImage
////        self.publishedAt = publishedAt
////        self.content = content
////    }
//}
//
//// MARK: - Source
////@objcMembers class SourceData: Object, Codable {
////    dynamic var id: String?
////    dynamic var name: String!
//
////    init(id: String?, name: String) {
////        self.id = id
////        self.name = name
////    }
//
////    public override convenience init() {
////        self.init()
////    }
//
////    required init(from decoder: Decoder) throws
////    {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////
////        id = try container.decode(String.self, forKey: .id)
////        name = try container.decode(String.self, forKey: .name)
////
////        super.init()
////    }
////
////    override static func primaryKey() -> String?
////    {
////        return "id"
////    }
////}
