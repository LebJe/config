import Foundation
import Files

// Checks for Raspberry Pi backup files that over 4 days old, and deletes them.

let backupFolder = try! Folder.home.subfolder(at: "RPiBackups")
let currentDate = Date()
var didClean = false

var numCleaned = 0

for file in backupFolder.files {
    
    if let fileDate = file.creationDate {
        if shouldDelete(date: fileDate) {
            try! file.delete()
            didClean = true
            numCleaned += 1
        }
    }

}

func shouldDelete(date: Date) -> Bool {
    let calendar = Calendar.current
 
    
    let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)

    return (currentDateComponents.day! - dateComponents.day!) > 4
}

didClean ? print("Cleaned \(numCleaned) files.") : print("Nothing to clean.")

