//
//  ViewController.swift
//  Navigation
//
//  Created by hanmin on 2026-01-07.
//

import UIKit

class ViewController: UIViewController , EditDelegate{
    
    let imgOn = UIImage(named: "Reindeer_noon")
    let imgOff = UIImage(named: "Reindeer_midnight")
    
    var isOn = true
    
    // 메인화면 메시지
    @IBOutlet var txMessage: UITextField!
    // 메인화면 이미지 뷰
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }
    
    // 화면 전환 오브젝트로 segue가 발생하면 자동으로 호출되는 메서드
    // 다음 화면으로 넘어가기 전에 정보를 prepare하는
    // UIViewController에 정의되어 있는 메서드이므로 override
    // UIKit이 자동으로 호출해준다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // UIViewController 타입의 segue.destination 객체를 EditViewController로 다운캐스팅 해서 변수로 참조
        // as! == 강제 다운캐스팅 (as? == 안전한 다운캐스팅)
        let editViewController = segue.destination as! EditViewController
        // segue.identifier: String? 타입의 문자열
        // storyboard의 AttributeInspector에서 설정한 identifier가 들어간다.
        if segue.identifier == "editButton" {
            // 버튼을 클릭한 경우, 레이블에 '버튼을 사용한 화면 전환임'을 표시
            editViewController.textWayValue = "segue: use button"
        }
        else if segue.identifier == "editBarButton" {
            // 바 버튼을 클릭한 경우, 레이블에 '바 버튼을 사용한 화면 전환임을 표시
            editViewController.textWayValue = "segue: use Bar Button"
        }
        editViewController.textMessage = txMessage.text! // 현재 메시지에 입력한 값 전달
        editViewController.isOn = isOn // 이미지 on/off 상태 전달
        
        // EditViewControllerd에는 해당 컨트롤러에서 사용할 EditDelegate 프로토콜이 정의되어있다.
        // 그 프로토콜을 구현한 메서드의 결과를 self(ViewController)로 전달할 것이라 선언하는 것.
        editViewController.delegate = self
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    
    // 프로토콜을 상속받으면 프로토콜에서 정의한 함수를 무조건 만들어야 한다.
    // 선언(소유)은 EditViewController, 구현은 외부에서.
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }


}

