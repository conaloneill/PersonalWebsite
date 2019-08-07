//
//  Helpers.swift
//  App
//
//  Created by Conal O'Neill on 31/07/2019.
//

import Foundation
import Vapor

func externalRequest(req: Request, url: String) throws -> Future<String> {
    let client = try req.make(Client.self)
    let ans = client.get(url).flatMap { exampleResponse in
        return try exampleResponse.content.decode(String.self)
    }
    return ans
}

