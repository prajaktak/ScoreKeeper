//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var players: [Player] = [
        Player(name: "Elisha", score: 0,color: .random()),
        Player(name: "Andre", score: 0,color: .random()),
        Player(name: "Jasmine", score: 0,color: .random()),
    ]
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Score Keeper")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            NavigationStack{
                List{
                    HStack{
                        Text("Player")
                            .gridColumnAlignment(.leading)
                        Spacer()
                        Text("Score")
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    ForEach($players){$player in
                        HStack {
                            TextField("Name", text: $player.name)
                            Text("\(player.score)")
                            Stepper("\(player.score)") {
                                if player.score < 20{
                                    player.score += 1
                                }
                                
                            } onDecrement: {
                                if player.score > 0{
                                    player.score -= 1
                                }
                            }
                            .labelsHidden()
//                            Stepper("\(player.score)", value: $player.score)
                                
                        }
                        .listRowBackground(player.color)
                        .foregroundStyle(player.color.adaptedTextColor())
                    }
                    .onMove(perform: move)
                }
                .toolbar { EditButton() }
                .padding(.vertical)
            }
            HStack {
                Button("Add player",systemImage: "plus.circle"){
                    players.append(Player(name: "New Player", score: 0,color: Color.random()))
                }
            }
            
            
            Spacer()
        }
        
        .padding()
        Spacer()
    }
    func move(from source: IndexSet, to destination: Int) {
        players.move(fromOffsets: source, toOffset: destination)
    }
}
public extension Color {

    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
    func luminance() -> Double {
            // Convert SwiftUI Color to UIColor
            let uiColor = UIColor(self)
            
            // Extract RGB values
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
            
            // Compute luminance.
            return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }
        
    func isLight() -> Bool {
        return luminance() > 0.5
    }
    
    func adaptedTextColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
}

#Preview {
    ContentView()
}
