import Foundation

func writeBuffer(_ buffer: [UInt8], toOutputStream outputStream: OutputStream) throws {
  var buffer = buffer
  var bytesToWrite = buffer.count

  while bytesToWrite > 0 {
    if outputStream.hasSpaceAvailable {
      let bytesWritten = outputStream.write(buffer, maxLength: bytesToWrite)

      if let streamError = outputStream.streamError {
        throw streamError
      }

      if bytesWritten < 0 {
        debugPrint("failed to write to output stream")
        throw StreamError.outputStreamWriteFailed
      }

      bytesToWrite -= bytesWritten

      if bytesToWrite > 0 {
        buffer = Array(buffer[bytesWritten..<buffer.count])
      }
    } else if let streamError = outputStream.streamError {
      throw streamError
    }
  }
}
