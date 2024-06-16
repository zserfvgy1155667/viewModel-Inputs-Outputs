//
//  Language+Resources.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/6/16.
//

import Foundation

extension String {

    func localized() -> String {
        return Localization.string(self)
    }
    
    func localized(_ lang: String) -> String {
        let path = Bundle.main.path(forResource: "Resource.bundle/" + lang, ofType: "lproj")
        
        guard let sourcePath = path,
                let bundle = Bundle(path: sourcePath) else {
            return ""
        }
        
        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
    }
}

enum Localization {
    static func string(_ key: String, localization: String? = nil) -> String {
        
        guard !key.isEmpty else {
            return String()
        }
        
        
        if let localization = localization {
            return key.localized(localization)
        }
        return LanguageList.systemSetting.localization
    }
}
