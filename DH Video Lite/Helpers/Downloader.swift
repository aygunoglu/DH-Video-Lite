//
//  Downloader.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 3.09.2021.
//

import UIKit

protocol DownloaderDelegate: AnyObject {
    func reloadTableView()
}

class Downloader: NSObject {
    
    weak var delegate: DownloaderDelegate?
    
    lazy var session: URLSession = {
      let configuration = URLSessionConfiguration.default
      
      return URLSession(configuration: configuration,
                        delegate: self,
                        delegateQueue: nil)
    }()
    
    var downloadTask: URLSessionDownloadTask?

    var isDownloading = false
    var progress: String = "%00"
    var resumeData: Data?
    var isPercentageHidden = true
    //private var url: URL

    
    func startDownload(url: URL) {
        downloadTask = session.downloadTask(with: url)
        downloadTask?.resume()
        isDownloading = true
        isPercentageHidden = false
    }
    
    func cancelDownload() {
        downloadTask?.cancel()
        isDownloading = false
        isPercentageHidden = true
        delegate?.reloadTableView()
    }
    
    func pauseDownload() {
        downloadTask?.cancel(byProducingResumeData: { resumeDataOrNil in
            self.resumeData = resumeDataOrNil
        })
        isDownloading = false
        delegate?.reloadTableView()
    }
    
    func resumeDownload() {
        guard let resumeData = self.resumeData else { return }
        let downloadTask = session.downloadTask(withResumeData: resumeData)
        downloadTask.resume()
        self.downloadTask = downloadTask
    }
    
}

extension Downloader: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("download completed")
        guard let httpResponse = downloadTask.response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print ("server error")
            return
        }
        do {
            let documentsURL = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            
            let savedURL = documentsURL.appendingPathComponent(
                "\(randomString(length: 2)).mp4")
            print(location)
            print(savedURL)
            try FileManager.default.moveItem(at: location, to: savedURL)
        } catch {
            print ("file error: \(error)")
        }
        isDownloading = false
        isPercentageHidden = true
        self.delegate?.reloadTableView()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progressFloat = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progress = "%" + String(Int(progressFloat*100))
        self.delegate?.reloadTableView()
    }
        
}
