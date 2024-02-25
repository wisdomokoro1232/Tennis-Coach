//
// FYP_1.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class FYP_1Input : MLFeatureProvider {

    /// acceleration_x window input as 120 element vector of doubles
    var acceleration_x: MLMultiArray

    /// acceleration_y window input as 120 element vector of doubles
    var acceleration_y: MLMultiArray

    /// acceleration_z window input as 120 element vector of doubles
    var acceleration_z: MLMultiArray

    /// gyro_x window input as 120 element vector of doubles
    var gyro_x: MLMultiArray

    /// gyro_y window input as 120 element vector of doubles
    var gyro_y: MLMultiArray

    /// gyro_z window input as 120 element vector of doubles
    var gyro_z: MLMultiArray

    /// LSTM state input as 400 element vector of doubles
    var stateIn: MLMultiArray

    var featureNames: Set<String> {
        get {
            return ["acceleration_x", "acceleration_y", "acceleration_z", "gyro_x", "gyro_y", "gyro_z", "stateIn"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "acceleration_x") {
            return MLFeatureValue(multiArray: acceleration_x)
        }
        if (featureName == "acceleration_y") {
            return MLFeatureValue(multiArray: acceleration_y)
        }
        if (featureName == "acceleration_z") {
            return MLFeatureValue(multiArray: acceleration_z)
        }
        if (featureName == "gyro_x") {
            return MLFeatureValue(multiArray: gyro_x)
        }
        if (featureName == "gyro_y") {
            return MLFeatureValue(multiArray: gyro_y)
        }
        if (featureName == "gyro_z") {
            return MLFeatureValue(multiArray: gyro_z)
        }
        if (featureName == "stateIn") {
            return MLFeatureValue(multiArray: stateIn)
        }
        return nil
    }
    
    init(acceleration_x: MLMultiArray, acceleration_y: MLMultiArray, acceleration_z: MLMultiArray, gyro_x: MLMultiArray, gyro_y: MLMultiArray, gyro_z: MLMultiArray, stateIn: MLMultiArray) {
        self.acceleration_x = acceleration_x
        self.acceleration_y = acceleration_y
        self.acceleration_z = acceleration_z
        self.gyro_x = gyro_x
        self.gyro_y = gyro_y
        self.gyro_z = gyro_z
        self.stateIn = stateIn
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    convenience init(acceleration_x: MLShapedArray<Double>, acceleration_y: MLShapedArray<Double>, acceleration_z: MLShapedArray<Double>, gyro_x: MLShapedArray<Double>, gyro_y: MLShapedArray<Double>, gyro_z: MLShapedArray<Double>, stateIn: MLShapedArray<Double>) {
        self.init(acceleration_x: MLMultiArray(acceleration_x), acceleration_y: MLMultiArray(acceleration_y), acceleration_z: MLMultiArray(acceleration_z), gyro_x: MLMultiArray(gyro_x), gyro_y: MLMultiArray(gyro_y), gyro_z: MLMultiArray(gyro_z), stateIn: MLMultiArray(stateIn))
    }

}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class FYP_1Output : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// Activity prediction probabilities as dictionary of strings to doubles
    var labelProbability: [String : Double] {
        return self.provider.featureValue(for: "labelProbability")!.dictionaryValue as! [String : Double]
    }

    /// Class label of top prediction as string value
    var label: String {
        return self.provider.featureValue(for: "label")!.stringValue
    }

    /// LSTM state output as 400 element vector of doubles
    var stateOut: MLMultiArray {
        return self.provider.featureValue(for: "stateOut")!.multiArrayValue!
    }

    /// LSTM state output as 400 element vector of doubles
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    var stateOutShapedArray: MLShapedArray<Double> {
        return MLShapedArray<Double>(self.stateOut)
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(labelProbability: [String : Double], label: String, stateOut: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["labelProbability" : MLFeatureValue(dictionary: labelProbability as [AnyHashable : NSNumber]), "label" : MLFeatureValue(string: label), "stateOut" : MLFeatureValue(multiArray: stateOut)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class FYP_1 {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "FYP 1", withExtension:"mlmodelc")!
    }

    /**
        Construct FYP_1 instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of FYP_1.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `FYP_1.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct FYP_1 instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct FYP_1 instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct FYP_1 instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<FYP_1, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct FYP_1 instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> FYP_1 {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct FYP_1 instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<FYP_1, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(FYP_1(model: model)))
            }
        }
    }

    /**
        Construct FYP_1 instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> FYP_1 {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return FYP_1(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as FYP_1Input

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as FYP_1Output
    */
    func prediction(input: FYP_1Input) throws -> FYP_1Output {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as FYP_1Input
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as FYP_1Output
    */
    func prediction(input: FYP_1Input, options: MLPredictionOptions) throws -> FYP_1Output {
        let outFeatures = try model.prediction(from: input, options:options)
        return FYP_1Output(features: outFeatures)
    }

    /**
        Make an asynchronous prediction using the structured interface

        - parameters:
           - input: the input to the prediction as FYP_1Input
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as FYP_1Output
    */
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
    func prediction(input: FYP_1Input, options: MLPredictionOptions = MLPredictionOptions()) async throws -> FYP_1Output {
        let outFeatures = try await model.prediction(from: input, options:options)
        return FYP_1Output(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - acceleration_x: acceleration_x window input as 120 element vector of doubles
            - acceleration_y: acceleration_y window input as 120 element vector of doubles
            - acceleration_z: acceleration_z window input as 120 element vector of doubles
            - gyro_x: gyro_x window input as 120 element vector of doubles
            - gyro_y: gyro_y window input as 120 element vector of doubles
            - gyro_z: gyro_z window input as 120 element vector of doubles
            - stateIn: LSTM state input as 400 element vector of doubles

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as FYP_1Output
    */
    func prediction(acceleration_x: MLMultiArray, acceleration_y: MLMultiArray, acceleration_z: MLMultiArray, gyro_x: MLMultiArray, gyro_y: MLMultiArray, gyro_z: MLMultiArray, stateIn: MLMultiArray) throws -> FYP_1Output {
        let input_ = FYP_1Input(acceleration_x: acceleration_x, acceleration_y: acceleration_y, acceleration_z: acceleration_z, gyro_x: gyro_x, gyro_y: gyro_y, gyro_z: gyro_z, stateIn: stateIn)
        return try self.prediction(input: input_)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - acceleration_x: acceleration_x window input as 120 element vector of doubles
            - acceleration_y: acceleration_y window input as 120 element vector of doubles
            - acceleration_z: acceleration_z window input as 120 element vector of doubles
            - gyro_x: gyro_x window input as 120 element vector of doubles
            - gyro_y: gyro_y window input as 120 element vector of doubles
            - gyro_z: gyro_z window input as 120 element vector of doubles
            - stateIn: LSTM state input as 400 element vector of doubles

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as FYP_1Output
    */

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func prediction(acceleration_x: MLShapedArray<Double>, acceleration_y: MLShapedArray<Double>, acceleration_z: MLShapedArray<Double>, gyro_x: MLShapedArray<Double>, gyro_y: MLShapedArray<Double>, gyro_z: MLShapedArray<Double>, stateIn: MLShapedArray<Double>) throws -> FYP_1Output {
        let input_ = FYP_1Input(acceleration_x: acceleration_x, acceleration_y: acceleration_y, acceleration_z: acceleration_z, gyro_x: gyro_x, gyro_y: gyro_y, gyro_z: gyro_z, stateIn: stateIn)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [FYP_1Input]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [FYP_1Output]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [FYP_1Input], options: MLPredictionOptions = MLPredictionOptions()) throws -> [FYP_1Output] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [FYP_1Output] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  FYP_1Output(features: outProvider)
            results.append(result)
        }
        return results
    }
}
