// Copyright (c) 2016 Thanh Pham
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import CoreLocation
import UIKit

protocol LocationConfig {
    var distanceFilter: CLLocationDistance {get set }
    var desiredAccuracy: CLLocationAccuracy {get set}
    var horizontalAccuracy: CLLocationDistance {get set}
}

public enum LocationManagerConfig {
    case `default`
    case other(other: Double)
}

extension LocationManagerConfig: LocationConfig {
    var distanceFilter: CLLocationDistance {
        get {
            switch self {
            case .default:
                return 500.0
            default:
                return self.distanceFilter
            }
        }
        set {
            self.distanceFilter = newValue
        }
    }
    
    var horizontalAccuracy: CLLocationDistance {
        get {
            switch self {
            case .default:
                return kCLLocationAccuracyKilometer
            default:
                return self.horizontalAccuracy
            }
        }
        set {
            self.horizontalAccuracy = newValue
        }
    }
    
    var desiredAccuracy: CLLocationAccuracy {
        get {
            switch self {
            case .default:
                return 2000.0
            default:
                return self.desiredAccuracy
            }
        }
        set {
            self.desiredAccuracy = newValue
        }
    }
}
