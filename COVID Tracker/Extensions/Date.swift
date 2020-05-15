//
//  Date.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
