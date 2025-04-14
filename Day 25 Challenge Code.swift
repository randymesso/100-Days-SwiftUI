import SwiftUI

struct ContentView: View {
    
    @State private var navigateToGame = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(red: 0.74, green: 0.8, blue: 0.48)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Can you beat the computer at ")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                    Text("Rock, paper, scissors?")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                    
                    Button("Play!") {
                        navigateToGame = true
                    }
                    .padding()
                    .background(Color(red: 255/255, green: 174/255, blue: 66/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .navigationDestination(isPresented: $navigateToGame) {
                    GameView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        
    }
}

struct GameView: View
{
    let decision = ["WIN!", "LOSE!"]
    
    let images = ["🪨", "📄","✂️"]
    
    @State private var computerChoice: Int = Int.random(in: 0...2)
    @State private var outcomeChoice: Int = Int.random(in: 0...1)
    @State private var score: Int = 0
    @State private var rounds: Int = 0
    @State private var endOfGame: Bool = false
    @State private var selectedChoice: String? = nil
    
    @State private var animateScore = false
    @State private var shakeScore = false
    @State private var scoreColor: Color = .primary
    @State private var animateIn = false
    @State private var animateChoice: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.74, green: 0.8, blue: 0.48)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("Match the condition to the desired outcome")
                        .font(.system(size: 50))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .offset(x: animateIn ? 0 : -UIScreen.main.bounds.width)
                        .animation(.easeOut(duration: 0.6), value: animateIn)
                    
                    HStack(spacing: 70) {
                        Text("\(images[computerChoice])")
                            .font(.system(size: 60))
                            .offset(x: animateIn ? 0 : -UIScreen.main.bounds.width)
                            .animation(.easeOut(duration: 0.6).delay(0.2), value: animateIn)
                        
                        Text("\(decision[outcomeChoice])")
                            .font(.system(size: 50))
                            .foregroundStyle(.black)
                            .padding()
                            .background(decision[outcomeChoice] == "WIN!" ? .blue : .red)
                            .cornerRadius(10)
                            .offset(x: animateIn ? 0 : UIScreen.main.bounds.width)
                            .animation(.easeOut(duration: 0.6).delay(0.2), value: animateIn)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    HStack(spacing: 30) {
                        ForEach(images, id: \.self) { index in
                            Button {
                                selectedChoice = index
                                animateChoice = true
                                decideOutcome(choice: index)
                                
                                // Reset after animation
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    animateChoice = false
                                }
                            } label: {
                                Text(index)
                                    .font(.system(size: 80))
                                    .scaleEffect(selectedChoice == index && animateChoice ? 1.2 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.4), value: animateChoice)
                            }
                            .offset(y: animateIn ? 0 : 200)
                            .animation(.easeOut(duration: 0.6).delay(0.4), value: animateIn)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .foregroundStyle(scoreColor)
                        .scaleEffect(animateScore ? 1.5 : 1.0)
                        .offset(x: shakeScore ? -10 : 0)
                        .offset(x: animateIn ? 0 : UIScreen.main.bounds.width)
                        .animation(.easeOut(duration: 0.6).delay(0.6), value: animateIn)
                        .animation(shakeScore ? .default.repeatCount(3, autoreverses: true) : .spring(response: 0.3, dampingFraction: 0.4), value: shakeScore)
                        .animation(.spring(response: 0.3, dampingFraction: 0.4), value: animateScore)
                }
            }
            .onAppear {
                animateIn = true
            }
            .navigationDestination(isPresented: $endOfGame) {
                GameOverView(score: score)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    func decideOutcome(choice: String) {
        if choice ==  images[computerChoice] {
            nextRound()
        }
        else if (images[computerChoice] == "🪨" && decision[outcomeChoice] == "WIN!" && choice == "📄" || images[computerChoice] == "🪨" && decision[outcomeChoice] == "LOSE!" && choice == "✂️") {
            withAnimation {
                score += 1
                animateScore = true
                scoreColor = .green
            }
            resetColor()
            resetAnimation()
            nextRound()
        }
        else if (images[computerChoice] == "📄" && decision[outcomeChoice] == "WIN!" && choice == "✂️" || images[computerChoice] == "📄" && decision[outcomeChoice] == "LOSE!" && choice == "🪨") {
            withAnimation {
                score += 1
                animateScore = true
                scoreColor = .green
            }
            resetColor()
            resetAnimation()
            nextRound()
        }
        else if (images[computerChoice] == "✂️" && decision[outcomeChoice] == "WIN!" && choice == "🪨" || images[computerChoice] == "✂️" && decision[outcomeChoice] == "LOSE!" && choice == "📄") {
            withAnimation {
                score += 1
                animateScore = true
                scoreColor = .green
            }
            resetColor()
            resetAnimation()
            nextRound()
        }
        else {
            score -= 1
            withAnimation {
                shakeScore = true
                scoreColor = .red
            }
            resetShake()
            resetColor()
            nextRound()
        }
    }
    
    func nextRound() {
        computerChoice = Int.random(in: 0...2)
        outcomeChoice = Int.random(in: 0...1)
        rounds += 1
        
        if rounds == 10 {
            endOfGame = true
        }
    }
    func resetAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            animateScore = false
        }
    }
    
    func resetShake() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            shakeScore = false
        }
    }
    
    func resetColor() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            scoreColor = .primary
            animateScore = false
        }
    }
}

struct GameOverView: View {
    @State private var newGame = false
    var score: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.74, green: 0.8, blue: 0.48)
                    .ignoresSafeArea()
                
                VStack {
                    if score > 9 {
                        Text("Perfect Score!")
                            .foregroundStyle(.black)
                    }
                    else if score > 5 {
                        Text("Working on it! You're almost there!")
                            .foregroundStyle(.black)
                    }
                    else {
                        Text("Need some more practice!")
                            .foregroundStyle(.black)
                    }
                    Text("You got \(score) correct")
                        .foregroundStyle(.black)
                    Button("Play Again!") {
                        newGame = true
                    }
                    .padding()
                    .background(Color(red: 255/255, green: 174/255, blue: 66/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .navigationDestination(isPresented: $newGame) {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
