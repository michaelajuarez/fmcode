import Foundation
import FoundationModels

let model = SystemLanguageModel.default

guard case .available = model.availability else {
  print("Model isn't available: \(model.availability)")
  exit(1)
}

let session = LanguageModelSession(
  tools: [ListDirectoryTool(), ReadFileTool(), WriteFileTool(), CheckType()],
  instructions: "You are a terse, helpful coding assistant. Ask follow up questions if necessary."
)

var response = try await session.respond(to: "What files are currently in the directory?")
print(response.content)

// response = try await session.respond(to: "Read the python file.")
// print(response.content)

// response = try await session.respond(to: "Write FizzBizz in C in a new file please!")
// print(response.content)

// response = try await session.respond(to: "Read the newly created file.")
// print(response.content)

response = try await session.respond(to: "Is the foo thing in the directory a file or a directory?")
print(response.content)