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
  @State var totalScore = 0
  @State var currentRound = 1
  
  let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
  
  struct ShadowStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .shadow(color: Color.black, radius: 5, x: 2, y:2 )
    }
  }
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .modifier(ShadowStyle())
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
  
  struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .modifier(ShadowStyle())
        .foregroundColor(Color.yellow)
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
    }
  }
  
  struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
  
  struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 12))
    }
  }
  var body: some View {
    VStack {
      Spacer()
      // Target row
      
      HStack {
        Text("Put the bullseye as close as you can to:")
          .modifier(LabelStyle())
        Text("\(target)").modifier(ValueStyle())
      }
      .padding()

      Spacer()
      //Slider row
      HStack {
        Text("1").modifier(ValueStyle())
        Slider(value: $sliderValue, in: 1...100)
        Text("100").modifier(ValueStyle())
      }
      Spacer()
      //Button row
      Button(action: {
        alertIsVisible = true
      }) {
        Text("Hit me!").modifier(ButtonLargeTextStyle())
      }
      .background(Image("Button"))
      .modifier(ShadowStyle())
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        let roundedValue = roundedSliderValue()
        return Alert(
          title: Text(getAlertTitle()),
          message: Text("The slider's value is \(roundedValue).\n" +
                          "You scored \(pointsForCurrentRound()) points this round."
          ),
          dismissButton: .default(Text("awesome")) {
            addScore()
            beginNewRound()
          }
          
        )
      }
      
      Spacer()
      
      // Score row
      HStack {
        Button(action: {
          startOver()
        }) {
          HStack {
            Image("StartOverIcon")
            Text("Start over").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("Button"))
        .modifier(ShadowStyle())
        Spacer()
        Text("Score:").modifier(LabelStyle())
        Text("\(totalScore)").modifier(ValueStyle())
        Spacer()
        Text("Round:").modifier(LabelStyle())
        Text("\(currentRound)").modifier(ValueStyle())
        Spacer()
        NavigationLink(destination: AboutView() ) {
          HStack {
            Image("InfoIcon")
            Text("Info").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("Button"))
        .modifier(ShadowStyle())

      }.padding(.horizontal, 40)
    }
    .padding(.all, 20)
    .background(Image("Background").resizable())
    .accentColor(midnightBlue)
    .navigationBarTitle("Bullseye")
  }
   
  func pointsForCurrentRound() -> Int {
    var score = 100 - abs(target - roundedSliderValue())
    if score == 100 {
      score += 100
    }
    if score == 99 {
      score += 50
    }
    return score
  }
  
  
  
  func roundedSliderValue() -> Int {
    Int(sliderValue.rounded())
  }
  
  func addScore() {
    totalScore +=  pointsForCurrentRound()
  }
  
  func beginNewRound() {
    target = Int.random(in: 1...100)
    currentRound+=1
  }
  
  func startOver() {
    totalScore = 0
    currentRound = 1
    target = Int.random(in: 1...100)
    sliderValue = 50
  }
  
  //Too lazy so this calculates from points including bonuses
  func getAlertTitle() -> String {
    let points = pointsForCurrentRound()
    if points == 200 {
      return "Perfect!"
    } else if points > 100 {
      return "Close!"
    } else if points > 90 {
      return "Not bad."
    } else {
      return "Are you even trying?"
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 1080, height: 810))
  }
}
