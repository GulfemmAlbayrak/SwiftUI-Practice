//
//  MapView.swift
//  DunyaGezgini
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    static var regions: [MKCoordinateRegion] = [
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.0, longitude: 29.0),
            span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        ),
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.59, longitude: -0.12),
            span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        )
        
    ]
    
    @State var region: MKCoordinateRegion = regions[0]
    @State var selectedIndex = 0
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.top)
            .overlay{
            
                VStack {
                    Picker("Picker",selection: $selectedIndex, content: {
                        Text("MAP_CITY_ISTANBUL").tag(0)
                        Text("MAP_CITY_LONDON").tag(1)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedIndex, perform: { value in
                        self.region = MapView.regions[selectedIndex]
                    })
                    Spacer()
                }
            }
    }
}

#Preview {
    MapView()
}
