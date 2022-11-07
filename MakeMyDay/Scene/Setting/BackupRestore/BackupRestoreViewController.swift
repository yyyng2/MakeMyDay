//
//  BackupRestoreViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/05.
//

import UIKit

import RealmSwift

import Zip

class BackupRestoreViewController: BaseViewController {
    let mainView = BackupRestoreView()
    
    let scheduleRepository = ScheduleRepository()
    
    let ddayRepository = DdayRepository()
    
    var scheduleTasks: Results<Schedule>!
    
    var ddayTasks: Results<Dday>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        fetch()
        configureButton()
    }
    
    func configureButton() {
        mainView.backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    func fetch() {
        scheduleTasks = scheduleRepository.fetch()
        ddayTasks = ddayRepository.fetch()
    }
    
    @objc private func backupButtonTapped() {
        do {
            try saveEncodeScheduleToDocument(tasks: scheduleTasks)
            print(1)
            try saveEncodeDdayToDocument(tasks: ddayTasks)
            print(2)
            let backupFilePath = try createBackupFile(fileName: "MMDBackup\(Date().dateFormattedToDateYyyymmddeahhmm())", keyFile: .MakeMyDayKeyFile)
            print(3)
            //fetchBackupFileList()
            try showActivityViewController(backupFileURL: backupFilePath)
           // fetchDocumentZipFile()
        } catch {
            showAlert(title: "zipFailed".localized, message: "", buttonTitle: "okay".localized)
        }
        removeKeyFileDocument(fileName: .MakeMyDayKeyFile)
    }
    
    @objc private func restoreButtonTapped() {
        let alert = UIAlertController(title: "warning".localized, message: "restoreWarning".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "okay".localized, style: .destructive) { [weak self]_ in
                 
                 guard let self = self else { return }
                 
                 guard let path = self.documentDirectoryPath() else {
                     print("도큐먼트 위치에 오류가 있습니다.")
                     return
                 }
                 
                 if FileManager.default.fileExists(atPath: path.path) {
                     
                    do {
                         let doucumentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
                         doucumentPicker.delegate = self
                         doucumentPicker.allowsMultipleSelection = false
                         self.present(doucumentPicker, animated: true)
                    } catch {
                         print("압축풀기에 실패하였습니다")
                     }
                 }
             }
        let cancel = UIAlertAction(title: "cancel".localized, style: .cancel)
             
             alert.addAction(ok)
             alert.addAction(cancel)
             
             present(alert, animated: true)
    }
}

extension BackupRestoreViewController {
    func documentDirectoryPath() -> URL? {
        // 앱의 document 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    
    func createFile(fileName: PathComponentName) -> URL {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("폴더를 생성할 수 없습니다")
            return URL(fileURLWithPath: "") }
        let fileURL = path.appendingPathComponent(fileName.rawValue)
        let myTextString = NSString(string: fileName.rawValue)
    
        do {
            try myTextString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8.rawValue)
        } catch {
            print("=====> 이미지 폴더를 만들 수 없습니다")
        }
        
        return fileURL
    }
    
    func removeKeyFileDocument(fileName: PathComponentName) {
          guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
          let fileURL = documentDirectory.appendingPathComponent(fileName.rawValue)
          
          do {
              try FileManager.default.removeItem(at: fileURL)
          } catch let error {
              showAlert(title: "삭제할 키파일이 없습니다.", message: "", buttonTitle: "okay".localized)
              print(error)
          }
      }
      
      func removeBackupFileDocument(fileName: String) {
          guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
         
          let fileURL = documentDirectory.appendingPathComponent(fileName)
          
          do {
              try FileManager.default.removeItem(at: fileURL)
          } catch let error {
              showAlert(title: "삭제할 백업파일이 없습니다.", message: "", buttonTitle: "okay".localized)
              print(error)
          }
      }
      
      //제이슨 to 데이터
      func scheduleFetchJSONData() throws -> Data {
          guard let path = documentDirectoryPath() else { throw DocumentPathError.fetchBackupFileError }
         
          let scheduleJsonDataPath = path.appendingPathComponent("schedule.json")
          
          do {
              return try Data(contentsOf: scheduleJsonDataPath)
          }
          catch {
              throw DocumentPathError.fetchBackupFileError
          }
      }
      
      //제이슨 to 데이터
      func ddayFetchJSONData() throws -> Data {
          guard let path = documentDirectoryPath() else { throw DocumentPathError.fetchBackupFileError }
         
          let ddayJsonDataPath = path.appendingPathComponent("dday.json")
          
          do {
              return try Data(contentsOf: ddayJsonDataPath)
          }
          catch {
              throw DocumentPathError.fetchBackupFileError
          }
      }
      
      func fetchDocumentZipFile() -> [String] {
          
          do {
              guard let path = documentDirectoryPath() else { return [] } //도큐먼트 경로
              
              let docs =  try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
              
              let zip = docs.filter { $0.pathExtension == "zip" } //확장자
              
              let result = zip.map { $0.lastPathComponent }
   
              
              return result
              
          } catch {
              return []
          }
      }
      
      //파일생성
      func createBackupFile(fileName: String, keyFile: PathComponentName) throws -> URL {
          
          var urlpath = [URL]()
          //도큐먼트트 위치에 백업 파일 확인
          guard let path = documentDirectoryPath() else {
              throw DocumentPathError.directoryPathError
          }
          
          let keyFileURL = createFile(fileName: keyFile)
          let scheduleEncodeFilePath = path.appendingPathComponent("schedule.json")
          let ddayEncodeFilePath = path.appendingPathComponent("dday.json")
          
          guard FileManager.default.fileExists(atPath: scheduleEncodeFilePath.path) && FileManager.default.fileExists(atPath: ddayEncodeFilePath.path), FileManager.default.fileExists(atPath: keyFileURL.path) else {
              throw DocumentPathError.compressionFailedError
          }
          
              urlpath.append(contentsOf: [scheduleEncodeFilePath, ddayEncodeFilePath, keyFileURL])
          
          do {
              let zipFilePath = try Zip.quickZipFiles(urlpath, fileName: "\(fileName)") // 확장자 없으면 저장이 안됨
              print("Archive Lcation: \(zipFilePath.lastPathComponent)")
              return zipFilePath
          } catch {
              throw DocumentPathError.compressionFailedError
          }
      }
      
      //MARK:  인코드
      func encodeSchedule(_ scheduleData: Results<Schedule>) throws -> Data {
          
          do {
              let encoder = JSONEncoder()
              encoder.dateEncodingStrategy = .iso8601
              let encodedData: Data = try encoder.encode(scheduleData)

              return encodedData
          } catch {
              throw CodableError.jsonEncodeError
          }
      }
      

      func encodeDday(_ data: Results<Dday>) throws -> Data {
          do {
              let encoder = JSONEncoder()
              encoder.dateEncodingStrategy = .iso8601
              let encodedData: Data = try encoder.encode(data)
              
              return encodedData
          } catch {
              throw CodableError.jsonEncodeError
          }
      }
      
    //MARK:  디코드
      @discardableResult func decodeSchedule(_ scheduleData: Data) throws -> [Schedule]? {
          
          do {
              let decoder = JSONDecoder()
              decoder.dateDecodingStrategy = .iso8601
              let decodedData: [Schedule] = try decoder.decode([Schedule].self, from: scheduleData)
              
              return decodedData
          } catch {
              throw CodableError.jsonDecodeError
          }
      }
    
      @discardableResult func decodeDday(_ data: Data) throws -> [Dday]? {
          
          do {
              let decoder = JSONDecoder()
              decoder.dateDecodingStrategy = .iso8601
              
              let decodedData: [Dday] = try decoder.decode([Dday].self, from: data)
              
              return decodedData
          } catch {
              throw CodableError.jsonDecodeError
          }
      }
      
      //도큐먼트에 저장
      func saveDataToDocument(data: Data, fileName: String) throws {
          guard let documentPath = documentDirectoryPath() else { throw DocumentPathError.directoryPathError }
          
          let jsonDataPath = documentPath.appendingPathComponent("\(fileName).json")
          try data.write(to: jsonDataPath)
      }
      
      //도큐먼트에 인코드한것 저장하기 위해 준비 - 1
      func saveEncodeScheduleToDocument(tasks: Results<Schedule>) throws {
         
          do {
              let encodedData = try encodeSchedule(tasks)
              try saveDataToDocument(data: encodedData, fileName: "schedule")
          } catch {
              showAlert(title: "encodeFailed".localized, message: "pleaseContact".localized, buttonTitle: "okay".localized)
          }
      }
      
      //도큐먼트에 인코드한것 저장하기 위해 준비 - 2
      func saveEncodeDdayToDocument(tasks: Results<Dday>) throws {
          let encodedData = try encodeDday(tasks)
          try saveDataToDocument(data: encodedData, fileName: "dday")
      }
      
      //복구
      func restoreRealmForBackupFile() throws {
          let scheduleJsonData = try scheduleFetchJSONData()
          let ddayJsonData = try ddayFetchJSONData()
          guard let scheduleDecodedData = try decodeSchedule(scheduleJsonData) else { return }
          guard let ddayDecodedData = try decodeDday(ddayJsonData) else { return }
          
          try scheduleRepository.localRealm.write {
              scheduleRepository.localRealm.add(scheduleDecodedData)
          }
          try ddayRepository.localRealm.write({
              ddayRepository.localRealm.add(ddayDecodedData)
          })
      }
     
      //도큐먼트 피커
      func showActivityViewController(backupFileURL: URL) throws {
          
          let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
          
          self.present(vc, animated: true)
      }
    
    func unzipFile(fileURL: URL, documentURL: URL) throws {
          do {
              try Zip.unzipFile(fileURL, destination: documentURL, overwrite: true, password: nil, progress: { progress in
              }, fileOutputHandler: { unzippedFile in
                  print("압축풀기 완료")
              })
          }
          catch {
              throw DocumentPathError.restoreFailError
          }
      }
    
}

extension BackupRestoreViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        showAlert(title: "", message: "cancelChoose".localized, buttonTitle: "okay".localized)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            showAlert(title: "", message: "cantNotFoundFile".localized, buttonTitle: "okay".localized)
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlert(title: "", message: "locationError".localized, buttonTitle: "okay".localized)
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        //키파일이용 앱의 백업복구 파일과 같은지 비교
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            let filename_zip = selectedFileURL.lastPathComponent
            let zipfileURL = path.appendingPathComponent(filename_zip)
            let keyFileURL = path.appendingPathComponent(PathComponentName.MakeMyDayKeyFile.rawValue)
            
            do {
                scheduleRepository.deleteAll()
                ddayRepository.deleteAll()
                try unzipFile(fileURL: zipfileURL, documentURL: path)
                do {
                    if FileManager.default.fileExists(atPath: keyFileURL.path) {
                        try self.restoreRealmForBackupFile()
                        removeKeyFileDocument(fileName: .MakeMyDayKeyFile)
                        self.tabBarController?.selectedIndex = 0
                    } else {
                        controller.dismiss(animated: true) {
                            let alert = UIAlertController(title: "warning".localized, message: "wrongBackupFile".localized, preferredStyle: .alert)
                            let ok = UIAlertAction(title: "okay".localized, style: .default)
                            self.removeBackupFileDocument(fileName: filename_zip)
                            
                            alert.addAction(ok)
                            self.present(alert, animated: true)
                        }
                    }
                } catch {
                    showAlert(title: "", message: "restoreFailed".localized, buttonTitle: "okay".localized)
                }
            } catch {
                showAlert(title: "", message: "unzipFailed".localized, buttonTitle: "okay".localized)
            }
        } else {
            
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사(at:원래경로, to: 복사하고자하는 경로) / sandboxFileURL -> 걍 경로
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let filename_zip = selectedFileURL.lastPathComponent
                let zipfileURL = path.appendingPathComponent(filename_zip)
                let keyFileURL = path.appendingPathComponent(PathComponentName.MakeMyDayKeyFile.rawValue)
                print(keyFileURL)
                
                do {
                    scheduleRepository.deleteAll()
                    ddayRepository.deleteAll()
                    
                    try unzipFile(fileURL: zipfileURL, documentURL: path)
                    do {
                        if FileManager.default.fileExists(atPath: keyFileURL.path) {
                            try self.restoreRealmForBackupFile()
                            self.tabBarController?.selectedIndex = 0
                            removeKeyFileDocument(fileName: .MakeMyDayKeyFile)
                        } else {
                            controller.dismiss(animated: true) {
                                let alert = UIAlertController(title: "warning".localized, message: "wrongBackupFile".localized, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "okay".localized, style: .default)
                                alert.addAction(ok)
                                self.removeBackupFileDocument(fileName: filename_zip)
                                self.present(alert, animated: true)
                            }
                        }
                    } catch {
                        showAlert(title: "", message: "restoreFailed".localized, buttonTitle: "okay".localized)
                    }
                } catch {
                    showAlert(title: "", message: "unzipFailed".localized, buttonTitle: "okay".localized)
                }
            } catch {
                showAlert(title: "", message: "unzipFailed".localized, buttonTitle: "okay".localized)
            }
        }
    }
}
