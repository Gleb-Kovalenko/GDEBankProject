//
//  URL+Mock.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import Foundation

// MARK: - URL+Mock

extension URL {
    
    public static let mock = URL(string: "https://www.apple.com/").unsafelyUnwrapped
    
}

// MARK: - URL+Random

extension URL {
    
    public static func random() -> URL {
        let urlStrings = [
            "https://img.freepik.com/free-photo/a-cupcake-with-a-strawberry-on-top-and-a-strawberry-on-the-top_1340-35087.jpg?w=996&t=st=1699872496~exp=1699873096~hmac=9901cd4149e4c13ce2fd99ba734e9fb0e1d85628b360974ee44db31484d96591"
        ]
        return URL(string: urlStrings.randomElement().unsafelyUnwrapped).unsafelyUnwrapped
    }
    
    public static func randomTransactions() -> URL {
        let urlStrings = [
            "https://host.daxil.io/api/v1/profile/history/icons/transfer_1724750726.png",
            "https://host.daxil.io/api/v1/profile/history/icons/deposit_1724750726.png",
            "https://host.daxil.io/api/v1/profile/history/icons/exchange_1724750726.png"
        ]
        return URL(string: urlStrings.randomElement().unsafelyUnwrapped).unsafelyUnwrapped
    }
    
    public static func randomSite() -> URL {
        let urlStrings = [
            "https://www.apple.com"
        ]
        return URL(string: urlStrings.randomElement().unsafelyUnwrapped).unsafelyUnwrapped
    }
    
    public static func randomProfilePhotoURL() -> URL? {
        let urlStrings = [
            "https://github.com/acani/fake_profile_pictures/blob/master/lib/fake_profile_pictures/photos/large_2369151434.jpg?raw=true",
            "https://github.com/acani/fake_profile_pictures/blob/master/lib/fake_profile_pictures/photos/large_2890368131.jpg?raw=true",
            "https://github.com/acani/fake_profile_pictures/blob/master/lib/fake_profile_pictures/photos/large_3156504080.jpg?raw=true",
            "https://github.com/acani/fake_profile_pictures/blob/master/lib/fake_profile_pictures/photos/large_3244887018.jpg?raw=true"
        ]
        return URL(string: urlStrings.randomElement().unsafelyUnwrapped).unsafelyUnwrapped
    }
    
    public static func randomQRURL() -> URL {
        let urlStrings = [
            "https://tamali.net/barcode/2d/qr/images/qr-url.png"
        ]
        return URL(string: urlStrings.randomElement().unsafelyUnwrapped).unsafelyUnwrapped
    }
    
    public static func randomSocialURL() -> URL {
        let socials = [""]
        let url = URL(string: socials.randomElement().unsafelyUnwrapped)
        return url!
    }
    
    public static func randomFileURL(format: StatementExportType? = nil) -> URL {
        let pdfFiles = [
            "https://filesamples.com/samples/document/pdf/sample3.pdf",
            "https://filesamples.com/samples/document/pdf/sample2.pdf",
            "https://filesamples.com/samples/document/pdf/sample1.pdf"
        ].compactMap(URL.init)
        let excelFiles = [
            "https://filesamples.com/samples/document/xlsx/sample3.xlsx",
            "https://filesamples.com/samples/document/xlsx/sample2.xlsx",
            "https://filesamples.com/samples/document/xlsx/sample1.xlsx"
        ].compactMap(URL.init)
        if let format {
            switch format {
            case .pdf:
                return pdfFiles.randomElement().unsafelyUnwrapped
            case .excel:
                return excelFiles.randomElement().unsafelyUnwrapped
            }
        } else {
            return (pdfFiles + excelFiles).randomElement().unsafelyUnwrapped
        }
    }
}
