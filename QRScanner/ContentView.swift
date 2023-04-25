//
//  ContentView.swift
//  QRScanner
//
//  Created by Tülay MAYUNCUR on 17.04.2023.
//
import SwiftUI
import CodeScanner

struct ContentView: View {
    
    @State var isPresentingScanner = false
    @State var scannedCode: URL? = nil
    
    var scannerSheet: some View {
        
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = URL(string: code.string)
                    self.isPresentingScanner = false
                }
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if let url = scannedCode {
                Link(destination: url) {
                    Text(url.absoluteString)
                }
            } else {
                Text("Başlamak için QR kodunu tarayın.")
            }
            
            Button("QR Kodunu Taramak İçin Tıklayınız.") {
                self.isPresentingScanner = true
            }
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
