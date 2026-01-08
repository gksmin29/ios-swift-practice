//
//  AddViewController.swift
//  Table
//
//  Created by hanmin on 2026-01-08.
//

import UIKit

class AddViewController: UIViewController {
    // 텍스트 필드 아웃렛 변수
    @IBOutlet var tfAddItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        // 텍스트 필드의 내용을 items 배열에 append
        items.append(tfAddItem.text!)
        // 기본 이미지를 clock으로 설정
        itemsImageFile.append("clock")
        // 텍스트 필드 비우기
        tfAddItem.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
