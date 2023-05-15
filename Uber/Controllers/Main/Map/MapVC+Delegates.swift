//
//  MapViewVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit
import MapKit

// MARK: Helper Functions -
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
        overlayLocationInputView.pickupLocationField.resignFirstResponder()
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
    
    func removeAnnotationsOverlay(){
        mapView.annotations.forEach { [weak self] annotations in  // removes annotations
            guard self != nil else { return }
            if let annotation = annotations as? MKPointAnnotation {
                mapView.removeAnnotation(annotation)
            }
        }
        if mapView.overlays.count > 0 { // removes polyline
            mapView.removeOverlay(mapView.overlays[0])
        }
    }
    
    func presentRideActionView(){
        if showDestinationView {
            destinationView.isHidden = true
            destinationView.alpha = 0
        }else{
            selectLocationView.isHidden = true
            selectLocationView.alpha = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.rideActionView.transform = .identity
            self.rideActionView.isHidden = false
            self.rideActionView.alpha = 1
        } completion: { _ in
            print("DEBUG: presents rideActionView...")
        }
    }
}
// MARK: OverLayLocationInputViewDelegate -
extension MapVC: OverLayLocationInputViewDelegate{
   
    func textFieldShouldClearSearchResults() {
        self.overlayLocationTableView.placeMarkData =  [MKPlacemark]()
        self.overlayLocationTableView.locationTableView.reloadData()
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
        dismissLocationView { [weak self] _ in
            print("DEBUG: hides locationInputView & locationTableView...")
            guard let _ = self else { return }
//            self.dismiss(animated: true, completion: nil)
        }
    }
}
// MARK: OverlayLocationTableViewDelegate -
extension MapVC: OverlayLocationTableViewDelegate {
    func dismissLocationTableView(selectedPlacemark: MKPlacemark) {
        destination = MKMapItem(placemark: selectedPlacemark)
        guard let destinationLocation = destination else { return }
        print("DEBUG: destination: \(destination)")
        generatePolyline(toDestination: destinationLocation)
        
        dismissLocationView { [weak self] _ in
            guard let self = self else { return }
            self.selectedAnnotation.coordinate = selectedPlacemark.coordinate
            // add annotation of the selected location coordinates
            self.mapView.addAnnotation(self.selectedAnnotation)

            self.mapView.selectAnnotation(self.selectedAnnotation, animated: true)
            
            // mapview fits annotation between user and destionation locations.
            let annotations = self.mapView.annotations.filter({
                $0.isKind(of: DriverAnnotation.self)
            })
            self.mapView.annotations.forEach { annotation in
                if let anno = annotation as? MKUserLocation {
                    self.annotations.append(anno)
                }

                if let anno = annotation as? MKPointAnnotation {
                    self.annotations.append(anno)
                }
            }
//            self.mapView.showAnnotations(self.annotations, animated: true)
            self.mapView.zoomToFit(annotations: self.annotations)
            self.presentRideActionView()
            
            // pass selectedPlacemark details to rideActionView
            self.rideActionView.destination = selectedPlacemark
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let route = route {
            let polyline = route.polyline
            let lineRenderer = MKPolylineRenderer(overlay: polyline)
            lineRenderer.strokeColor = .black
            lineRenderer.lineWidth = 4
            return lineRenderer
        }
        return MKOverlayRenderer()
    }
}

// MARK: searchByLocation && generatePolyline -
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
        overlayLocationInputView.destinationLocationField.resignFirstResponder()
    }
    
    func generatePolyline(toDestination destination: MKMapItem){
        guard let location = locationManager?.location else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
        print("DEBUG: CurrentLocation: \(location.coordinate)")
        request.destination = destination
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directionRequest = MKDirections(request: request)
        directionRequest.calculate { [unowned self] response, error in
            if let err = error {
                print("DEBUG: Error: \(err.localizedDescription)")
            }
            guard let res = response else { return }
            self.route = res.routes[0]
            guard let polyline = self.route?.polyline else { return }
            self.mapView.addOverlay(polyline)
        }
        
    }
}


