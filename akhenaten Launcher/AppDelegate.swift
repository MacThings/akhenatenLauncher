import Cocoa
import Foundation

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {

        let fm = FileManager.default
        let home = fm.homeDirectoryForCurrentUser

        let akhenatenDir = home.appendingPathComponent(".config/akhenaten", isDirectory: true)
        let fontsTargetDir = akhenatenDir.appendingPathComponent("fonts", isDirectory: true)

        // 1) Prüfen ob ~/.config/akhenaten existiert
        if !fm.fileExists(atPath: akhenatenDir.path) {
            try? fm.createDirectory(
                at: akhenatenDir,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        // 2) Fonts-Ordner anlegen (falls fehlt)
        if !fm.fileExists(atPath: fontsTargetDir.path) {
            try? fm.createDirectory(
                at: fontsTargetDir,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        // 3) Bundle-Fonts kopieren (nur wenn Datei fehlt)
        if let bundleFontsDir = Bundle.main.resourceURL?
            .appendingPathComponent("fonts", isDirectory: true),
           let fontFiles = try? fm.contentsOfDirectory(
                at: bundleFontsDir,
                includingPropertiesForKeys: nil,
                options: [.skipsHiddenFiles]
           ) {

            for font in fontFiles {
                let dst = fontsTargetDir.appendingPathComponent(font.lastPathComponent)
                if !fm.fileExists(atPath: dst.path) {
                    try? fm.copyItem(at: font, to: dst)
                }
            }
        }
        
    
    }
}
