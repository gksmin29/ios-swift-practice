//
//  ViewController.swift
//  PageControl
//
//  Created by hanmin on 2026-01-07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    var images = ["01", "02", "03", "04", "05"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0

        // 페이지 컨트롤의 페이지를 표시하는 부분의 색상
        pageControl.pageIndicatorTintColor = UIColor.green
        // 페이지 컨트롤의 현재 페이지를 표시하는 부분의 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named: images[0])
    }


    // 페이지가 변하면 호출됨
    @IBAction func pageChange(_ sender: UIPageControl) {
        // 페이지 컨트롤의 현재 페이지 이름을 가져온 다음
        // UIImage 타입의 이미지를 만들어서
        // imgView에 할당
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
}

