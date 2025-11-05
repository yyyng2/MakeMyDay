//
//  DDaySortType.swift
//  Domain
//
//  Created by Y on 5/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public enum DDaySortType: String, CaseIterable {
    case titleAsc = "ddaySortTitleAsc"
    case titleDesc = "ddaySortTitleDesc"
    case dateAsc = "ddaySortDateAsc"
    case dateDesc = "ddaySortDateDesc"
    case ddayAsc = "ddaySortDdayAsc"
    case ddayDesc = "ddaySortDdayDesc"
}
