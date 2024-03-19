//
//  WelcomeViewModel.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias  on 19/23/24.
//

import Foundation

final class WelcomeViewModel {
    
    //binding con UI
    var modelStatusLoad: ((StatusLoad) -> Void)?
    
   
    func simulationLoadData() {
        modelStatusLoad?(.loading)
        //Dispatch --> hilos de ejcucion
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.modelStatusLoad?(.loaded)
        }
    }
}
