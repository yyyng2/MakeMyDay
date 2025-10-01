//
//  DDaySortType.swift
//  Domain
//
//  Created by Y on 5/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public enum DDaySortType: String, CaseIterable {
    case titleAsc = "dday_sort_titleAsc"
    case titleDesc = "dday_sort_titleDesc"
    case dateAsc = "dday_sort_dateAsc"
    case dateDesc = "dday_sort_dateDesc"
    case ddayAsc = "dday_sort_ddayAsc"
    case ddayDesc = "dday_sort_ddayDesc"
}
