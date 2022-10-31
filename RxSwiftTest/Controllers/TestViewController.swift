//
//  TestViewController.swift
//  RxSwiftTest
//
//  Created by Vitalii Tsiomenko on 08.10.2022.
//

import UIKit

final class TestViewController: UIViewController {
    @IBOutlet weak var button: MarginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func clickButton(_ sender: Any) {
        print("click")
    }
}

class MarginButton: UIButton {
    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        let margin: CGFloat = 55
        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }
}
