//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    let devices: [DeviceData]
    let onSelect: (DeviceData) -> Void // Callback for item selection
    
    @State private var searchText: String = ""
    @State private var filteredDevices: [DeviceData] = []

    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding()
                .onChange(of: searchText) { oldValue, newValue in
                    if !newValue.isEmpty {
                        filteredDevices = devices.filter({ deviceData in
                            deviceData.name.lowercased().hasPrefix(newValue.lowercased())
                        })
                    } else {
                        filteredDevices = devices
                    }
                }
            
            if !filteredDevices.isEmpty {
                List(filteredDevices) { device in
                    Button {
                        onSelect(device)
                    } label: {
                        VStack(alignment: .leading) {
                            AssignmentText(text: device.name)
                        }
                    }
                }
            } else {
                Text("No Device Found!")
            }
        }
        .onAppear {
            filteredDevices = devices
        }
    }
}
