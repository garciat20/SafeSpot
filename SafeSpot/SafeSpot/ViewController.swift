//
//  ViewController.swift
//  SafeSpot
//
//  Created by Thomas on 4/24/25.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var places: [Features] = []

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        mapView.showsUserLocation = true

    }


    func fetchData(lat: Double, lon: Double) {
        //    https://api.geoapify.com/v2/places?categories=commercial.supermarket&filter=rect%3A10.716463143326969%2C48.755151258420966%2C10.835314015356737%2C48.680903341613316&limit=20&apiKey=47c6659547bf4d9ca4367834dbafbaa9
        print(lat)
        let url = URL(string: "https://api.geoapify.com/v2/places?categories=catering.cafe&filter=circle:\(lon),\(lat),7000&limit=5&apiKey=47c6659547bf4d9ca4367834dbafbaa9")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let spot = try JSONDecoder().decode(LocationSpot.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let spots = spot.features
                    self?.places = spots
                    //                    self?.tableView.reloadData()
                    //                    print(spots)
                    //                    print(spots[1].geometry)
                    print("✅ We got \(spots.count) posts!")
                    for feat in spots {
                        print("🍏 : \(feat.properties)")
                        print("🍏 : \(feat.geometry)")
                    }
                    if let verifiedPlaces = self?.places {
                        for place in verifiedPlaces {
                            let coords = place.geometry.coordinates // 0: lon lat]
                            let lat = coords[1]
                            let lon = coords[0]

                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                            annotation.title = place.properties.name
                            annotation.subtitle = "subtitle placeholder"

                            self?.mapView.addAnnotation(annotation)
                       }
                    }
                }
            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }

}

extension ViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
           let lat = userLocation.coordinate.latitude
           let lon = userLocation.coordinate.longitude

           print("User latitude: \(lat), longitude: \(lon)")

           // Center the map on the user's location
           let region = MKCoordinateRegion(
               center: userLocation.coordinate,
               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
           )
           mapView.setRegion(region, animated: true)

           // automatocally called so call api here
           fetchData(lat: lat, lon: lon)
       }
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else{
            return }

        let destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
        destination.name = annotation.title ?? "Relaxing Spot"
        // when user taps on info button it now links to give directions to apple maps
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        destination.openInMaps(launchOptions: launchOptions)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { 
            return nil }

        let id = "defaultPin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView

        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
            view?.canShowCallout = true
            view?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            view?.annotation = annotation
        }

        return view
    }

}

