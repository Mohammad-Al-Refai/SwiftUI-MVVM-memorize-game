//
//  WaitFor.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/5/24.
//

import Foundation

func waitFor(sec: Double, excute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + sec, execute: excute)
}
