//
//  ViewController.swift
//  Map
//
//  Created by hanmin on 2026-01-07.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 기본 화면에 지도가 나타나지 않을 경우는 Info.plist를 수정해서 해결할 수 있다.
        
        // 위치 정보를 표시할 레이블에는 아직 특별히 표시할 위치가 없으므로 공백
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self // locationManager의 delegate를 self로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치 데이터를 추적하기 위해 사용자에게 승인을 요구
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true // 위치 보기 값을 true로 설정
    }
    // 주어진 위도, 경도를 기반으로 지도의 표시 영역을 설정
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    // 특정 위도와 경도에 핀 설정하고 핀에 타이틀과 서브 타이틀의 문자열 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle:String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치 정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 위치가 업데이트 되면 마지막 위치 값을 찾아냄
        let pLocation = locations.last
        // 마지막 위치의 위도와 경도 값으로 앞에서 만든 goLocation 함수 호출
        // delta는 지도의 크기 결정. 0.01은 100배 확대
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation()
        
    }

    // 세그먼트 컨트롤을 선택하였을 때 호출
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // "현재 위치" 선택 -> 현재 위치 표시
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
            
        }
        else if sender.selectedSegmentIndex == 1 {
            // "상명대학교(서울)" 선택 -> 핀을 설치하고 위치 정보 표시
            setAnnotation(latitudeValue: 37.602980, longitudeValue: 126.955221, delta: 1, title: "상명대학교 서울캠퍼스", subtitle: "서울특별시 종로구 홍지문길 2 20")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "상명대학교 서울캠퍼스"
        }
        else if sender.selectedSegmentIndex == 2 {
            // "이지스퍼블리싱" 선택 -> 핀을 설치하고 위치 정보 표시
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "이지스퍼블리싱 출판사"
        }
    }
    
}

