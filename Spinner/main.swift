//
//  main.swift
//  Spinner
//
//  Created by Richard on 5/9/19.
//  Copyright © 2019 RP. All rights reserved.
//

import Foundation

// start the spinner on either random number
// between 1-360
// or on 0 (=360)

// pick a random number
// between 1 and 360
func randomNumberGenerator(maxNumber: Double) -> Double {
    let randomNumber = Double.random(in: 1 ... maxNumber)
    return randomNumber
}

func spinWheel(strengthFactor: Int, start: Double) -> Double {
    // return a random number multiplied by the strengthFactor
    let distance: Double = randomNumberGenerator(maxNumber: 360) * Double(strengthFactor)
    print ("Distance from original spot: \(String(format: "%0.02f", distance))")
    let finalSpot = start + distance
    return finalSpot
}

// Variable declaration
var bContinue: Bool = false
var numOfSections: Double = 5
var position: Double = 0
var strength: Int = 1
var spotOnWheel: Double = 0
var numberOfLoops: Int = 0
var spinAgain: String = "n"

// Will need to pick how many sections are on the wheel
// 360/<number> = <number of pies>

print ("How many sections are on the wheel? (Default is 5)")
if let inputSections = Int(readLine()!){
    numOfSections = Double(inputSections)
}

print ("We'll be using \(String(format: "%0.0f", numOfSections)) sections")

// Calculate the lines for the sections
let breakPoint: Double = 360/numOfSections

/*
    Subtract breakPoint from 360 to get
    Repeat
    Ex:
    360-72=288
    288-72=216
    216-72=144
    144-72=72
    72-72=0
*/

print ("Breakpoint: \(String(format: "%0.02f", breakPoint))")

// define Array with length = # of breakpoints

var arrBreakPoints = [Double]()

for index in 0...Int(numOfSections - 1) {
    arrBreakPoints.insert(Double((index + 1)) * breakPoint, at: index)
}

/*
for item in arrBreakPoints {
    print ("stop: \(String(format: "%.02f", item))")
}
 */

position = Double(randomNumberGenerator(maxNumber: 360))

repeat {
    print ("Let the fun begin!")
    print ("Starting spot: \(String(format: "%0.02f", position))")
    
    // Now spin the wheel
    // Strength will be a factor in how far the wheel spins
    //strength = randomNumberGenerator(maxNumber: 5)
    print ("How hard to spin (1 - 5)? (1 being not hard)")
    if let inputStrength = Int(readLine()!){
        strength = inputStrength
        
    }
    print ("Strength: \(strength)")
    
    spotOnWheel = spinWheel(strengthFactor: Int(strength), start: position)
    if (spotOnWheel > 360) {
        // can determine how many loops
        // and end location of spinner
        numberOfLoops = Int(spotOnWheel/360)
        print ("Number of Loops: \(numberOfLoops)")
        spotOnWheel = spotOnWheel.truncatingRemainder(dividingBy: 360)
    }
    
    print ("Location on wheel after spin: \(String(format: "%0.02f", spotOnWheel))")
    // Determine which section it's in
    
    var sectionMarker = 0
    
    print ("Section on the wheel: ")
    // Loop through and find the section the spinner landed in
    for index in (0...(arrBreakPoints.count - 1)).reversed(){
        //print ("spotOnWheel: \(spotOnWheel)")
        //print ("Slice of the pie \(index + 1): \(String(format: "%.02f", arrBreakPoints[index]))")
        if Double(spotOnWheel) < arrBreakPoints[index]{
            sectionMarker = index + 1
            print (" \(sectionMarker),", terminator: "")
        }else{
            break
        }
    }
    
    print ("*** \(sectionMarker) ***")
    
    position = Double(spotOnWheel)
    
    print ("Do you want to spin again (y/n)?")
    
    spinAgain = readLine()!
    
    if ((spinAgain.lowercased().starts(with: "y"))){
        bContinue = true
    }else{
        spinAgain = "no"
        bContinue = false
    }
    
    print ("Spin again: \(spinAgain)")
} while bContinue

print ("Thanks for playing!")
