//
//  testApp.swift
//  test
//
//  Created by Ivan Wang on 10/27/24.
//

import WidgetKit
import SwiftUI
import CoreLocation
import Foundation
import UIKit

//@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var sharedDefaults = UserDefaults(suiteName: "group.com.yourcompany.trainwidget")

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Request permission when the object is created
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // CLLocationManagerDelegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        let userLat = location.coordinate.latitude
        let userLon = location.coordinate.longitude

        if let closestStation = findClosestStation(userLat: userLat, userLon: userLon) {
            sharedDefaults?.set(closestStation.stopName, forKey: "ClosestStation")
            WidgetCenter.shared.reloadAllTimelines()
            print("Closest station saved: \(closestStation.stopName)")
        } else {
            print("No closest station found.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

struct Station {
    let stopID: Int
    let stopName: String
    let stopLat: Double
    let stopLon: Double
}

let stations: [Station] = [
    Station(stopID: 1, stopName: "30TH ST. PHL.", stopLat: 39.956565, stopLon: -75.182327),
    Station(stopID: 2, stopName: "ABSECON", stopLat: 39.424333, stopLon: -74.502094),
    Station(stopID: 3, stopName: "ALLENDALE", stopLat: 41.030902, stopLon: -74.130957),
    Station(stopID: 4, stopName: "ALLENHURST", stopLat: 40.237659, stopLon: -74.006769),
    Station(stopID: 5, stopName: "ANDERSON STREET", stopLat: 40.894458, stopLon: -74.043781),
    Station(stopID: 6, stopName: "ANNANDALE", stopLat: 40.645173, stopLon: -74.878569),
    Station(stopID: 8, stopName: "ASBURY PARK", stopLat: 40.215359, stopLon: -74.014786),
    Station(stopID: 9, stopName: "ATCO", stopLat: 39.783547, stopLon: -74.907588),
    Station(stopID: 10, stopName: "ATLANTIC CITY", stopLat: 39.363299, stopLon: -74.441486),
    Station(stopID: 11, stopName: "AVENEL", stopLat: 40.577620, stopLon: -74.277530),
    Station(stopID: 12, stopName: "BASKING RIDGE", stopLat: 40.711378, stopLon: -74.555270),
    Station(stopID: 13, stopName: "BAY HEAD", stopLat: 40.077178, stopLon: -74.046183),
    Station(stopID: 14, stopName: "BAY STREET", stopLat: 40.808178, stopLon: -74.208681),
    Station(stopID: 15, stopName: "BELMAR", stopLat: 40.180590, stopLon: -74.027301),
    Station(stopID: 17, stopName: "BERKELEY HEIGHTS", stopLat: 40.682345, stopLon: -74.442649),
    Station(stopID: 18, stopName: "BERNARDSVILLE", stopLat: 40.716845, stopLon: -74.571023),
    Station(stopID: 19, stopName: "BLOOMFIELD", stopLat: 40.792709, stopLon: -74.200043),
    Station(stopID: 20, stopName: "BOONTON", stopLat: 40.903378, stopLon: -74.407736),
    Station(stopID: 21, stopName: "BOUND BROOK", stopLat: 40.560929, stopLon: -74.530617),
    Station(stopID: 22, stopName: "BRADLEY BEACH", stopLat: 40.203751, stopLon: -74.018891),
    Station(stopID: 23, stopName: "BRICK CHURCH", stopLat: 40.765134, stopLon: -74.218612),
    Station(stopID: 24, stopName: "BRIDGEWATER", stopLat: 40.559904, stopLon: -74.551741),
    Station(stopID: 25, stopName: "BROADWAY", stopLat: 40.922505, stopLon: -74.115236),
    Station(stopID: 26, stopName: "CAMPBELL HALL", stopLat: 41.450917, stopLon: -74.266554),
    Station(stopID: 27, stopName: "CHATHAM", stopLat: 40.740137, stopLon: -74.384812),
    Station(stopID: 28, stopName: "CHERRY HILL", stopLat: 39.928447, stopLon: -75.041661),
    Station(stopID: 29, stopName: "CLIFTON", stopLat: 40.867998, stopLon: -74.153206),
    Station(stopID: 30, stopName: "CONVENT", stopLat: 40.779038, stopLon: -74.443435),
    Station(stopID: 31, stopName: "ROSELLE PARK", stopLat: 40.667150, stopLon: -74.266323),
    Station(stopID: 32, stopName: "CRANFORD", stopLat: 40.655523, stopLon: -74.303226),
    Station(stopID: 33, stopName: "DELAWANNA", stopLat: 40.831369, stopLon: -74.131262),
    Station(stopID: 34, stopName: "DENVILLE", stopLat: 40.883900, stopLon: -74.481513),
    Station(stopID: 35, stopName: "DOVER", stopLat: 40.883415, stopLon: -74.555887),
    Station(stopID: 36, stopName: "DUNELLEN", stopLat: 40.590869, stopLon: -74.463043),
    Station(stopID: 37, stopName: "EAST ORANGE", stopLat: 40.760977, stopLon: -74.210464),
    Station(stopID: 38, stopName: "EDISON STATION", stopLat: 40.519148, stopLon: -74.410972),
    Station(stopID: 39, stopName: "EGG HARBOR", stopLat: 39.526441, stopLon: -74.648028),
    Station(stopID: 40, stopName: "ELBERON", stopLat: 40.265292, stopLon: -73.997620),
    Station(stopID: 41, stopName: "ELIZABETH", stopLat: 40.667857, stopLon: -74.215174),
    Station(stopID: 42, stopName: "EMERSON", stopLat: 40.975036, stopLon: -74.027474),
    Station(stopID: 43, stopName: "ESSEX STREET", stopLat: 40.878973, stopLon: -74.051893),
    Station(stopID: 44, stopName: "FANWOOD", stopLat: 40.641060, stopLon: -74.385003),
    Station(stopID: 45, stopName: "FAR HILLS", stopLat: 40.685710, stopLon: -74.633734),
    Station(stopID: 46, stopName: "GARFIELD", stopLat: 40.866669, stopLon: -74.105560),
    Station(stopID: 47, stopName: "GARWOOD", stopLat: 40.652569, stopLon: -74.324794),
    Station(stopID: 48, stopName: "GILLETTE", stopLat: 40.678251, stopLon: -74.468317),
    Station(stopID: 49, stopName: "GLADSTONE", stopLat: 40.720284, stopLon: -74.666371),
    Station(stopID: 50, stopName: "GLEN RIDGE", stopLat: 40.800590, stopLon: -74.204655),
    Station(stopID: 51, stopName: "GLEN ROCK BORO HALL", stopLat: 40.961370, stopLon: -74.129300),
    Station(stopID: 52, stopName: "GLEN ROCK MAIN LINE", stopLat: 40.962206, stopLon: -74.133485),
    Station(stopID: 54, stopName: "HACKETTSTOWN", stopLat: 40.851444, stopLon: -74.835352),
    Station(stopID: 55, stopName: "HAMMONTON", stopLat: 39.631673, stopLon: -74.799460),
    Station(stopID: 57, stopName: "HARRIMAN", stopLat: 41.293354, stopLon: -74.139870),
    Station(stopID: 58, stopName: "HAWTHORNE", stopLat: 40.942539, stopLon: -74.152411),
    Station(stopID: 59, stopName: "HAZLET", stopLat: 40.415385, stopLon: -74.190393),
    Station(stopID: 60, stopName: "HIGH BRIDGE", stopLat: 40.666884, stopLon: -74.895863),
    Station(stopID: 61, stopName: "HIGHLAND AVENUE", stopLat: 40.766863, stopLon: -74.243744),
    Station(stopID: 62, stopName: "HILLSDALE", stopLat: 41.002414, stopLon: -74.041033),
    Station(stopID: 63, stopName: "HOBOKEN", stopLat: 40.734843, stopLon: -74.028046),
    Station(stopID: 64, stopName: "HOHOKUS", stopLat: 40.997369, stopLon: -74.113521),
    Station(stopID: 66, stopName: "KINGSLAND", stopLat: 40.810121, stopLon: -74.117334),
    Station(stopID: 67, stopName: "LAKE HOPATCONG", stopLat: 40.904219, stopLon: -74.665697),
    Station(stopID: 68, stopName: "LEBANON", stopLat: 40.636903, stopLon: -74.835766),
    Station(stopID: 69, stopName: "LINCOLN PARK", stopLat: 40.924138, stopLon: -74.301826),
    Station(stopID: 70, stopName: "LINDEN", stopLat: 40.629485, stopLon: -74.251772),
    Station(stopID: 71, stopName: "LINDENWOLD", stopLat: 39.833809, stopLon: -75.000314),
    Station(stopID: 72, stopName: "LITTLE FALLS", stopLat: 40.880669, stopLon: -74.235372),
    Station(stopID: 73, stopName: "LITTLE SILVER", stopLat: 40.326715, stopLon: -74.041054),
    Station(stopID: 74, stopName: "LONG BRANCH", stopLat: 40.297145, stopLon: -73.988331),
    Station(stopID: 75, stopName: "LYNDHURST", stopLat: 40.816473, stopLon: -74.124164),
    Station(stopID: 76, stopName: "LYONS", stopLat: 40.684844, stopLon: -74.549470),
    Station(stopID: 77, stopName: "MADISON", stopLat: 40.757028, stopLon: -74.415105),
    Station(stopID: 78, stopName: "MAHWAH", stopLat: 41.094416, stopLon: -74.146620),
    Station(stopID: 79, stopName: "MANASQUAN", stopLat: 40.120573, stopLon: -74.047688),
    Station(stopID: 81, stopName: "MAPLEWOOD", stopLat: 40.731149, stopLon: -74.275427),
    Station(stopID: 83, stopName: "METROPARK", stopLat: 40.568640, stopLon: -74.329394),
    Station(stopID: 84, stopName: "METUCHEN", stopLat: 40.540736, stopLon: -74.360671),
    Station(stopID: 85, stopName: "MIDDLETOWN NJ", stopLat: 40.389780, stopLon: -74.116131),
    Station(stopID: 86, stopName: "MIDDLETOWN NY", stopLat: 41.457488, stopLon: -74.370390),
    Station(stopID: 87, stopName: "MILLBURN", stopLat: 40.725622, stopLon: -74.303755),
    Station(stopID: 88, stopName: "MILLINGTON", stopLat: 40.673513, stopLon: -74.523606),
    Station(stopID: 89, stopName: "MONTCLAIR HEIGHTS", stopLat: 40.857536, stopLon: -74.202500),
    Station(stopID: 90, stopName: "MONTVALE", stopLat: 41.040879, stopLon: -74.029152),
    Station(stopID: 91, stopName: "MORRIS PLAINS", stopLat: 40.828637, stopLon: -74.478197),
    Station(stopID: 92, stopName: "MORRISTOWN", stopLat: 40.797113, stopLon: -74.474086),
    Station(stopID: 93, stopName: "MOUNT OLIVE", stopLat: 40.907376, stopLon: -74.730653),
    Station(stopID: 94, stopName: "MOUNT TABOR", stopLat: 40.875904, stopLon: -74.481915),
    Station(stopID: 95, stopName: "MOUNTAIN AVENUE", stopLat: 40.848715, stopLon: -74.205306),
    Station(stopID: 96, stopName: "MOUNTAIN LAKES", stopLat: 40.885947, stopLon: -74.433604),
    Station(stopID: 97, stopName: "MOUNTAIN STATION", stopLat: 40.755365, stopLon: -74.253024),
    Station(stopID: 98, stopName: "MOUNTAIN VIEW", stopLat: 40.914402, stopLon: -74.268158),
    Station(stopID: 99, stopName: "MURRAY HILL", stopLat: 40.695068, stopLon: -74.403134),
    Station(stopID: 100, stopName: "NANUET", stopLat: 41.090015, stopLon: -74.014794),
    Station(stopID: 101, stopName: "NETCONG", stopLat: 40.897552, stopLon: -74.707317),
    Station(stopID: 102, stopName: "NETHERWOOD", stopLat: 40.629148, stopLon: -74.403455),
    Station(stopID: 103, stopName: "NEW BRUNSWICK", stopLat: 40.497278, stopLon: -74.445751),
    Station(stopID: 104, stopName: "NEW PROVIDENCE", stopLat: 40.712022, stopLon: -74.386501),
    Station(stopID: 105, stopName: "NEW YORK PENN STATION", stopLat: 40.750046, stopLon: -73.992358),
    Station(stopID: 106, stopName: "NEWARK BROAD ST", stopLat: 40.747621, stopLon: -74.171943),
    Station(stopID: 107, stopName: "NEWARK PENN STATION", stopLat: 40.734221, stopLon: -74.164554),
    Station(stopID: 108, stopName: "NORTH BRANCH", stopLat: 40.592020, stopLon: -74.683802),
    Station(stopID: 109, stopName: "NORTH ELIZABETH", stopLat: 40.680265, stopLon: -74.206165),
    Station(stopID: 110, stopName: "NEW BRIDGE LANDING", stopLat: 40.910856, stopLon: -74.035044),
    Station(stopID: 111, stopName: "ORADELL", stopLat: 40.953478, stopLon: -74.029983),
    Station(stopID: 112, stopName: "ORANGE", stopLat: 40.771883, stopLon: -74.233103),
    Station(stopID: 113, stopName: "OTISVILLE", stopLat: 41.471784, stopLon: -74.529212),
    Station(stopID: 114, stopName: "PARK RIDGE", stopLat: 41.032305, stopLon: -74.036164),
    Station(stopID: 115, stopName: "PASSAIC", stopLat: 40.849411, stopLon: -74.133933),
    Station(stopID: 116, stopName: "PATERSON", stopLat: 40.914887, stopLon: -74.167330),
    Station(stopID: 117, stopName: "PEAPACK", stopLat: 40.708794, stopLon: -74.658469),
    Station(stopID: 118, stopName: "PEARL RIVER", stopLat: 41.058181, stopLon: -74.022320),
    Station(stopID: 119, stopName: "PERTH AMBOY", stopLat: 40.509398, stopLon: -74.273752),
    Station(stopID: 120, stopName: "PLAINFIELD", stopLat: 40.618425, stopLon: -74.420163),
    Station(stopID: 121, stopName: "PLAUDERVILLE", stopLat: 40.884916, stopLon: -74.102695),
    Station(stopID: 122, stopName: "POINT PLEASANT", stopLat: 40.092718, stopLon: -74.048191),
    Station(stopID: 123, stopName: "PORT JERVIS", stopLat: 41.374899, stopLon: -74.694622),
    Station(stopID: 124, stopName: "PRINCETON", stopLat: 40.342088, stopLon: -74.658870),
    Station(stopID: 125, stopName: "PRINCETON JCT.", stopLat: 40.316316, stopLon: -74.623753),
    Station(stopID: 126, stopName: "RADBURN", stopLat: 40.939914, stopLon: -74.121617),
    Station(stopID: 127, stopName: "RAHWAY", stopLat: 40.606338, stopLon: -74.276692),
    Station(stopID: 128, stopName: "RAMSEY", stopLat: 41.056422, stopLon: -74.141877),
    Station(stopID: 129, stopName: "RARITAN", stopLat: 40.571005, stopLon: -74.634364),
    Station(stopID: 130, stopName: "RED BANK", stopLat: 40.348284, stopLon: -74.074538),
    Station(stopID: 131, stopName: "RIDGEWOOD", stopLat: 40.980629, stopLon: -74.120592),
    Station(stopID: 132, stopName: "RIVER EDGE", stopLat: 40.935146, stopLon: -74.029140),
    Station(stopID: 134, stopName: "RUTHERFORD", stopLat: 40.828248, stopLon: -74.100563),
    Station(stopID: 135, stopName: "SALISBURY MILLS-CORNWALL", stopLat: 41.437073, stopLon: -74.101871),
    Station(stopID: 136, stopName: "SHORT HILLS", stopLat: 40.725249, stopLon: -74.323754),
    Station(stopID: 137, stopName: "SLOATSBURG", stopLat: 41.157138, stopLon: -74.191307),
    Station(stopID: 138, stopName: "SOMERVILLE", stopLat: 40.566075, stopLon: -74.613970),
    Station(stopID: 139, stopName: "SOUTH AMBOY", stopLat: 40.484308, stopLon: -74.280140),
    Station(stopID: 140, stopName: "SOUTH ORANGE", stopLat: 40.745952, stopLon: -74.260538),
    Station(stopID: 141, stopName: "SPRING LAKE", stopLat: 40.150557, stopLon: -74.035481),
    Station(stopID: 142, stopName: "SPRING VALLEY", stopLat: 41.111978, stopLon: -74.043991),
    Station(stopID: 143, stopName: "STIRLING", stopLat: 40.674579, stopLon: -74.493723),
    Station(stopID: 144, stopName: "SUFFERN", stopLat: 41.113540, stopLon: -74.153442),
    Station(stopID: 145, stopName: "SUMMIT", stopLat: 40.716549, stopLon: -74.357807),
    Station(stopID: 146, stopName: "TETERBORO", stopLat: 40.864858, stopLon: -74.062676),
    Station(stopID: 147, stopName: "TOWACO", stopLat: 40.922809, stopLon: -74.343842),
    Station(stopID: 148, stopName: "TRENTON TRANSIT CENTER", stopLat: 40.218515, stopLon: -74.753926),
    Station(stopID: 149, stopName: "TUXEDO", stopLat: 41.194208, stopLon: -74.184460),
    Station(stopID: 150, stopName: "UPPER MONTCLAIR", stopLat: 40.842004, stopLon: -74.209368),
    Station(stopID: 151, stopName: "WALDWICK", stopLat: 41.012734, stopLon: -74.123412),
    Station(stopID: 152, stopName: "WALNUT STREET", stopLat: 40.817218, stopLon: -74.209630),
    Station(stopID: 153, stopName: "WATCHUNG AVENUE", stopLat: 40.829514, stopLon: -74.206934),
    Station(stopID: 154, stopName: "WATSESSING AVENUE", stopLat: 40.782743, stopLon: -74.198451),
    Station(stopID: 155, stopName: "WESTFIELD", stopLat: 40.649448, stopLon: -74.347629),
    Station(stopID: 156, stopName: "WESTWOOD", stopLat: 40.990817, stopLon: -74.032696),
    Station(stopID: 157, stopName: "WHITE HOUSE", stopLat: 40.615611, stopLon: -74.770660),
    Station(stopID: 158, stopName: "WOODBRIDGE", stopLat: 40.556610, stopLon: -74.277751),
    Station(stopID: 159, stopName: "WOODCLIFF LAKE", stopLat: 41.021078, stopLon: -74.040775),
    Station(stopID: 160, stopName: "WOOD-RIDGE", stopLat: 40.843974, stopLon: -74.078719),
    Station(stopId: 9878, stopName: "PORT IMPERIAL HBLR STATION", stopLat: 40.775919, stopLon: -74.012921),
    Station(stopId: 32905, stopName: "HAMILTON", stopLat: 40.255309, stopLon: -74.704120),
    Station(stopId: 32906, stopName: "JERSEY AVE.", stopLat: 40.476912, stopLon: -74.467363),
    Station(stopId: 37169, stopName: "ABERDEEN-MATAWAN", stopLat: 40.420161, stopLon: -74.223702),
    Station(stopId: 37953, stopName: "NEWARK AIRPORT RAILROAD STATION", stopLat: 40.704415, stopLon: -74.190717),
    Station(stopId: 38081, stopName: "MSU", stopLat: 40.869782, stopLon: -74.197439),
    Station(stopId: 38105, stopName: "UNION", stopLat: 40.683663, stopLon: -74.238605),
    Station(stopId: 38174, stopName: "FRANK R LAUTENBERG SECAUCUS LOWER LEVEL", stopLat: 40.761188, stopLon: -74.075821),
    Station(stopId: 38187, stopName: "FRANK R LAUTENBERG SECAUCUS UPPER LEVEL", stopLat: 40.761188, stopLon: -74.075821),
    Station(stopId: 38307, stopName: "BROADWAY ACROSS FROM WRTC", stopLat: 39.943258, stopLon: -75.120210),
    Station(stopId: 38417, stopName: "RAMSEY ROUTE 17 STATION", stopLat: 41.075130, stopLon: -74.145485),
    Station(stopId: 38578, stopName: "BERGENLINE AVE", stopLat: 40.782225, stopLon: -74.022271),
    Station(stopId: 39472, stopName: "MOUNT ARLINGTON", stopLat: 40.896590, stopLon: -74.632731),
    Station(stopId: 39635, stopName: "WAYNE/ROUTE 23 TRANSIT CENTER [RR]", stopLat: 40.900254, stopLon: -74.256971),
    Station(stopId: 40570, stopName: "MEADOWLANDS SPORTS COMPLEX STATION", stopLat: 40.813053, stopLon: -74.072114),
    Station(stopId: 43298, stopName: "PENNSAUKEN TRANSIT CENTER", stopLat: 39.977769, stopLon: -75.061796),
    Station(stopId: 43599, stopName: "WESMONT", stopLat: 40.854979, stopLon: -74.096951),
]

func haversineDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
    let earthRadius = 6371.0 // in kilometers

    let dLat = (lat2 - lat1).degreesToRadians
    let dLon = (lon2 - lon1).degreesToRadians

    let a = sin(dLat / 2) * sin(dLat / 2) +
            cos(lat1.degreesToRadians) * cos(lat2.degreesToRadians) *
            sin(dLon / 2) * sin(dLon / 2)

    let c = 2 * atan2(sqrt(a), sqrt(1 - a))
    return earthRadius * c
}

extension Double {
    var degreesToRadians: Double {
        return self * .pi / 180.0
    }
}

func findClosestStation(userLat: Double, userLon: Double) -> Station? {
    var closestStation: Station?
    var minDistance = Double.greatestFiniteMagnitude

    for station in stations {
        let distance = haversineDistance(lat1: userLat, lon1: userLon, lat2: station.stopLat, lon2: station.stopLon)
        if distance < minDistance {
            minDistance = distance
            closestStation = station
        }
    }

    return closestStation
}

class ViewController: UIViewController {
    let locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove the call to startUpdatingLocation()
        // locationManager.startUpdatingLocation()
    }
}
