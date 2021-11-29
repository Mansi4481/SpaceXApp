//
//  DateFormatter.swift
//  Assignment
//
//  Created by Manshi Viramgama on 28/11/21.
//

import Foundation

extension DateFormatter {
    /// "2017-01-15T11:16:11.000Z"
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        //    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ" //"2017-01-15T11:16:11.000-08:00"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension String {
    func changeDateFormattoDefault(format: String = "dd MMM, yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
