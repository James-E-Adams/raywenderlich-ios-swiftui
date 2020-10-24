//
//  ContentView.swift
//  bullseye
//
//  Created by James Adams on 22/10/20.
//

import SwiftUI

struct ContentView: View {
    
  @State var alertIsVisible = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 1...100)
  
  
  
  var body: some View {
    VStack {
      Spacer()
      // Target row
      
      HStack {
        Text("Put the bullseye as close as you can to:")
        Text("\(target)")
      }.padding()
      Spacer()
      //Slider row
      HStack {
        Text("1")
        Slider(value: $sliderValue, in: 1...100)
        Text("100")
      }
      Spacer()
      //Button row
      Button(action: {
          alertIsVisible = true
      }) {
        Text("Hit me!")
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        let roundedValue = roundedSliderValue()
        return Alert(
          title: Text("Hey hey"),
          message: Text("The slider's value is \(roundedValue).\n" +
                          "You scored \(pointsForCurrentRound()) points this round."
          ),
          dismissButton: .default(Text("awesome"))
        )
      }
      Spacer()
      
      // Score row
      HStack {
        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
          Text("Start over")
        }
        Spacer()
        Text("Score:")
        Text("99999")
        Spacer()
        Text("Round:")
        Text("999")
        Spacer()
        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
          Text("Info")
        }

      }
    }.padding(.all, 20)
  }
   
  func pointsForCurrentRound() -> Int {
    100 - abs(target - roundedSliderValue())
  }
  
  func roundedSliderValue() -> Int {
    Int(sliderValue.rounded())
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 1080, height: 810))
  }
}
