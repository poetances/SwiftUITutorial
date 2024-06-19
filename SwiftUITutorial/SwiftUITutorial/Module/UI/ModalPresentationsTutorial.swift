//
//  ModalPresentationsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/26.
//

import SwiftUI
import UniformTypeIdentifiers

/*
 Modal Presention都是以modifier的形式展示的。

 DialogSeverity，对话框的严重程度。
 automatic
    The default dialog severity. Alerts that present an error will use .critical and all others will use .standard.
 standard
 critical

 */
struct ModalPresentationsTutorial: View {

    @State private var isShowSheet = false

    @State private var inventory: InventoryItem?

    @State private var isShowFullScreen = false

    @State private var isShowPoper = false

    @State private var isShowCompact = false
    @State private var isShowCompact2 = false

    @State private var isShowDetents = false
    @State private var isShowDetents2 = false
    @State private var detent = PresentationDetent.large

    @State private var isShowAlter = false
    @State private var isShowAlterText = false

    @State private var isShowAlterMessage = false

    @State private var isShowConfirmationDialog = false

    @State private var isShowConfirmationDialogMessage = false

    @State private var isShowFileExporting = false

    @State private var isShowFileImporter = false

    @State private var isShowFileMover = false

    @State private var isShowInspector = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.isPresented) private var isPresented
    @State private var isShowPresentationDismiss = false
    // MARK: - system
    var body: some View {
        List {
            sheet_presented
            sheet_item
            sheet_fullScreenCover
            sheet_poper
            sheet_compact
            sheet_compact2
            sheet_detents
            sheet_detents2
            alter
            alter_text
            alter_message
            confirmation_dialog
            confirmation_dialog_message
            exproting_file
            file_importer
            file_mover
            inspector
            presentation_dissmiss
        }
    }
}

// MARK: - sheet(isPresented:onDismiss:content:)
extension ModalPresentationsTutorial {
    
    var sheet_presented: some View {
        Button("Sheet Presented") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet) {
            Text("Sheet").background(Color.purple)
        }
    }
}

// MARK: - sheet(item:onDismiss:content:)
extension ModalPresentationsTutorial {
    /*
     A binding to an optional source of truth for the sheet. When item is non-nil, the system passes the item’s content to the modifier’s closure. You display this content in a sheet that you create that the system displays to the user. If item changes, the system dismisses the sheet and replaces it with a new one using the same process.
     */
    var sheet_item: some View {
        Button("Sheet Item") {
            inventory = InventoryItem(
                id: "0123456789",
                partNumber: "Z-1234A",
                quantity: 100,
                name: "Widget"
            )
        }
        .sheet(item: $inventory) { inventory in
            VStack(alignment: .leading, spacing: 20) {
                Text("Part Number: \(inventory.partNumber)")
                Text("Name: \(inventory.name)")
                Text("Quantity On-Hand: \(inventory.quantity)")
            }
        }

    }

    struct InventoryItem: Identifiable {
        var id: String
        let partNumber: String
        let quantity: Int
        let name: String
    }
}

// MARK: - fullScreenCover(isPresented:onDismiss:content:)
extension ModalPresentationsTutorial {

    var sheet_fullScreenCover: some View {
        Button("Sheet Full Screen") {
            isShowFullScreen.toggle()
        }
        .fullScreenCover(isPresented: $isShowFullScreen) {
            VStack(spacing: 15) {
                Button("Dismiss") {
                    dismiss() // DismissAction callAsFunction
                }
                Button("Dissmiss2") {
                    isShowFullScreen.toggle()
                }
            }
        }
    }

    // fullScreenCover(item:onDismiss:content:)， 这里和.navigationDestination很像
    var sheet_fullScreenCover_item: some View {
        Button("Sheet Full Screen item") {

        }
        .fullScreenCover(item: $inventory) { inventory in
            VStack(alignment: .leading, spacing: 20) {
                Text("Part Number: \(inventory.partNumber)")
                Text("Name: \(inventory.name)")
                Text("Quantity On-Hand: \(inventory.quantity)")
            }
        }
    }
}

// MARK: - popover(isPresented:attachmentAnchor:arrowEdge:content:)
extension ModalPresentationsTutorial {

    /*
     Popover并不只适用于macOS。尽管它在macOS中非常常见，但是在iOS和iPadOS也可以使用Popover。
     但是，需要注意的是，Popover在不同的操作系统和设备上可能会有不同的表现形式。
     例如，在iPad上，Popover可能会以一个悬浮的窗口形式出现，而在iPhone上，Popover可能会以全屏或者底部弹出的形式出现。
     */
    var sheet_poper: some View {
        Button("Sheet Poper") {
            isShowPoper.toggle()
        }
        .popover(isPresented: $isShowPoper, content: {
            Button("Hide Poper") {
                isShowPoper.toggle()
            }
        })
    }
}

// MARK: - presentationCompactAdaptation(_:)
extension ModalPresentationsTutorial {
    /*
     苹果考虑到popver在iOS上的限制，所以提供了presentationCompactAdaptation(_:)来进行sheet优化
     PresentationAdaptation有四种结果：
     automic不同系统呈现不同效果
     popover在iOS系统中程序popper效果
     none在iOS中none和popover效果一样
     sheet在iOS系统中sheet和automic是一样的效果
     fullScreen全屏
     */
    var sheet_compact: some View {
        Button("Sheet compact") {
            isShowCompact.toggle()
        }
        .popover(isPresented: $isShowCompact) {
            Button("Hide Poper") {
                isShowCompact.toggle()
            }
            .frame(width: 200, height: 100)
            .presentationCompactAdaptation(.popover)
        }
    }

    var sheet_compact2: some View {
        Button("Sheet compact2") {
            isShowCompact2.toggle()
        }
        .popover(isPresented: $isShowCompact2,
                 attachmentAnchor: .point(.top),
                 arrowEdge: .bottom) {
            Button("Hide Poper") {
                isShowCompact2.toggle()
            }
            .frame(width: 200, height: 100)
            .presentationCompactAdaptation(horizontal: .popover, vertical: .sheet)
        }
    }
}

// MARK: - presentationDetents(_:)
extension ModalPresentationsTutorial {

    /*
     presentationDetents
     让sheet以两段式展开。只有在Sheet样式起作用
     */
    var sheet_detents: some View {
        Button("Sheet detents") {
            isShowDetents.toggle()
        }
        .sheet(isPresented: $isShowDetents) {
            Button("Hide Detents") {
                isShowDetents.toggle()
            }
            .presentationDetents([.medium, .large, .height(200)])
            .presentationDragIndicator(.visible)
            .presentationContentInteraction(.resizes)
            .presentationCornerRadius(30)
            .presentationBackground(Color.pink)
        }
    }

    /*
     presentationDetents(_:selection:)
     Sets the available detents for the enclosing sheet, giving you programmatic control of the currently selected detent.
     programmatic control很重要，即以编程的方式控制
     */
    var sheet_detents2: some View {
        Button("Sheet detents2") {
            isShowDetents2.toggle()
            print("show---")
        }
        .sheet(isPresented: $isShowDetents2) {
            ScrollView {
                Button("Hide Detents") {
                    isShowDetents2.toggle()
                }
            }
            .presentationDetents([.bar, .medium, .large], selection: $detent)
            .presentationContentInteraction(.scrolls)
        }
    }
}

extension PresentationDetent {
    static let bar = Self.custom(BarDetent.self)
    static let small = Self.height(100)
    static let extraLarge = Self.fraction(0.75)
}

private struct BarDetent: CustomPresentationDetent {
    // context.maxDetentValue是展示的最大高度，比如753
    static func height(in context: Context) -> CGFloat? {
        print(context.maxDetentValue, UIScreen.main.bounds)
        return max(44, context.maxDetentValue * 0.1)
    }
}

// MARK: - presentationCornerRadius(_:)
// MARK: - presentationBackground(_:)
// MARK: - presentationBackground(alignment:content:)

// MARK: - alert(_:isPresented:actions:message:)
extension ModalPresentationsTutorial {

    var alter: some View {
        Button("Alter") {
            isShowAlter.toggle()
        }
        .alert("Alter", isPresented: $isShowAlter) {
            Button("Ok") {
                isShowAlter.toggle()
            }
            Button("Cancel") {
                isShowAlter.toggle()
            }
        }
    }

    /// Alter Text很奇怪的是，传递有样式的Text并不会起作用
    var alter_text: some View {
        Button("Alter text") {
            isShowAlterText.toggle()
        }
        .alert(
            Text("Alter Text"),
            isPresented: $isShowAlterText
        ) {

        }
    }

    /*
     Alter message同样很奇怪，因为Message虽然是View，
     但是只能放Text，并且也不能设置样式
     */
    var alter_message: some View {
        Button("Alter message") {
            isShowAlterMessage.toggle()
        }
        .alert("Alert Message", isPresented: $isShowAlterMessage) {
            Button("Ok", role: .cancel) {
                isShowAlterMessage.toggle()
            }
            Button("Alter", role: .destructive) {
                isShowAlterMessage.toggle()
            }
        } message: {
            Text("Please check your credentials and try again.")
        }

    }
}

// MARK: - confirmationDialog(_:isPresented:titleVisibility:actions:)
extension ModalPresentationsTutorial {

    /*
     titleVisibility是否显示标题
     The visibility of the dialog’s title. The default value is Visibility.automatic.

     可以通过Button, role来改变角色。
     */
    var confirmation_dialog: some View {
        Button("Confirmation Dialog") {
            isShowConfirmationDialog.toggle()
        }
        .confirmationDialog("Dialog", 
                            isPresented: $isShowConfirmationDialog,
                            titleVisibility: .visible) {
            Button("One", role: .cancel) {
                isShowConfirmationDialog.toggle()
            }
            Button("Two", role: .destructive) {
                isShowConfirmationDialog.toggle()
            }
            Button("Three") {
                isShowConfirmationDialog.toggle()
            }
        }

    }

    var confirmation_dialog_message: some View {
        Button("Confirmation Dialog Message") {
            isShowConfirmationDialogMessage.toggle()
        }
        .confirmationDialog("Dialog Message", isPresented: $isShowConfirmationDialogMessage, titleVisibility: .visible) {
            Button("One") {
                isShowConfirmationDialog.toggle()
            }
            Button("Two") {
                isShowConfirmationDialog.toggle()
            }
            Button("Three") {
                isShowConfirmationDialog.toggle()
            }

            Button("取消", role: .cancel) {
                isShowConfirmationDialog.toggle()
            }
        } message: {
            Text("You cannot undo this action.")
        }
    }
}

// MARK: - Exporting file
extension ModalPresentationsTutorial {
    /*
     Exporting to file
     Presents a system interface for exporting a document that’s stored in a value type, like a structure, to a file on disk.
     */
    var exproting_file: some View {
        Button("File exproting") {
            isShowFileExporting.toggle()
        }
        .fileExporter(isPresented: $isShowFileExporting,
                      document: TextDocument("file exported"),
                   contentType: .text,
               defaultFilename: "document.txt") { result in
            print(result)
        }
    }

    struct TextDocument: FileDocument {

        var text: String = ""

        static public var readableContentTypes: [UTType] =
        [.text, .json, .xml]

        init(_ text: String = "") {
            self.text = text
        }

        init(configuration: ReadConfiguration) throws {
            if let data = configuration.file.regularFileContents {
                text = String(decoding: data, as: UTF8.self)
            }
        }

        func fileWrapper(configuration: WriteConfiguration)
        throws -> FileWrapper {
            let data = Data(text.utf8)
            return FileWrapper(regularFileWithContents: data)
        }
    }
}

// MARK: - fileImporter
extension ModalPresentationsTutorial {

    var file_importer: some View {
        Button("File importer") {
            isShowFileImporter.toggle()
        }
        .fileImporter(isPresented: $isShowFileImporter, allowedContentTypes: [.pdf, .png], allowsMultipleSelection: true) { result in
            print(result)
        }
    }
}

// MARK: - fileMover
extension ModalPresentationsTutorial {

    /*
     Presents a system interface for allowing the user to move an existing file to a new location.
     */
    var file_mover: some View {
        Button("File mover") {
            isShowFileMover.toggle()
        }
        .fileMover(isPresented: $isShowFileMover, 
                   file: URL(fileURLWithPath: "")) { result in
            print(result)
        }
    }
}

// MARK: - fileDialogConfirmationLabel 在macos上有用

// MARK: - inspector(isPresented:content:)
extension ModalPresentationsTutorial {

    var inspector: some View {
        Button("Inspector") {
            isShowInspector.toggle()
        }
        .inspector(isPresented: $isShowInspector) {
            Text("Inspector")
        }
    }
}

// MARK: - interactiveDismissDisabled
extension ModalPresentationsTutorial {
    /*
     interactiveDismissDisabled用户不能关闭弹窗
     */
    var presentation_dissmiss: some View {
        Button("Presentation dismiss") {
            isShowPresentationDismiss.toggle()
        }
        .sheet(isPresented: $isShowPresentationDismiss) {
            Button("Dismiss") {
                isShowPresentationDismiss.toggle()
            }
            .presentationDetents([.large, .medium])
            .presentationBackground(Color.pink)
            .presentationCornerRadius(20)
            .interactiveDismissDisabled(true)

        }
    }
}

#Preview {
    Group {
        ModalPresentationsTutorial()
            .previewDevice("iPhone 15 Pro")
            .previewDisplayName("iPhone 15 Pro")
//        ModalPresentationsTutorial()
//            .previewDevice("iPad 12.9-inch")
//            .previewDisplayName("iPad 12.9-inch")
    }
}
