//
//  ContentView.swift
//  unitConverter
//
//  Created by aayansh singh on 18/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedInput : Dimension = UnitLength.meters
    @State private var selectedOutput: Dimension = UnitLength.kilometers
    @State private var inputValue = 0.0
    @State private var selectedUnit = 0
    @FocusState private var inputIsFocused: Bool
    
    let conversion = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles,
         UnitLength.yards],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
        
    ]
    
    let formatter: MeasurementFormatter
    
    
    var result: String{
        let inputMeasurement = Measurement(value: inputValue, unit: selectedInput)
        let outputMeasurement = inputMeasurement.converted(to: selectedOutput)
        
        return formatter.string(from: outputMeasurement)
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    
                    TextField("Enter value", value: $inputValue, format: .number).keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                }header: {
                    Text("Enter the input value")
                }
                
                Picker("Conversion", selection: $selectedUnit) {
                    ForEach(0..<conversion.count, id: \.self){
                        Text(conversion[$0])
                    }
                    
                }
                
                
                Picker("Input Unit", selection:
                        $selectedInput) {
                    ForEach (unitTypes[selectedUnit], id: \.self) {
                        Text (formatter.string(from: $0).capitalized)
                    }
                }
                
                Picker("Output Unit", selection:
                        $selectedOutput) {
                    ForEach (unitTypes[selectedUnit], id: \.self) {
                        Text (formatter.string(from: $0).capitalized)
                    }
                }
                
                Section{
                    
                    Text(result)
                }header: {
                    Text("Result")
                }
                
            }.navigationTitle("Distance Converter")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        
                        Button("Done"){
                            inputIsFocused = false
                            
                        }
                    }
                }
                .onChange(of: selectedUnit) { newSelection in
                    let units = unitTypes[newSelection]
                    selectedInput = units[0]
                    selectedOutput = units[1]
                    
                }
        }
    }
    init(){
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

