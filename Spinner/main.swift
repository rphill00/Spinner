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
func randomNumberGenerator(maxNumber: Int) -> Int {
    let randomNumber = Int.random(in: 1 ... maxNumber)
    return randomNumber
}

func spinWheel(strengthFactor: Int, start: Int) -> Int {
    // return a random number multiplied by the strengthFactor
    let distance = randomNumberGenerator(maxNumber: 360) * strengthFactor
    print ("Distance from original spot: \(distance)")
    let finalSpot = start + distance
    return finalSpot
}

// Variable declaration
var bContinue = false
var strength = 1
var spotOnWheel = 0
var numberOfLoops = 0
var spinAgain = "n"
var position = 0
var numOfSections = 5
// Will need to pick how many sections are on the wheel
// 360/<number> = <number of pies>

print ("How many sections are on the wheel? (Default is 5)")
if let inputSections = Int(readLine()!){
    numOfSections = inputSections
}

print ("We'll be using \(numOfSections) sections")

// Calculate the lines for the sections
let breakPoint = 360/numOfSections

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

print ("Breakpoint: \(breakPoint)")

// define Array with length = # of breakpoints

var arrBreakPoints = [Int]()

for index in 0...numOfSections - 1 {
    arrBreakPoints.insert((index + 1) * breakPoint, at: index)
}

for item in arrBreakPoints {
    print ("stop: \(item)")
}

// The spinner is randomly sitting on a spot
let randomStart = randomNumberGenerator(maxNumber: 360)

// Let the fun begin
position = randomStart

repeat {
    print ("Let the fun begin!")
    print ("Starting spot: \(position)")
    
    // Now spin the wheel
    // Strength will be a factor in how far the wheel spins
    //strength = randomNumberGenerator(maxNumber: 5)
    print ("How hard to spin (1 - 5)? (1 being not hard)")
    if let inputStrength = Int(readLine()!){
        strength = inputStrength
    }
    print ("Strength: \(strength)")
    
    spotOnWheel = spinWheel(strengthFactor: Int(strength), start: position)
    print ("New location: \(spotOnWheel)")
    if (spotOnWheel > 360) {
        // can determine how many loops
        // and end location of spinner
        numberOfLoops = spotOnWheel/360
        print ("Number of Loops: \(numberOfLoops)")
        spotOnWheel = spotOnWheel%360
    }
    
    print ("Location on wheel after spin: \(spotOnWheel)")
    // Determine which section it's in
    
    var sectionMarker = 0
    
    // Loop through and find the section the spinner landed in
    for index in (0...(arrBreakPoints.count - 1)).reversed(){
        print ("spotOnWheel: \(spotOnWheel)")
        print ("arrBreakPoints[index]: \(arrBreakPoints[index])")
        if spotOnWheel < arrBreakPoints[index]{
            sectionMarker = index + 1
            print ("check: \(index)")
        }else{
            break
        }
    }
    
    print ("Section on the wheel: \(sectionMarker)")
    
    position = spotOnWheel
    
    // need to add a loop to keep playing.  Mark the spot on the wheel and spin again
    
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
