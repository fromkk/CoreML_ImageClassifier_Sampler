//
//  Instantitable.swift
//  Core
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit

public protocol Instantitable: class {}

public protocol StoryboardInstantitable: Instantitable {
    static var viewControllerIdentifier: String? { get }
}

public protocol UINibInstantitable: Instantitable {}

public extension UINibInstantitable {
    public static var nibName: String { return String(describing: self) }
    public static var nibBundle: Bundle { return Bundle(for: self) }
    
    public static func nib(name: String = Self.nibName, bundle: Bundle = Self.nibBundle) -> UINib {
        return UINib(nibName: name, bundle: bundle)
    }
    
    public static func instantiate(name: String = Self.nibName, bundle: Bundle = Self.nibBundle, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        let nib = self.nib(name: name, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: options).first as! Self
    }
}

public extension StoryboardInstantitable {
    public static var storyboardName: String { return String(describing: self) }
    public static var storyboardBundle: Bundle { return Bundle(for: self) }
    
    public static func storyboard(name: String = Self.storyboardName, bundle: Bundle = Self.storyboardBundle) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    public static func instantiate(name: String = Self.storyboardName, bundle: Bundle = Self.storyboardBundle, identifier: String? = Self.viewControllerIdentifier) -> Self {
        let storyboard = self.storyboard(name: name, bundle: bundle)
        if let identifier = identifier {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        } else {
            return storyboard.instantiateInitialViewController() as! Self
        }
    }
}
