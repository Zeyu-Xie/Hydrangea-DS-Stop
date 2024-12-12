import SwiftUI

struct _DSStoreFolderSelectPanel: View {
    
    @Binding var folderPath: String?
    
    var body: some View {
        VStack {
            Button(action: {
                folderPath = selectFolderPath()
            }) {
                Label("Select Folder", systemImage: "folder")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding([.top, .bottom])
              
            Text("Folder Path")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            TextField(
                "Folder Path",
                text: .constant(folderPath ?? "No folder chosen")
            )
            .font(.system(.body, design: .monospaced))
            .lineLimit(1)
            .disabled(true)
            .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}
