//
//  ItemStore.swift
//  SnapStash
//
//  Created by Work on 4/8/25.
//

import SwiftUI

class ItemStore: ObservableObject {
    @Published var items: [ItemModel] = []
    
    func addItem(name: String, location: String, image: UIImage) {
        let newItem = ItemModel(name: name, location: location, image: image)
        items.append(newItem)
    }
    
    func filteredItems(_ query: String) -> [ItemModel] {
        if query.isEmpty { return items }
        return items.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.location.localizedCaseInsensitiveContains(query)
        }
    }
}
