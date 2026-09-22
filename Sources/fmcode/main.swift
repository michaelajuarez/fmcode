import Foundation
import FoundationModels

let model = SystemLanguageModel.default

guard case .available = model.availability else {
  print("Model isn't available: \(model.availability)")
  exit(1)
}

let session = LanguageModelSession(
  instructions: "You are a terse, helpful coding assistant. Ask follow up questions if necessary."
)

let response = try await session.respond(to: "Say hello in one sentence.")
print(response.content)

