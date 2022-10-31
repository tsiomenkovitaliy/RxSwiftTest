//
//  DitelisController.swift
//  
//
//  Created by Vitalii Tsiomenko on 25.07.2022.
//

import UIKit
import Kingfisher
import RxSwift
import RxRelay

final class DitelisController: UIViewController {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var article = BehaviorRelay<ArticleModel?>(value: nil)
    let disposeBag = DisposeBag()
    
    static func instantiate(article: ArticleModel) -> DitelisController {
      guard let vc = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "DitelisController") as? DitelisController else { fatalError("Unexpectedly failed getting DitelisController from Storyboard") }

        vc.article.accept(article)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        article.subscribe(onNext: { [newsImageView, titleLabel] value in
            guard let urlToImage = value?.urlToImage,
                  let url = URL(string: urlToImage) else  {
                return
            }
            newsImageView!.kf.setImage(with: url)
            titleLabel!.text = value?.content
        }).disposed(by: disposeBag)
    }
}
