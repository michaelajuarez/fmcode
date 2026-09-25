import Foundation
import FoundationModels

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
    // let items = try FileManager.default.contents(atPath: url.path)
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
  }

  func call(arguments: Arguments) async throws -> String{
    let url = URL(fileURLWithPath: arguments.path)
    let handle = try FileHandle.init(forReadingFrom: url)
    print(handle)
    return ""
  }
}