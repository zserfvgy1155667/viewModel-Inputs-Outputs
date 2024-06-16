//
//  Enum+Language.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/6/13.
//

import Foundation

// 英文、繁中、簡中、日語、韓語、越南語、泰語、印尼語
enum LanguageList: String, CaseIterable, RawRepresentable {
    ///系統設定
    case systemSetting
    ///英文
    case english
    ///繁體中文
    case chineseTrad
    ///簡體中文
    case chineseSimp
    ///日文
    case japanese
    ///韓文
    case korean
    ///越南
    case vietnam
    ///泰文
    case thailand
    ///印尼文
    case indonesia
    
    var localization: String {
        switch self {
        case .systemSetting:
            guard let localization = Bundle.main.preferredLocalizations.first else {
                return "zh-Hant"
            }
            
            if localization == LanguageList.chineseTrad.localization ||
                localization == LanguageList.chineseTrad.localization ||
                localization == LanguageList.english.localization ||
                localization == LanguageList.japanese.localization ||
                localization == LanguageList.korean.localization {
                return localization
            }
            else {
                guard let appleDefaultLanguage = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] else {
                    
                    return ""
                }
                return appleDefaultLanguage.first ?? ""
            }
        case .chineseTrad: return "zh-Hant"
        case .chineseSimp: return "zh-Hans"
        case .english: return "en"
        case .japanese: return "ja"
        case .korean: return "ko"
        case .vietnam: return "vi"
        case .thailand: return "th"
        case .indonesia: return "id"
        }
    }
    
    var type: LanguageType {
        switch self {
        case .systemSetting:
            let type = localization.replace(target: "-", withString: "")
            return .init(rawValue: type) ?? .en
        case .chineseTrad:
            return .zhHant
        case .chineseSimp:
            return .zhHans
        case .english:
            return .en
        case .japanese:
            return .ja
        case .korean:
            return .ko
        case .vietnam:
            return .vi
        case .thailand:
            return .th
        case .indonesia:
            return .id
        }
    }
    
    var webLanguageCode: String {
        switch self {
        case .systemSetting:
            
            guard let localization = Bundle.main.preferredLocalizations.first else {
                return "zh-Hant"
            }
            
            switch localization {
            case LanguageList.chineseSimp.localization:
                return "zh_CN"
            case LanguageList.chineseTrad.localization:
                return "zh_TW"
            case LanguageList.english.localization:
                return "en_US"
            case LanguageList.japanese.localization:
                return "ja_JP"
            case LanguageList.korean.localization:
                return "ko_KR"
            case LanguageList.vietnam.localization:
                return "vi_VN"
            case LanguageList.thailand.localization:
                return "th_TH"
            case LanguageList.indonesia.localization:
                return "id_ID"
            default:
                
                guard let appleDefaultLanguage = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] else {
                    return ""
                }
                
                switch appleDefaultLanguage.first {
                case LanguageList.chineseSimp.localization:
                    return "zh_CN"
                case LanguageList.chineseTrad.localization:
                    return "zh_TW"
                case LanguageList.english.localization:
                    return "en_US"
                case LanguageList.japanese.localization:
                    return "ja_JP"
                case LanguageList.korean.localization:
                    return "ko_KR"
                case LanguageList.vietnam.localization:
                    return "vi_VN"
                case LanguageList.thailand.localization:
                    return "th_TH"
                case LanguageList.indonesia.localization:
                    return "id_ID"
                default:
                    return "zh_TW"
                }
            }
        case .chineseTrad:
            return "zh_TW"
        case .chineseSimp:
            return "zh_CN"
        case .english:
            return "en_US"
        case .japanese:
            return "ja_JP"
        case .korean:
            return "ko_KR"
        case .vietnam:
            return "vi_VN"
        case .thailand:
            return "th_TH"
        case .indonesia:
            return "id_ID"
        }
    }
}
