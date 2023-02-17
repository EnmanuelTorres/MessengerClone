//
//  LocationPickerViewController.swift
//  MessengerClone
//
//  Created by ENMANUEL TORRES on 17/02/23.
//

import UIKit
import CoreLocation
import MapKit

final class LocationPickerViewController: UIViewController {

    public var completion: ((CLLocationCoordinate2D) -> Void)?
    private var coordinates: CLLocationCoordinate2D?
    private var isPickable = true
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    init(coodinates: CLLocationCoordinate2D?) {
        self.coordinates = coodinates
        self.isPickable = coodinates == nil
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor.self: UIColor.systemBackground]
        
        if isPickable {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(sendButtonTappd))
            map.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(didTapmap(_:)))
                                                 
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 1
            map.addGestureRecognizer(gesture)

        }
        else {
            //just showing location
            guard let coordinates = self.coordinates else {
                return
            }
            
            //drop a pin on da location
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            map.addAnnotation(pin)
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor.self: UIColor.systemBlue]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
        view.backgroundColor = .systemBackground
        
        view.addSubview(map)
            }
    
    @objc func sendButtonTappd (){
        guard let coordinates = coordinates else {
            return
        }
        navigationController?.popViewController(animated: true)
        completion?(coordinates)
    }
    @objc func didTapmap (_ gesture: UITapGestureRecognizer){
        let locationInView = gesture.location(in: map)
        let coordinates = map.convert(locationInView, toCoordinateFrom: map)
        self.coordinates = coordinates
        
        for annotation in map.annotations{
            map.removeAnnotation(annotation)
        }
        
        //drop a pin on da location
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        map.addAnnotation(pin)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

  
}

