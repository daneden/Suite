//
//  View+modify.swift
//  Suite
//
//  Created by Daniel Eden on 29/05/2025.
//

import SwiftUI

@available(iOS 13, watchOS 6, macOS 15, tvOS 13, *)
public extension View {
	/// Applies a given transformation inline. Useful for e.g. `#available` attribute-based content changes.
	///
	/// ## Example Usage
	/// ```swift
	///Text("Hello, world")
	///		.modify { content in
	///			if #available(iOS 15, *) {
	///				content.foregroundStyle(.primary)
	///			} else {
	///				content.foregroundColor(.primary)
	///			}
	///		}
	/// ```
	/// - Parameters:
	///   - transform: The transform to apply to the source `View`
	/// - Returns: The modified `View`
	func modify<Content: View>(@ViewBuilder transform: (Self) -> Content) -> some View {
		transform(self)
	}
}
