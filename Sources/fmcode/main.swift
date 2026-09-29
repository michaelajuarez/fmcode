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

while (true) {
  print("> ", terminator: "")
  guard let raw = readLine() else {
    break
  }
  let current = raw.trimmingCharacters(in: .whitespacesAndNewlines)
  if current == "" {
    continue
  }
  if current == "/exit" || current == "/quit" {
    break
  }
  do {
    let response = try await session.respond(to: current)
    print(response.content)
  } catch {
    print(error)
  }
}