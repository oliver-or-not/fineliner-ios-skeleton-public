// MARK: - Module Dependency

import SwiftUI

// MARK: - Body

public extension DS.SemanticColor {

    static let dim: Color = .init(hex: "000000", opacity: 0.3)

    static let sectionOpaque: Color = .init(hex: "C4EAED")
    static let sectionCenter: Color = .init(hex: "C4EAED").opacity(0.25)
    static let sectionPeriphery: Color = .init(hex: "C4EAED").opacity(0.75)
    static let subsectionCenter: Color = .init(hex: "FFFFFF").opacity(0.65)
    static let subsectionPeriphery: Color = .init(hex: "FFFFFF").opacity(0.85)
    static let interactable: Color = .init(hex: "C6BCFD").opacity(0.2)
    static let interactableVivid: Color = .init(hex: "C6BCFD").opacity(0.75)

    static let dialogBackground: Color = .init(hex: "C4EAED").opacity(0.75)
    static let dialogButtonBackground: Color = .init(hex: "C6BCFD").opacity(0.9)

    static let unavailableText: Color = .init(hex: "B7B7B7")
}
