//
//  StatFinder.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/29/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct StatFinder {
    
    var points: Int?
    var assists: Int?
    var completions: Int?
    var deflections: Int?
    var pointsPlayed: Int?
    var throwingErrors: Int?
    var catchingErrors: Int?
    var fouls: Int?
    var goallineCatchingErrors: Int?
    var goallineThrowingErrors: Int?
    var goallineDeflections: Int?
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let points = json["Points"] as? Int else {
            return nil
        }
        self.points = points
        
        guard let assists = json["Assists"] as? Int else {
            return nil
        }
        self.assists = assists
        
        guard let completions = json["Completions"] as? Int else {
            return nil
        }
        self.completions = completions
        
        guard let deflections = json["Deflections"] as? Int else {
            return nil
        }
        self.deflections = deflections
        
        guard let pointsPlayed = json["PointsPlayed"] as? Int else {
            return nil
        }
        self.pointsPlayed = pointsPlayed
        
        guard let throwingErrors = json["ThrowingErrors"] as? Int else {
            return nil
        }
        self.throwingErrors = throwingErrors
        
        guard let catchingErrors = json["CatchingErrors"] as? Int else {
            return nil
        }
        self.catchingErrors = catchingErrors
        
        guard let fouls = json["Fouls"] as? Int else {
            return nil
        }
        self.fouls = fouls
        
        guard let goallineCatchingErrors = json["GoallineCatchingErrors"] as? Int else {
            return nil
        }
        self.goallineCatchingErrors = goallineCatchingErrors
        
        guard let goallineThrowingErrors = json["GoallineThrowingErrors"] as? Int else {
            return nil
        }
        self.goallineThrowingErrors = goallineThrowingErrors
        
        guard let goallineDeflections = json["GoallineDeflections"] as? Int else {
            return nil
        }
        self.goallineDeflections = goallineDeflections
    }
}
