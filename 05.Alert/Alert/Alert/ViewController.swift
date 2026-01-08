//
//  ViewController.swift
//  Alert
//
//  Created by hanmin on 2026-01-06.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var reindeerImage: UIImageView!
    
    let imgOn = UIImage(named: "Reindeer_noon")
    let imgOff = UIImage(named: "Reindeer_midnight")
    let imgRemove = UIImage(named: "Reindeer_afternoon")
    
    var isLampOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        reindeerImage.image = imgOn
    }

    @IBAction func btnOn(_ sender: UIButton) {
        
        if (isLampOn == true) {
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 On 상태입니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction (title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true, completion: nil)
            
        } else {
            reindeerImage.image = imgOn
            isLampOn = true
        }
    }
    
    @IBAction func btnOff(_ sender: UIButton) {
        if isLampOn {
            let lampOffAlert = UIAlertController(title: "램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            
            let offAction = UIAlertAction (title: "네", style: UIAlertAction.Style.default, handler: {
                ACTION in self.reindeerImage.image = self.imgOff
                self.isLampOn = false
            })
            
            let cancelAction = UIAlertAction (title: "아니오", style: UIAlertAction.Style.default, handler: nil)
            
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            
            present(lampOffAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "램프제거", message: "램프를 제거하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        
        
        let offAction = UIAlertAction(title: "아니오, 끕니다(off).", style: UIAlertAction.Style.default, handler: {
            ACTION in self.reindeerImage.image = self.imgOff
            self.isLampOn = false
        })
        
        
        
        let onAction = UIAlertAction(title: "아니오, 켭니다(on).", style: UIAlertAction.Style.default) {
            ACTION in self.reindeerImage.image = self.imgOn
            self.isLampOn = true
        }
        
        
        
        let removeAction = UIAlertAction(title: "네, 제거합니다.", style: UIAlertAction.Style.destructive, handler:{
            Action in self.reindeerImage.image = self.imgRemove
            self.isLampOn = false
        })
        
        
        
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        present(lampRemoveAlert, animated: true, completion: nil)
    }
}

