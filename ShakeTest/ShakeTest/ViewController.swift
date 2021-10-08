//
//  ViewController.swift
//  ShakeTest
//
//  Created by 최혜선 on 2021/10/08.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet private weak var mainLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("모션 시작")
        if motion == .motionShake {
            mainLabel.text = "흔들기 모션 시작"
            let safari = SFSafariViewController(url: URL(string: "https://m.naver.com")!)
            self.present(safari, animated: true, completion: nil)
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        mainLabel.text = "흔들기 모션 종료"
        print("모션 종료")
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        mainLabel.text = "흔들기 모션 취소"
        print("모션 취소")
    }
}

