import Foundation
import RealmSwift
import RxSwift
import RxRelay

final class RealmNewsManager {
    static var shared = RealmNewsManager ()
    
    var realm = try! Realm()
    
    var article = BehaviorRelay<List<ArticleModel>>(value: List<ArticleModel>())
    var news: NewsModel!
    
    func loadNews() {
        let newsList = realm.objects(NewsModel.self)
        
        guard let news = newsList.last else { return }
        self.article.accept(news.articles)
//            return
//        }
    }
    
    func setNews(news: NewsModel) {
        self.news = news
        self.article.accept(news.articles)
    }
    
    func writeNews() {
        guard let news = news else { return }
        try? realm.write({
            realm.add(news)
        })
    }
}
