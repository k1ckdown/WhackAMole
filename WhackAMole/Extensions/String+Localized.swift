//
//  String+Localized.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 01.06.2023.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        NSLocalizedString(self,
                          tableName:tableName,
                          bundle: bundle,
                          value: self,
                          comment: "")
    }
}
