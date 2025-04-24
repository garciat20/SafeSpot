//
//  ViewController.swift
//  SafeSpot
//
//  Created by Thomas on 4/24/25.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var places: [Features] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        fetchData()
    }


    func fetchData() {
//    https://api.geoapify.com/v2/places?categories=commercial.supermarket&filter=rect%3A10.716463143326969%2C48.755151258420966%2C10.835314015356737%2C48.680903341613316&limit=20&apiKey=47c6659547bf4d9ca4367834dbafbaa9
        let url = URL(string: "https://api.geoapify.com/v2/places?categories=catering.cafe&filter=circle:-73.9712,40.7831,7000&limit=5&apiKey=47c6659547bf4d9ca4367834dbafbaa9")!
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
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }

}

