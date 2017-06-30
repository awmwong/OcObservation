//
//  ColorTicker.swift
//  rxobjc
//
//  Created by Anthony Wong on 2017-06-30.
//  Copyright © 2017 Anthony Wong. All rights reserved.
//

import Foundation
import RxSwift

class ColorTicker: NSObject {
    let colors: [UIColor] = [.red, .green, .blue, .black, .yellow, .orange, .gray]
    var colorIndex = 0
    
    let colorSubject = BehaviorSubject<UIColor>(value: .white)
    var tickTimer: Timer!
    var tickCount = 0
    override init() {
        super.init()
        
        tickTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] (t) in
            self?.tickColor()
        }
        
        self.tickColor()
    }
    
    private func tickColor() {
        colorSubject.onNext(colors[colorIndex])
        colorIndex += 1
        colorIndex %= colors.count
        
        tickCount += 1;
        if tickCount >= 5 {
            colorSubject.onCompleted();
        }
    }
    
    func colorObservable() -> Observable<UIColor> {
        return colorSubject.asObservable()
    }
    
    func colorObservation() -> OcObservation {
        return colorSubject.ocObservation()
    }
    
}
