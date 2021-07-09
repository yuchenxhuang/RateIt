//
//  Array+Convenience.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI
import CoreData

extension FetchedResults {
    func get(_ indexSet: IndexSet) -> [Result] {
        var result = [Result]()
        for index in indexSet {
            result.append(self[index])
        }
        return result
    }
}
