//
//  GamesViewController.swift
//  squadup
//
//  Created by Kelvin Yu on 10/28/20.
//

import UIKit
import MapKit
import CoreLocation
import SideMenu

class GamesViewController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    var menu: SideMenuNavigationController?
    let locationManager = CLLocationManager()
    let manager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    @IBOutlet weak var sidebvarMenu: UIButton!
    // @IBOutlet weak var sidebarMenu: UIButton!
    var delegate: GamesViewControllerDelegate?
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sidebvarMenu.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu?.setNavigationBarHidden(true, animated: false)
        
        checkLocationSevices()
    }
    
    @objc func handleMenuToggle()
    {
        print("handleMenuhere")
    }
    
    @IBAction func sideMenuButton(_ sender: Any)
    {
        present(menu!, animated: true)
    }
    
    func setupLocationManager()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func centerViewOnUserLocation()
    {
        if let location = locationManager.location?.coordinate
        {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    func checkLocationSevices(){
        if CLLocationManager.locationServicesEnabled()
        {
            setupLocationManager()
            checkLocationAuthorization()
        }
        else
        {
            
        }
    }

    func checkLocationAuthorization()
    {
        switch manager.authorizationStatus{
        case .authorizedWhenInUse:
            print("here")
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            print("default")
            break
        }
    }
}

extension GamesViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        checkLocationAuthorization()
    }

}

class MenuListController: UITableViewController
{
    var items = ["Ausitn", "Is", "Super", "Super", "Gay"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
