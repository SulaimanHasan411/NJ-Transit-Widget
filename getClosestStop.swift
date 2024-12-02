import Foundation
import CoreLocation

struct Stop {
    let stopId: Int
    let stopName: String
    let latitude: Double
    let longitude: Double
}

//need to add rest of stops, find a way to get this in from the file
let stops = [
    Stop(stopId: 1, stopName: "30TH ST. PHL.", latitude: 39.956565, longitude: -75.182327),
    Stop(stopId: 2, stopName: "ABSECON", latitude: 39.424333, longitude: -74.502094),
    Stop(stopId: 3, stopName: "ALLENDALE", latitude: 41.030902, longitude: -74.130957),
    Stop(stopId: 4, stopName: "ALLENHURST", latitude: 40.237659, longitude: -74.006769),
    Stop(stopId: 5, stopName: "ANDERSON STREET", latitude: 40.894458, longitude: -74.043781),
    Stop(stopId: 6, stopName: "ANNANDALE", latitude: 40.645173, longitude: -74.878569),
    Stop(stopId: 8, stopName: "ASBURY PARK", latitude: 40.215359, longitude: -74.014786),
    Stop(stopId: 9, stopName: "ATCO", latitude: 39.783547, longitude: -74.907588),
    Stop(stopId: 10, stopName: "ATLANTIC CITY", latitude: 39.363299, longitude: -74.441486),
    Stop(stopId: 11, stopName: "AVENEL", latitude: 40.577620, longitude: -74.277530),
    Stop(stopId: 12, stopName: "BASKING RIDGE", latitude: 40.711378, longitude: -74.555270),
    Stop(stopId: 13, stopName: "BAY HEAD", latitude: 40.077178, longitude: -74.046183),
    Stop(stopId: 14, stopName: "BAY STREET", latitude: 40.808178, longitude: -74.208681),
    Stop(stopId: 15, stopName: "BELMAR", latitude: 40.180590, longitude: -74.027301),
    Stop(stopId: 17, stopName: "BERKELEY HEIGHTS", latitude: 40.682345, longitude: -74.442649),
    Stop(stopId: 18, stopName: "BERNARDSVILLE", latitude: 40.716845, longitude: -74.571023),
    Stop(stopId: 19, stopName: "BLOOMFIELD", latitude: 40.792709, longitude: -74.200043),
    Stop(stopId: 20, stopName: "BOONTON", latitude: 40.903378, longitude: -74.407736),
    Stop(stopId: 21, stopName: "BOUND BROOK", latitude: 40.560929, longitude: -74.530617),
    Stop(stopId: 22, stopName: "BRADLEY BEACH", latitude: 40.203751, longitude: -74.018891),
    Stop(stopId: 23, stopName: "BRICK CHURCH", latitude: 40.765134, longitude: -74.218612),
    Stop(stopId: 24, stopName: "BRIDGEWATER", latitude: 40.559904, longitude: -74.551741),
    Stop(stopId: 25, stopName: "BROADWAY", latitude: 40.922505, longitude: -74.115236),
    Stop(stopId: 26, stopName: "CAMPBELL HALL", latitude: 41.450917, longitude: -74.266554),
    Stop(stopId: 27, stopName: "CHATHAM", latitude: 40.740137, longitude: -74.384812),
    Stop(stopId: 28, stopName: "CHERRY HILL", latitude: 39.928447, longitude: -75.041661),
    Stop(stopId: 29, stopName: "CLIFTON", latitude: 40.867998, longitude: -74.153206),
    Stop(stopId: 30, stopName: "CONVENT", latitude: 40.779038, longitude: -74.443435),
    Stop(stopId: 31, stopName: "ROSELLE PARK", latitude: 40.667150, longitude: -74.266323),
    Stop(stopId: 32, stopName: "CRANFORD", latitude: 40.655523, longitude: -74.303226),
    Stop(stopId: 33, stopName: "DELAWANNA", latitude: 40.831369, longitude: -74.131262),
    Stop(stopId: 34, stopName: "DENVILLE", latitude: 40.883900, longitude: -74.481513),
    Stop(stopId: 35, stopName: "DOVER", latitude: 40.883415, longitude: -74.555887),
    Stop(stopId: 36, stopName: "DUNELLEN", latitude: 40.590869, longitude: -74.463043),
    Stop(stopId: 37, stopName: "EAST ORANGE", latitude: 40.760977, longitude: -74.210464),
    Stop(stopId: 38, stopName: "EDISON STATION", latitude: 40.519148, longitude: -74.410972),
    Stop(stopId: 39, stopName: "EGG HARBOR", latitude: 39.526441, longitude: -74.648028),
    Stop(stopId: 40, stopName: "ELBERON", latitude: 40.265292, longitude: -73.997620),
    Stop(stopId: 41, stopName: "ELIZABETH", latitude: 40.667857, longitude: -74.215174),
    Stop(stopId: 42, stopName: "EMERSON", latitude: 40.975036, longitude: -74.027474),
    Stop(stopId: 43, stopName: "ESSEX STREET", latitude: 40.878973, longitude: -74.051893),
    Stop(stopId: 44, stopName: "FANWOOD", latitude: 40.641060, longitude: -74.385003),
    Stop(stopId: 45, stopName: "FAR HILLS", latitude: 40.685710, longitude: -74.633734),
    Stop(stopId: 46, stopName: "GARFIELD", latitude: 40.866669, longitude: -74.105560),
    Stop(stopId: 47, stopName: "GARWOOD", latitude: 40.652569, longitude: -74.324794),
    Stop(stopId: 48, stopName: "GILLETTE", latitude: 40.678251, longitude: -74.468317),
    Stop(stopId: 49, stopName: "GLADSTONE", latitude: 40.720284, longitude: -74.666371),
    Stop(stopId: 50, stopName: "GLEN RIDGE", latitude: 40.800590, longitude: -74.204655),
    Stop(stopId: 51, stopName: "GLEN ROCK BORO HALL", latitude: 40.961370, longitude: -74.129300),
    Stop(stopId: 52, stopName: "GLEN ROCK MAIN LINE", latitude: 40.962206, longitude: -74.133485),
    Stop(stopId: 54, stopName: "HACKETTSTOWN", latitude: 40.851444, longitude: -74.835352),
    Stop(stopId: 55, stopName: "HAMMONTON", latitude: 39.631673, longitude: -74.799460),
    Stop(stopId: 57, stopName: "HARRIMAN", latitude: 41.293354, longitude: -74.139870),
    Stop(stopId: 58, stopName: "HAWTHORNE", latitude: 40.942539, longitude: -74.152411),
    Stop(stopId: 59, stopName: "HAZLET", latitude: 40.415385, longitude: -74.190393),
    Stop(stopId: 60, stopName: "HIGH BRIDGE", latitude: 40.666884, longitude: -74.895863),
    Stop(stopId: 61, stopName: "HIGHLAND AVENUE", latitude: 40.766863, longitude: -74.243744),
    Stop(stopId: 62, stopName: "HILLSDALE", latitude: 41.002414, longitude: -74.041033),
    Stop(stopId: 63, stopName: "HOBOKEN", latitude: 40.734843, longitude: -74.028046),
    Stop(stopId: 64, stopName: "HOHOKUS", latitude: 40.997369, longitude: -74.113521),
    Stop(stopId: 66, stopName: "KINGSLAND", latitude: 40.810121, longitude: -74.117334),
    Stop(stopId: 67, stopName: "LAKE HOPATCONG", latitude: 40.904219, longitude: -74.665697),
    Stop(stopId: 68, stopName: "LEBANON", latitude: 40.636903, longitude: -74.835766),
    Stop(stopId: 69, stopName: "LINCOLN PARK", latitude: 40.924138, longitude: -74.301826),
    Stop(stopId: 70, stopName: "LINDEN", latitude: 40.629485, longitude: -74.251772),
    Stop(stopId: 71, stopName: "LINDENWOLD", latitude: 39.833809, longitude: -75.000314),
    Stop(stopId: 72, stopName: "LITTLE FALLS", latitude: 40.880669, longitude: -74.235372),
    Stop(stopId: 73, stopName: "LITTLE SILVER", latitude: 40.326715, longitude: -74.041054),
    Stop(stopId: 74, stopName: "LONG BRANCH", latitude: 40.297145, longitude: -73.988331),
    Stop(stopId: 75, stopName: "LYNDHURST", latitude: 40.816473, longitude: -74.124164),
    Stop(stopId: 76, stopName: "LYONS", latitude: 40.684844, longitude: -74.549470),
    Stop(stopId: 77, stopName: "MADISON", latitude: 40.757028, longitude: -74.415105),
    Stop(stopId: 78, stopName: "MAHWAH", latitude: 41.094416, longitude: -74.146620),
    Stop(stopId: 79, stopName: "MANASQUAN", latitude: 40.120573, longitude: -74.047688),
    Stop(stopId: 81, stopName: "MAPLEWOOD", latitude: 40.731149, longitude: -74.275427),
    Stop(stopId: 83, stopName: "METROPARK", latitude: 40.568640, longitude: -74.329394),
    Stop(stopId: 84, stopName: "METUCHEN", latitude: 40.540736, longitude: -74.360671),
    Stop(stopId: 85, stopName: "MIDDLETOWN NJ", latitude: 40.389780, longitude: -74.116131),
    Stop(stopId: 86, stopName: "MIDDLETOWN NY", latitude: 41.457488, longitude: -74.370390),
    Stop(stopId: 87, stopName: "MILLBURN", latitude: 40.725622, longitude: -74.303755),
    Stop(stopId: 88, stopName: "MILLINGTON", latitude: 40.673513, longitude: -74.523606),
    Stop(stopId: 89, stopName: "MONTCLAIR HEIGHTS", latitude: 40.857536, longitude: -74.202500),
    Stop(stopId: 90, stopName: "MONTVALE", latitude: 41.040879, longitude: -74.029152),
    Stop(stopId: 91, stopName: "MORRIS PLAINS", latitude: 40.828637, longitude: -74.478197),
    Stop(stopId: 92, stopName: "MORRISTOWN", latitude: 40.797113, longitude: -74.474086),
    Stop(stopId: 93, stopName: "MOUNT OLIVE", latitude: 40.907376, longitude: -74.730653),
    Stop(stopId: 94, stopName: "MOUNT TABOR", latitude: 40.875904, longitude: -74.481915),
    Stop(stopId: 95, stopName: "MOUNTAIN AVENUE", latitude: 40.848715, longitude: -74.205306),
    Stop(stopId: 96, stopName: "MOUNTAIN LAKES", latitude: 40.885947, longitude: -74.433604),
    Stop(stopId: 97, stopName: "MOUNTAIN STATION", latitude: 40.755365, longitude: -74.253024),
    Stop(stopId: 98, stopName: "MOUNTAIN VIEW", latitude: 40.914402, longitude: -74.268158),
    Stop(stopId: 99, stopName: "MURRAY HILL", latitude: 40.695068, longitude: -74.403134),
    Stop(stopId: 100, stopName: "NANUET", latitude: 41.090015, longitude: -74.014794),
    Stop(stopId: 101, stopName: "NETCONG", latitude: 40.897552, longitude: -74.707317),
    Stop(stopId: 102, stopName: "NETHERWOOD", latitude: 40.629148, longitude: -74.403455),
    Stop(stopId: 103, stopName: "NEW BRUNSWICK", latitude: 40.497278, longitude: -74.445751),
    Stop(stopId: 104, stopName: "NEW PROVIDENCE", latitude: 40.712022, longitude: -74.386501),
    Stop(stopId: 105, stopName: "NEW YORK PENN STATION", latitude: 40.750046, longitude: -73.992358),
    Stop(stopId: 106, stopName: "NEWARK BROAD ST", latitude: 40.747621, longitude: -74.171943),
    Stop(stopId: 107, stopName: "NEWARK PENN STATION", latitude: 40.734221, longitude: -74.164554),
    Stop(stopId: 108, stopName: "NORTH BRANCH", latitude: 40.592020, longitude: -74.683802),
    Stop(stopId: 109, stopName: "NORTH ELIZABETH", latitude: 40.680265, longitude: -74.206165),
    Stop(stopId: 110, stopName: "NEW BRIDGE LANDING", latitude: 40.910856, longitude: -74.035044),
    Stop(stopId: 111, stopName: "ORADELL", latitude: 40.953478, longitude: -74.029983),
    Stop(stopId: 112, stopName: "ORANGE", latitude: 40.771883, longitude: -74.233103),
    Stop(stopId: 113, stopName: "OTISVILLE", latitude: 41.471784, longitude: -74.529212),
    Stop(stopId: 114, stopName: "PARK RIDGE", latitude: 41.032305, longitude: -74.036164),
    Stop(stopId: 115, stopName: "PASSAIC", latitude: 40.849411, longitude: -74.133933),
    Stop(stopId: 116, stopName: "PATERSON", latitude: 40.914887, longitude: -74.167330),
    Stop(stopId: 117, stopName: "PEAPACK", latitude: 40.708794, longitude: -74.658469),
    Stop(stopId: 118, stopName: "PEARL RIVER", latitude: 41.058181, longitude: -74.022320),
    Stop(stopId: 119, stopName: "PERTH AMBOY", latitude: 40.509398, longitude: -74.273752),
    Stop(stopId: 120, stopName: "PLAINFIELD", latitude: 40.618425, longitude: -74.420163),
    Stop(stopId: 121, stopName: "PLAUDERVILLE", latitude: 40.884916, longitude: -74.102695),
    Stop(stopId: 122, stopName: "POINT PLEASANT", latitude: 40.092718, longitude: -74.048191),
    Stop(stopId: 123, stopName: "PORT JERVIS", latitude: 41.374899, longitude: -74.694622),
    Stop(stopId: 124, stopName: "PRINCETON", latitude: 40.342088, longitude: -74.658870),
    Stop(stopId: 125, stopName: "PRINCETON JCT.", latitude: 40.316316, longitude: -74.623753),
    Stop(stopId: 126, stopName: "RADBURN", latitude: 40.939914, longitude: -74.121617),
    Stop(stopId: 127, stopName: "RAHWAY", latitude: 40.606338, longitude: -74.276692),
    Stop(stopId: 128, stopName: "RAMSEY", latitude: 41.056422, longitude: -74.141877),
    Stop(stopId: 129, stopName: "RARITAN", latitude: 40.571005, longitude: -74.634364),
    Stop(stopId: 130, stopName: "RED BANK", latitude: 40.348284, longitude: -74.074538),
    Stop(stopId: 131, stopName: "RIDGEWOOD", latitude: 40.980629, longitude: -74.120592),
    Stop(stopId: 132, stopName: "RIVER EDGE", latitude: 40.935146, longitude: -74.029140),
    Stop(stopId: 134, stopName: "RUTHERFORD", latitude: 40.828248, longitude: -74.100563),
    Stop(stopId: 135, stopName: "SALISBURY MILLS-CORNWALL", latitude: 41.437073, longitude: -74.101871),
    Stop(stopId: 136, stopName: "SHORT HILLS", latitude: 40.725249, longitude: -74.323754),
    Stop(stopId: 137, stopName: "SLOATSBURG", latitude: 41.157138, longitude: -74.191307),
    Stop(stopId: 138, stopName: "SOMERVILLE", latitude: 40.566075, longitude: -74.613970),
    Stop(stopId: 139, stopName: "SOUTH AMBOY", latitude: 40.484308, longitude: -74.280140),
    Stop(stopId: 140, stopName: "SOUTH ORANGE", latitude: 40.745952, longitude: -74.260538),
    Stop(stopId: 141, stopName: "SPRING LAKE", latitude: 40.150557, longitude: -74.035481),
    Stop(stopId: 142, stopName: "SPRING VALLEY", latitude: 41.111978, longitude: -74.043991),
    Stop(stopId: 143, stopName: "STIRLING", latitude: 40.674579, longitude: -74.493723),
    Stop(stopId: 144, stopName: "SUFFERN", latitude: 41.113540, longitude: -74.153442),
    Stop(stopId: 145, stopName: "SUMMIT", latitude: 40.716549, longitude: -74.357807),
    Stop(stopId: 146, stopName: "TETERBORO", latitude: 40.864858, longitude: -74.062676),
    Stop(stopId: 147, stopName: "TOWACO", latitude: 40.922809, longitude: -74.343842),
    Stop(stopId: 148, stopName: "TRENTON TRANSIT CENTER", latitude: 40.218515, longitude: -74.753926),
    Stop(stopId: 149, stopName: "TUXEDO", latitude: 41.194208, longitude: -74.184460),
    Stop(stopId: 150, stopName: "UPPER MONTCLAIR", latitude: 40.842004, longitude: -74.209368),
    Stop(stopId: 151, stopName: "WALDWICK", latitude: 41.012734, longitude: -74.123412),
    Stop(stopId: 152, stopName: "WALNUT STREET", latitude: 40.817218, longitude: -74.209630),
    Stop(stopId: 153, stopName: "WATCHUNG AVENUE", latitude: 40.829514, longitude: -74.206934),
    Stop(stopId: 154, stopName: "WATSESSING AVENUE", latitude: 40.782743, longitude: -74.198451),
    Stop(stopId: 155, stopName: "WESTFIELD", latitude: 40.649448, longitude: -74.347629),
    Stop(stopId: 156, stopName: "WESTWOOD", latitude: 40.990817, longitude: -74.032696),
    Stop(stopId: 157, stopName: "WHITE HOUSE", latitude: 40.615611, longitude: -74.770660),
    Stop(stopId: 158, stopName: "WOODBRIDGE", latitude: 40.556610, longitude: -74.277751),
    Stop(stopId: 159, stopName: "WOODCLIFF LAKE", latitude: 41.021078, longitude: -74.040775),
    Stop(stopId: 160, stopName: "WOOD-RIDGE", latitude: 40.843974, longitude: -74.078719),
    Stop(stopId: 9878, stopName: "PORT IMPERIAL HBLR STATION", latitude: 40.775919, longitude: -74.012921),
    Stop(stopId: 32905, stopName: "HAMILTON", latitude: 40.255309, longitude: -74.704120),
    Stop(stopId: 32906, stopName: "JERSEY AVE.", latitude: 40.476912, longitude: -74.467363),
    Stop(stopId: 37169, stopName: "ABERDEEN-MATAWAN", latitude: 40.420161, longitude: -74.223702),
    Stop(stopId: 37953, stopName: "NEWARK AIRPORT RAILROAD STATION", latitude: 40.704415, longitude: -74.190717),
    Stop(stopId: 38081, stopName: "MSU", latitude: 40.869782, longitude: -74.197439),
    Stop(stopId: 38105, stopName: "UNION", latitude: 40.683663, longitude: -74.238605),
    Stop(stopId: 38174, stopName: "FRANK R LAUTENBERG SECAUCUS LOWER LEVEL", latitude: 40.761188, longitude: -74.075821),
    Stop(stopId: 38187, stopName: "FRANK R LAUTENBERG SECAUCUS UPPER LEVEL", latitude: 40.761188, longitude: -74.075821),
    Stop(stopId: 38307, stopName: "BROADWAY ACROSS FROM WRTC", latitude: 39.943258, longitude: -75.120210),
    Stop(stopId: 38417, stopName: "RAMSEY ROUTE 17 STATION", latitude: 41.075130, longitude: -74.145485),
    Stop(stopId: 38578, stopName: "BERGENLINE AVE", latitude: 40.782225, longitude: -74.022271),
    Stop(stopId: 39472, stopName: "MOUNT ARLINGTON", latitude: 40.896590, longitude: -74.632731),
    Stop(stopId: 39635, stopName: "WAYNE/ROUTE 23 TRANSIT CENTER [RR]", latitude: 40.900254, longitude: -74.256971),
    Stop(stopId: 40570, stopName: "MEADOWLANDS SPORTS COMPLEX STATION", latitude: 40.813053, longitude: -74.072114),
    Stop(stopId: 43298, stopName: "PENNSAUKEN TRANSIT CENTER", latitude: 39.977769, longitude: -75.061796),
    Stop(stopId: 43599, stopName: "WESMONT", latitude: 40.854979, longitude: -74.096951),
]

func distanceInMeters(from location1: CLLocation, to location2: CLLocation) -> CLLocationDistance {
    return location1.distance(from: location2)
}

func closestStop(to userLocation: CLLocation) -> Stop? {
    var closestStop: Stop?
    var shortestDistance: CLLocationDistance = .greatestFiniteMagnitude
    
    for stop in stops {
        let stopLocation = CLLocation(latitude: stop.latitude, longitude: stop.longitude)
        let distance = distanceInMeters(from: userLocation, to: stopLocation)
        
        if distance < shortestDistance {
            shortestDistance = distance
            closestStop = stop
        }
    }
    return closestStop
}

//testing, need to change for live location
let userLatitude = 0.0
let userLongitude = 0.0
let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)

// if let nearestStop = closestStop(to: userLocation) {
//     print("closest stop: \(nearestStop.stopName), stop id: \(nearestStop.stopId)")
// } else {
//     print("not found")
// }
