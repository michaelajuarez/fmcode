import Foundation
import FoundationModels

let model = SystemLanguageModel.default

guard case .available = model.availability else {
  print("Model isn't available: \(model.availability)")
  exit(1)
}

let session = LanguageModelSession(
  tools: [ListDirectoryTool(), ReadFileTool(), WriteFileTool(), CheckType(), EditFileTool()],
  instructions: "You are a terse coding assistant working in the user's current directory. Use your tools to look before you answer: list a directory before guessing what's in it, and read a file before describing or editing it. Never invent file contents. Prefer edit_file for small changes and write_file only for new files or full rewrites. After making a change, say briefly what you changed."
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