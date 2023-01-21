//
//  MapViewVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit
import MapKit

extension MapVC {
    func animateOverlayViews(){
        UIView.animate(withDuration: 0.5) {
            self.overlayLocationInputView.isHidden = false
            self.overlayLocationInputView.alpha = 1
            self.overlayLocationInputView.transform = .identity
        } completion: { _ in
            print("DEBUG: presents locationInputView...")
            // animate right after inputView is shown
            UIView.animate(withDuration: 0.3) {
                self.overlayLocationTableView.transform = .identity
                self.overlayLocationTableView.isHidden = false
                self.overlayLocationTableView.alpha = 1
            } completion: { _ in
                print("DEBUG: presents locationTableView...")
                self.overlayLocationInputView.destinationLocationField.becomeFirstResponder()
            }
        }
    }
    
    func dismissLocationView(completion: ((Bool)-> Void)? = nil){
        overlayLocationInputView.destinationLocationField.resignFirstResponder()
        UIView.animate(withDuration: 0.3, animations: {
            UIView.animate(withDuration: 0.5) {
                self.overlayLocationInputView.transform = CGAffineTransform(translationX: 0, y: -200)
                self.overlayLocationTableView.transform = CGAffineTransform(translationX: 0, y: 800)
            } completion: { _ in
                self.overlayLocationInputView.isHidden = true
                self.overlayLocationInputView.alpha = 0
                
                self.overlayLocationTableView.isHidden = true
                self.overlayLocationTableView.alpha = 0
            }
        }, completion: completion)
    }
}
// MARK: OverLayLocationInputViewDelegate -
extension MapVC: OverLayLocationInputViewDelegate{
   
    func textFieldShouldClearSearchResults() {
        self.overlayLocationTableView.placeMarkData.removeAll()
        print("DEBUG: \(overlayLocationTableView.placeMarkData.count)")
    }
    
    func executeLocationSearch(query: String) {
        print("DEBUG:Query is: \(query)")
        searchByLocation(query: query) { [weak self] placemark in
            print("DEBUG: \(placemark)")
            self?.overlayLocationTableView.placeMarkData = placemark  // pass data to tableview
            
           // print("DEBUG: Count: \(self?.overlayLocationTableView.placeMarkData.count)")
        }
    }
    
    func dismissLocationInputView() {
        dismissLocationView { _ in
            print("DEBUG: hides locationInputView & locationTableView...")
//            self.dismiss(animated: true, completion: nil)
        }
    }
}
// MARK: OverlayLocationTableViewDelegate -
extension MapVC: OverlayLocationTableViewDelegate {
    func dismissLocationTableView(coordinate: CLLocationCoordinate2D) {
        dismissLocationView { [weak self] _ in  // 
            guard let self = self else { return }
            self.selectedAnnotation.coordinate = coordinate
            self.mapView.addAnnotation(self.selectedAnnotation) // add annotation of the selected location coordinates
            self.region = .init(center: coordinate, latitudinalMeters: 0.5, longitudinalMeters: 0.5) // region of selected location coordinates
            self.mapView.setRegion(self.region, animated: true)
            self.span = .init(latitudeDelta: 0.1, longitudeDelta: 0.1) //zoom out 
            self.mapView.region.span = self.span
            self.mapView.selectAnnotation(self.selectedAnnotation, animated: true)
        }
    }
    
   
}
// MARK: OverlayDestinationViewDelegate -
extension MapVC: OverlayDestinationViewDelegate{
    func didTapSearchButton() {
        animateOverlayViews()
    }
}

// MARK: OverlaySelectLocationViewDelegate-
extension MapVC: OverlaySelectLocationViewDelegate{
    func didTapLocationButton() {
        animateOverlayViews()
    }
}


// MARK: MKMapViewDelegate -
extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let image = UIImage(named: "uber-map-car")?.withRenderingMode(.alwaysOriginal)
        let resizedSize = CGSize(width: 50, height: 50)
        
        // resize annotation image
        UIGraphicsBeginImageContext(resizedSize)
        image?.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // return resize image
        if let annotation = annotation as? DriverAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: driverAnnotationIdentifier)
            view.image = resizedImage
            return view
        }
        return nil
    }
}

private extension MapVC{
    func searchByLocation(query: String, completion: @escaping ([MKPlacemark])-> Void){
        let request = MKLocalSearch.Request()
        request.region = mapView.region
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let res = response else { return }
            res.mapItems.forEach { item in
                self.placeMarkLocations.append(item.placemark)
                completion(self.placeMarkLocations)
            }
        }
    }
}


