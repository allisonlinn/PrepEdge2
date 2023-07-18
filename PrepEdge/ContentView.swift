import SwiftUI

struct InvestmentBankingQuestion {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
}

struct ContentView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedOptionIndex = -1
    @State private var isAnswerCorrect = false
    @State private var isQuizComplete = false

    let investmentBankingQuestions: [InvestmentBankingQuestion] = [
        InvestmentBankingQuestion(text: "What kind of strategy is a leveraged buyout?", options: [
            "A. A company acquires another company using borrowed money and a small amount of equity.",
            "B. A company acquires another company using its own cash reserves.",
            "C. A company acquires another company by issuing new shares of stock.",
            "D. A company acquires another company using government grants."
        ], correctAnswerIndex: 0),
        // Add more investment banking questions...
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Question: \(investmentBankingQuestions[currentQuestionIndex].text)")
                    .font(.custom("Arial", size: 24))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                ForEach(0..<investmentBankingQuestions[currentQuestionIndex].options.count) { index in
                    Button(action: {
                        handleOptionSelection(index)
                    }) {
                        Text(investmentBankingQuestions[currentQuestionIndex].options[index])
                            .font(.custom("Helvetica", size: 20))
                            .foregroundColor(index == selectedOptionIndex ? .white : .primary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(index == selectedOptionIndex ? (isAnswerCorrect ? Color.green : Color.red) : Color.blue)
                            .cornerRadius(10)
                    }
                }

                NavigationLink(destination: Page2(), isActive: $isQuizComplete) {
                    EmptyView()
                }
                .hidden()

                Button(action: {
                    nextQuestion()
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .disabled(isQuizComplete)
            }
            .padding()
            .navigationTitle("Investment Banking Quiz")
        }
    }

    private func handleOptionSelection(_ index: Int) {
        selectedOptionIndex = index
        isAnswerCorrect = (index == investmentBankingQuestions[currentQuestionIndex].correctAnswerIndex)
    }

    private func nextQuestion() {
        if currentQuestionIndex < investmentBankingQuestions.count - 1 {
            currentQuestionIndex += 1
            selectedOptionIndex = -1
            isAnswerCorrect = false
        } else {
            isQuizComplete = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Page2: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Congratulations!")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text("You completed the Investment Banking Quiz!")
                .font(.headline)
                .padding()

            Button(action: {
                // Handle action to go back or perform other actions
            }) {
                Text("Go Back")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}
