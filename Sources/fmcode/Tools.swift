import Foundation
import FoundationModels

struct CheckType: Tool {
  let name = "check_type"
  let description = "Check the type of a given path, either a file or a directory."

  @Generable
  struct Arguments {
    @Guide(description: "Path to file/directory, undetermined.")
    var path: String
  }

  func call(arguments: Arguments) async throws -> String {
    let url = URL(fileURLWithPath: arguments.path)
    let vals = try url.resourceValues(forKeys: [.isDirectoryKey])
    if (vals.isDirectory == true) {
      return "directory"
    }
    return "file"
  }
}

struct ListDirectoryTool: Tool {
  let name = "list_directory"
  let description = "List files and directories at any given path."

  @Generable
  struct Arguments {
    @Guide(description: "Directory path, relative to the current working directory.")
    var path: String
  }

  func call(arguments: Arguments) async throws -> String {
    let url = URL(fileURLWithPath: arguments.path)
    let items = try FileManager.default.contentsOfDirectory(atPath: url.path).sorted()
    return items.joined(separator: "\n")
  }
}

struct ReadFileTool: Tool {
  let name = "read_file"
  let description = "Reads a given file."

  @Generable
  struct Arguments {
    @Guide(description: "File path, relative to the current working directory.")
    var path: String
  }

  func call(arguments: Arguments) async throws -> String {
    let url = URL(fileURLWithPath: arguments.path)
    let retVar = try String(contentsOf: url, encoding: .utf8)
    return retVar
  }
}

struct WriteFileTool: Tool {
  let name = "write_file"
  let description = "Writes to a given file."

  @Generable
  struct Arguments {
    @Guide(description: "File path to write to, relative to the current working directory.")
    var path: String
    @Guide(description: "Text to write to the file, follow the directions given.")
    var textToWrite: String
  }

  func call(arguments: Arguments) async throws -> String {
    let url = URL(fileURLWithPath: arguments.path)
    try arguments.textToWrite.write(to: url, atomically: true, encoding: .utf8)
    return arguments.textToWrite
  }
}