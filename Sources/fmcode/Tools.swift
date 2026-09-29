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
  let description = "Reads an existing file and returns its full contents as text. Use this to inspect a file before changing it with edit_file or write_file."

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
  let description = "Creates a new file, or completely overwrites an existing one, with the given text. To change part of an existing file, use edit_file instead."

  @Generable
  struct Arguments {
    @Guide(description: "File path to write to, relative to the current working directory.")
    var path: String
    @Guide(description: "The complete contents the file should have after writing.")
    var textToWrite: String
  }

  func call(arguments: Arguments) async throws -> String {
    let url = URL(fileURLWithPath: arguments.path)
    try arguments.textToWrite.write(to: url, atomically: true, encoding: .utf8)
    return "Wrote \(arguments.textToWrite.count) characters to \(arguments.path)"
  }
}

struct EditFileTool: Tool {
  let name = "edit_file"
  let description = "Replaces one piece of text in an existing file. Use this instead of write_file when changing only part of a file. Call read_file first so oldText is copied exactly. Fails if oldText is not found or appears more than once."

  @Generable
  struct Arguments {
    @Guide(description: "File path to edit, relative to the current working directory.")
    var path: String
    @Guide(description: "The exact text to replace, copied character-for-character from the file, including whitespace and indentation. It must appear exactly once in the file. If it doesn't, include a line or two of surrounding text to make it unique.")
    var oldText: String
    @Guide(description: "The text that replaces oldText. Only that piece is swapped; the rest of the file is left unchanged.")
    var newText: String
  }

  func call(arguments: Arguments) async throws -> String {
    let url = URL(fileURLWithPath: arguments.path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    let count = contents.ranges(of: arguments.oldText).count
    if (count >= 2) {
      return "oldText appears \(count) times. Include more surrounding text so it matches exactly once."
    } else if (count <= 0) {
      return "oldText was not found in the file. Check that it matches exactly, including whitespace."
    }
    let updatedContents = contents.replacingOccurrences(of: arguments.oldText, with: arguments.newText)
    try updatedContents.write(to: url, atomically: true, encoding: .utf8)
    return "Edited \(arguments.path)"
  }
}