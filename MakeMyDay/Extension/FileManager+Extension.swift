//
//  FileManager+Extension.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/05.
//

import Foundation

enum PathComponentName: String {
    case MakeMyDayKeyFile
}

enum CodableError: Error {
    case jsonEncodeError
    case jsonDecodeError
}

enum DocumentPathError: Error {
    case directoryPathError
    case saveImageError
    case removeDirectoryError
    case compressionFailedError
    case fetchBackupFileError
    case restoreFailError
}
