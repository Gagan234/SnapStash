//
//  ItemModel.swift
//  SnapStash
//
//  Created by Work on 4/8/25.
//

import SwiftUI

struct ItemModel: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let image: UIImage
}
