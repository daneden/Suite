//
//  View+if.swift
//  Suite
//
//  Created by Daniel Eden on 29/05/2025.
//

import SwiftUI

@available(iOS 13, watchOS 6, macOS 15, tvOS 13, *)
public extension View {
	/// Applies the given transform if the given condition evaluates to `true`.
	///
	/// ## Example Usage
	///```swift
	///Text("\(stockCount) in stock")
	///		.if(stockCount <= 0) { content in
	///			content
	///				.foregroundStyle(.red)
	///		}
	///```
	///
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
	@ViewBuilder
	func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
		if condition {
			transform(self)
		} else {
			self
		}
	}
}
