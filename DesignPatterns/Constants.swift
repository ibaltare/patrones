//
//  Constants.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import Foundation

final class ApiURL {
    
    static let HEROS_ALL = "https://vapor2022.herokuapp.com/api/heros/all"
    
    static let TOKEN = "eyJ0eXAiOiJKV1QiLCJraWQiOiJwcml2YXRlIiwiYWxnIjoiSFMyNTYifQ.eyJlbWFpbCI6ImJlamxAa2VlcGNvZGluZy5lcyIsImlkZW50aWZ5IjoiN0FCOEFDNEQtQUQ4Ri00QUNFLUFBNDUtMjFFODRBRThCQkU3IiwiZXhwaXJhdGlvbiI6NjQwOTIyMTEyMDB9.hQEhULTK_yTFp559DWZX0x42Fx32PUoxq9321yq75hY"
    
    private init() {}
}

enum NetworkError: Error {
    case malformedURL
    case errorResponse
    case errorCode(Int?)
    case notAuthenticated
}
