import Foundation
import FoundationModels
import core

struct CheckType: Tool {
  let name = "check_type"
  let description = "Check the type of a given path, either a file or a directory."

  @Generable
  struct Arguments {
    @Guide(description: "Path to file/directory, undetermined.")
    var path: String
  }

  func call(arguments: Arguments) async throws -> String {
    if (!FileManager.default.fileExists(atPath: arguments.path)) {
      return "does_not_exist"
    }
    let url = URL(fileURLWithPath: arguments.path)
    if (isDirectory(url)) {
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
    // var retVal = ""
    let url = URL(fileURLWithPath: arguments.path)
    let items = try FileManager.default.contentsOfDirectory(atPath: url.path).sorted()
    // for item in items { // Imperative Style
    //   let full = url.appendingPathComponent(item)
    //   let vals = try? full.resourceValues(forKeys: [.isDirectoryKey])
    //   if (vals?.isDirectory == true) {
    //     retVal += item
    //     retVal += "/\n"
    //   } else {
    //     retVal += item
    //     retVal += "\n"
    //   }
    // }
    let lines = items.map {item -> String in
      let full = url.appendingPathComponent(item)
      if (isDirectory(full)) {
        return item + "/"
      } else {
        return item
      }
    }
    return lines.joined(separator: "\n")
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

struct EditFileTool: Tool {
  let name = "edit_file"
  let description = "Edits a currently existing file."

  @Generable
  struct Arguments {
    @Guide(description: "File path to edit, relative to the current working directory.")
    var path: String
    @Guide(description: "Old text from file, from the current file path.")
    var oldText: String
    @Guide(description: "Text to write to the file, follow the directions given.")
    var textToWrite: String
  }

  func call(arguments: Arguments) async throws -> String {
    let url = URL(fileURLWithPath: arguments.path)
    try arguments.textToWrite.write(to: url, atomically: true, encoding: .utf8)
    return arguments.textToWrite
  }
}