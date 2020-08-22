//
//  NetworkUtilities.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 22.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

class NetforkUtilities {
    static func getParams(page: Int) -> [String:String] {
        return [
            "api_key": K.apiKey,
            "page": "\(page)"
        ]
    }
}
