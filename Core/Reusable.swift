//
//  Reusable.swift
//  Core
//
//  Created by Kazuya Ueoka on 2019/01/16.
//  Copyright © 2019 Timers Inc. All rights reserved.
//

import UIKit

public protocol Reusable: class {}

public extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
}

public protocol ReusableCell: Reusable {}
public protocol UITableViewCellReusable: ReusableCell {}
public protocol UICollectionViewCellReusable: ReusableCell {}

public extension UITableViewCellReusable {
    public static func dequeue(_ view: UITableView, for indexPath: IndexPath) -> Self {
        return view.dequeueReusableCell(withIdentifier: Self.reuseIdentifier, for: indexPath) as! Self
    }
}

public extension UICollectionViewCellReusable {
    public static func dequeue(_ view: UICollectionView, for indexPath: IndexPath) -> Self {
        return view.dequeueReusableCell(withReuseIdentifier: Self.reuseIdentifier, for: indexPath) as! Self
    }
}

public protocol ReusableView: Reusable {}
public protocol UITableViewHeaderFooterViewReusable: ReusableView {}
public protocol UICollectionReusableViewReusable: ReusableView {}

public extension UITableViewHeaderFooterViewReusable {
    public static func dequeue(_ view: UITableView) -> Self {
        return view.dequeueReusableHeaderFooterView(withIdentifier: Self.reuseIdentifier) as! Self
    }
}

public extension UICollectionReusableViewReusable {
    public static func dequeue(_ view: UICollectionView, of kind: String, for indexPath: IndexPath) -> Self {
        return view.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.reuseIdentifier, for: indexPath) as! Self
    }
}
