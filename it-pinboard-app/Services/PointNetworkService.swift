//
//  PointNetworkService.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/29/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import Firebase
import FirebaseDatabase

class PointNetworkService {
    
    private enum Keys {
        static let kPointId = "uid"
        static let kUser = "users"
        static let kPontsList = "pointsList"
        static let kOrderedByName = "name"
    }
    
    // MARK: - Properties
    
    private let ref = Database.database().reference()
    
    // MARK: - Func

    func addPoint(_ point: Point, to user: User, _ completion: @escaping (Error?) -> Void) {
        let path = ref.child(Keys.kUser).child(user.uid).child(Keys.kPontsList).childByAutoId()
        let fireObj = point.convertToDict()
        path.setValue(fireObj) { (error, ref) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func getPointLists(for user: User, completion: @escaping ([Point]) -> Void) {
        let path = ref.child(Keys.kUser).child(user.uid).child(Keys.kPontsList).queryOrdered(byChild: Keys.kOrderedByName)
        path.observeSingleEvent(of: .value) { snapshot in
            var tmpPointsList = [Point]()
            snapshot.children.forEach {
                if let snapshot = $0 as? DataSnapshot,
                    let dict = snapshot.value as? [String: Any],
                    let point = Point(id: snapshot.key, dict: dict) {
                    tmpPointsList.append(point)
                }
            }
            completion(tmpPointsList)
        }
    }
    
    func deletePoint(id: String, form user: User, completion: @escaping (Error?) -> Void) {
        let path = ref.child(Keys.kUser).child(user.uid).child(Keys.kPontsList).child(id)
        path.removeValue { (error, ref) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
