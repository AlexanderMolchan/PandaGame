//
//  DefaultsManager.swift
//  GameBallPanda
//
//  Created by Александр Молчан on 14.04.24.
//

import Foundation

final class DefaultsManager {
    private static let defaults = UserDefaults.standard
    
    static var isHapticEnabled: Bool {
        get {
            defaults.value(forKey: #function) as? Bool ?? true
        } set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var isSoundEnabled: Bool {
        get {
            defaults.value(forKey: #function) as? Bool ?? true
        } set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var bestScore: Int {
        get {
            defaults.value(forKey: #function) as? Int ?? 0
        } set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
}
