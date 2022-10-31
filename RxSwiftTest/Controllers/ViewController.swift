import UIKit
import RxCocoa
import RxSwift
import RxRelay
import Moya
import Kingfisher
import RealmSwift
import Foundation

final class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let text = PublishSubject<String>()
    
    private let manager = RealmNewsManager.shared
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        manager
            .article
            .bind(to: tableView.rx.items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) { row, model, cell in
            
            if let urlToImage = model.urlToImage,
               let url = URL(string: urlToImage) {
                cell.newsImageView.kf.setImage(with: url,options: [.downloadPriority(0.5)])
            }
            cell.titleNews.text = model.title
            
        }.disposed(by: disposeBag)
        manager.loadNews()
        
        let textfieldText = textField.rx
            .text
            .observe(on: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
        
        textfieldText
            .subscribe(onNext: { value in
                guard let value = value,
                        value.count > 2 else { return }
                
                let provider = MoyaProvider<News>()
                provider.request(.everything((value))) { result in
                    switch result {
                    case .success(let response):
                        guard let restaurantsResponse = try? response.map(NewsModel.self) else { return }
                        
                        self.manager.setNews(news: restaurantsResponse)
                    case .failure(let error):
                        print(error.errorDescription ?? "Unknown error")
                    }
                }
            }).disposed(by: disposeBag)
        
        tableView.rx
          .modelSelected(ArticleModel.self)
          .subscribe(onNext: { model in
              let vc = DitelisController.instantiate(article: model)
              self.navigationController?.pushViewController(vc, animated: true)
          }).disposed(by: disposeBag)
    }
}

