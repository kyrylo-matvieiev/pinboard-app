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
    }
    
    // MARK: - Properties
    
    private let ref = Database.database().reference()
    
    // MARK: - Func
    
    func addPoint(_ point: Point, to user: User, _ completion: @escaping (Error?) -> Void) {
        let path = ref.child(Keys.kUser).child(user.uid).child(Keys.kPontsList).childByAutoId()
        do {
            let json = try point.toJson(excluding: [Keys.kPointId])
            path.setValue(json)
        } catch {
            print("### Error")
        }
    }
    
    
    func getPointLists(for user: User, completion: @escaping ([Point]) -> Void) {
        let path = ref.child(Keys.kUser).child(user.uid).child(Keys.kPontsList)
        
        path.observeSingleEvent(of: .value) { snapshot in
            var tmpPointsList = [Point]()
            guard let snapshotData = snapshot.value as? [String: [String: Any]] else { return }
            
            for snap in snapshotData {
                guard let point = Point(id: snap.key, dict: snap.value) else { continue }
                tmpPointsList.append(point)
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

extension Encodable {
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String: Any] else { throw NSError() }
        
        for key in keys {
            json[key] = nil
        }
        
        return json
    }
}
