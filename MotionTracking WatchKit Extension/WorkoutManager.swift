/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This class manages the HealthKit interactions and provides a delegate 
         to indicate changes in data.
 */

import Foundation
import HealthKit

/**
 `WorkoutManagerDelegate` exists to inform delegates of swing data changes.
 These updates can be used to populate the user interface.
 */
protocol WorkoutManagerDelegate: AnyObject {
    func didUpdateMotion(_ manager: WorkoutManager, gravityStr: String, rotationRateStr: String, userAccelStr: String)
    func didUpdateshotCount(_ manager: WorkoutManager, shotCount: Int, ArrayOfSampleData:String)
}

class WorkoutManager: MotionManagerDelegate {
    
    // MARK: Properties
    
    let motionManager = MotionManager()
    let healthStore = HKHealthStore()

    weak var delegate: WorkoutManagerDelegate?
    var session: HKWorkoutSession?

    
    // MARK: Initialization
    
    init() {
        motionManager.delegate = self
    }

    
    // MARK: WorkoutManager
    
    func startWorkout() {
        // If we have already started the workout, then do nothing.
        if (session != nil) {return}

        // Configure the workout session.
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .cricket
        workoutConfiguration.locationType = .outdoor

        do {
            let sampleType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
            session = try HKWorkoutSession(healthStore: healthStore, configuration: workoutConfiguration)
            healthStore.enableBackgroundDelivery(for: sampleType!, frequency: .immediate, withCompletion: {(succeeded: Bool, error: Error!) in
                if succeeded {
                    print("Enabled background delivery")
                }
                else {
                    if let theError = error {
                        print("Error = \(theError)")
                    }
                }
            } as (Bool, Error?) -> Void)
        }
        catch {fatalError("Unable to create the workout session!")}

        // Start the workout session and device motion updates.
        // healthStore.start(session!)
        session!.startActivity(with: Date())
        motionManager.startUpdates()
    }

    func stopWorkout() {
        // If we have already stopped the workout, then do nothing.
        if (session == nil) {return}

        // Stop the device motion updates and workout session.
        motionManager.stopUpdates()
        session!.end()
        // healthStore.end(session!)

        // Clear the workout session.
        session = nil
    }

    // MARK: MotionManagerDelegate
    
    func didUpdateMotion(_ manager: MotionManager, gravityStr: String, rotationRateStr: String, userAccelStr: String) {
        delegate?.didUpdateMotion(self, gravityStr: gravityStr, rotationRateStr: rotationRateStr, userAccelStr: userAccelStr)
    }
    
    func didUpdateshotCount(_ manager: MotionManager, shotCount: Int, ArrayOfSampleData: String) {
        delegate?.didUpdateshotCount(self, shotCount: shotCount, ArrayOfSampleData: ArrayOfSampleData)
    }
}
