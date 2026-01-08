//
//  EditViewController.swift
//  Navigation
//
//  Created by hanmin on 2026-01-07.
//

import UIKit

// 프로토콜은 단순한 선언의 형태만을 가지며, 실질적으로는 아무런 내용이 없다.
protocol EditDelegate{
    // 함수의 선언
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    // 수정화면에서 직접 텍스트 필드의 텍스트를 제어할 수 없기 때문에 변수 textMessage를 문자열로 만듭니다.
    var textMessage: String = ""
    var delegate: EditDelegate?
    var isOn = false
    
    
    @IBOutlet var lblWay: UILabel! // 어느 방법으로 페이지 이동이 일어났는 지 표시하는 레이블
    @IBOutlet var txMessage: UITextField! // 수정화면 메시지
    @IBOutlet var swIsOn: UISwitch! // 이미지 켜고 끄는 스위치
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn  = isOn
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil { // delegate에 EditDelegate가 구현된 객체가 할당 되어있는가
            //
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
        }
        // EditViewController의 생명주기를 종료하고, 사용자 flow를 이전 흐름으로 되돌린다.
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
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
