import SwiftUI

struct ContentView: View {
    @State private var calculationPref = "Temp"
    @State private var inputValue: Double = 0
    @State private var selectedInputUnit = ""
    @State private var selectedOutputUnit = ""
    @State private var convertedValue: Double = 0
    @State private var hasConverted = false
    
    // Define all unit arrays
    private let tempUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    private let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    private let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    private let volumeUnits = ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    
    private var preferences = ["Temp", "Length", "Time", "Volume"]
    
    // Computed property to get the current array based on selected category
    private var currentUnits: [String] {
        switch calculationPref {
        case "Temp": return tempUnits
        case "Length": return lengthUnits
        case "Time": return timeUnits
        case "Volume": return volumeUnits
        default: return []
        }
    }
    
    var body: some View {
        VStack {
            Text("Convert It")
                .font(.system(size: 60))
                .padding(.bottom)
            
            Picker("Category", selection: $calculationPref) {
                ForEach(preferences, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: calculationPref) { newValue in
                // Reset selected units when category changes
                if !currentUnits.isEmpty {
                    selectedInputUnit = currentUnits[0]
                    selectedOutputUnit = currentUnits[0]
                }
                hasConverted = false
            }
            
            Form {
                Section {
                    HStack {
                        TextField("Value", value: $inputValue, format: .number)
                            .keyboardType(.decimalPad)
                            .onChange(of: inputValue) { _ in
                                hasConverted = false
                            }
                        
                        Picker("From", selection: $selectedInputUnit) {
                            ForEach(currentUnits, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.menu)
                        .onAppear {
                            // Set initial value
                            if selectedInputUnit.isEmpty && !currentUnits.isEmpty {
                                selectedInputUnit = currentUnits[0]
                            }
                        }
                        .onChange(of: selectedInputUnit) { _ in
                            hasConverted = false
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text(hasConverted ? "\(convertedValue, specifier: "%.2f")" : "Press Convert!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("To", selection: $selectedOutputUnit) {
                            ForEach(currentUnits, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.menu)
                        .onAppear {
                            // Set initial value
                            if selectedOutputUnit.isEmpty && !currentUnits.isEmpty {
                                selectedOutputUnit = currentUnits[1]
                            }
                        }
                        .onChange(of: selectedOutputUnit) { _ in
                            hasConverted = false
                        }
                    }
                }
            }
            
            Button("Convert!") {
                convertedValue = convert(value: inputValue, from: selectedInputUnit, to: selectedOutputUnit)
                hasConverted = true
                print("Converting \(inputValue) from \(selectedInputUnit) to \(selectedOutputUnit), to get: \(convertedValue)")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
        }
        .onAppear {
            // Initialize default values
            if selectedInputUnit.isEmpty && !currentUnits.isEmpty {
                selectedInputUnit = currentUnits[0]
            }
            if selectedOutputUnit.isEmpty && !currentUnits.isEmpty {
                selectedOutputUnit = currentUnits.count > 1 ? currentUnits[1] : currentUnits[0]
            }
        }
    }
    
    private func convert(value: Double, from inputUnit: String, to outputUnit: String) -> Double {
        // First convert to base unit, then to target unit
        
        // Temperature conversions
        if calculationPref == "Temp" {
            // First convert to Celsius (our base unit for temperature)
            var celsius: Double
            
            switch inputUnit {
            case "Celsius":
                celsius = value
            case "Fahrenheit":
                celsius = (value - 32) * 5/9
            case "Kelvin":
                celsius = value - 273.15
            default:
                return value
            }
            
            // Then convert from Celsius to target unit
            switch outputUnit {
            case "Celsius":
                return celsius
            case "Fahrenheit":
                return celsius * 9/5 + 32
            case "Kelvin":
                return celsius + 273.15
            default:
                return celsius
            }
        }
        
        // Length conversions
        else if calculationPref == "Length" {
            // First convert to meters (our base unit for length)
            var meters: Double
            
            switch inputUnit {
            case "Meters":
                meters = value
            case "Kilometers":
                meters = value * 1000
            case "Feet":
                meters = value * 0.3048
            case "Yards":
                meters = value * 0.9144
            case "Miles":
                meters = value * 1609.34
            default:
                return value
            }
            
            // Then convert from meters to target unit
            switch outputUnit {
            case "Meters":
                return meters
            case "Kilometers":
                return meters / 1000
            case "Feet":
                return meters / 0.3048
            case "Yards":
                return meters / 0.9144
            case "Miles":
                return meters / 1609.34
            default:
                return meters
            }
        }
        
        // Time conversions
        else if calculationPref == "Time" {
            // First convert to seconds (our base unit for time)
            var seconds: Double
            
            switch inputUnit {
            case "Seconds":
                seconds = value
            case "Minutes":
                seconds = value * 60
            case "Hours":
                seconds = value * 3600
            case "Days":
                seconds = value * 86400
            default:
                return value
            }
            
            // Then convert from seconds to target unit
            switch outputUnit {
            case "Seconds":
                return seconds
            case "Minutes":
                return seconds / 60
            case "Hours":
                return seconds / 3600
            case "Days":
                return seconds / 86400
            default:
                return seconds
            }
        }
        
        // Volume conversions
        else if calculationPref == "Volume" {
            // First convert to milliliters (our base unit for volume)
            var milliliters: Double
            
            switch inputUnit {
            case "Milliliters":
                milliliters = value
            case "Liters":
                milliliters = value * 1000
            case "Cups":
                milliliters = value * 236.588
            case "Pints":
                milliliters = value * 473.176
            case "Gallons":
                milliliters = value * 3785.41
            default:
                return value
            }
            
            // Then convert from milliliters to target unit
            switch outputUnit {
            case "Milliliters":
                return milliliters
            case "Liters":
                return milliliters / 1000
            case "Cups":
                return milliliters / 236.588
            case "Pints":
                return milliliters / 473.176
            case "Gallons":
                return milliliters / 3785.41
            default:
                return milliliters
            }
        }
        
        return value // Return original value if no conversion was done
    }
}

#Preview {
    ContentView()
}
