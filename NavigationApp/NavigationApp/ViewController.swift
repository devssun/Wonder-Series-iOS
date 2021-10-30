//
//  ViewController.swift
//  NavigationApp
//
//  Created by 최혜선 on 2021/10/18.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var addMarkerButton: UIButton!
    @IBOutlet private weak var textView: UITextView!
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // 백그라운드 있을 때 위치 업데이트 허용
        locationManager.allowsBackgroundLocationUpdates = true
        // 위치 업데이트 자동 종료 거부
        locationManager.pausesLocationUpdatesAutomatically = false
        // 백그라운드 위치 인디케이터 노출
        locationManager.showsBackgroundLocationIndicator = true
        // 위치 정확도 최고 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 위치 권한 요청
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스 사용이 가능하다면 locationManager에 현재 위치를 요청한다
            locationManager.requestLocation()
        }
        
        mapView.showsUserLocation = true
    }
    
    fileprivate func setAnnotation(coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        return annotation
    }
    
    fileprivate func getCenterCoordinate() -> CLLocationCoordinate2D {
        return mapView.centerCoordinate
    }
    
    @IBAction private func touchedAddMarkerButton(_ sender: UIButton) {
        let annotation = setAnnotation(coordinate: getCenterCoordinate())
        mapView.addAnnotation(annotation)
    }
    
    @IBAction private func touchedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("start monitoring")
            locationManager.startMonitoringSignificantLocationChanges()
        case 1:
            print("stop monitoring")
            locationManager.stopMonitoringSignificantLocationChanges()
        case 2:
            let annotations = mapView.annotations
            mapView.removeAnnotations(annotations)
        default:
            break
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.first {
            // 위치 업데이트되면 하는 일
            mapView.centerToLocation(lastLocation)
            mapView.addAnnotation(setAnnotation(coordinate: lastLocation.coordinate))
            textView.text.append("위치 \(lastLocation.coordinate)\n")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        textView.text = "에러 발생 \(error.localizedDescription)"
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}


