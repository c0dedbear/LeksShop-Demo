//
//  Array + Extentions.swift
//  LeksShop
//
//  Created by Михаил Медведев on 12/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

//using only this in this project
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() -> Int {
        self = self.removingDuplicates()
        return self.count
    }
}

//
//extension Array where Element: Hashable {
//    var histogram: [Element: Int] {
//        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
//    }
//}
//
//extension Array {
//
//    func filterDuplicates(includeElement: @escaping (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
//        var results = [Element]()
//
//        forEach { (element) in
//            let existingElements = results.filter {
//                return includeElement(element, $0)
//            }
//            if existingElements.count == 0 {
//                results.append(element)
//            }
//        }
//
//        return results
//    }
//}
