//
//  UseCaseProvider.swift
//  GitHubUser
//
//  Created by sergdort on 18/02/2017.
//  Copyright © 2017 sergdort. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {    
    func makeUsersUseCase() -> UserUseCase
}
