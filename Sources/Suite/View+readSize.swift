//
//  View+readSize.swift
//  Suite
//
//  Created by Daniel Eden on 29/05/2025.
//


import SwiftUI

@available(iOS 15, watchOS 8, macOS 12, tvOS 15, *)
struct ReadSizeViewModifier: ViewModifier {
	@Binding var size: CGSize
	
	func body(content: Content) -> some View {
		content
			.overlay {
				GeometryReader { g in
					Color.clear.task(id: g.size) {
						size = g.size
					}
				}
			}
	}
}

@available(iOS 15, watchOS 8, macOS 12, tvOS 15, *)
public extension View {
	/// Reads the size of the target view and assigns its value to the passed binding. Changes to the view's size result in updates to the binding.
	///
	/// ## Example Usage
	/// ```swift
	/// struct ReadSizeExample: View {
	/// 		@State var size = CGSize.zero
	///		var body: some View {
	///			Circle()
	///				.frame(width: 100, height: 100)
	///				.readSize($size)
	///
	///			Text("Circle width: \(size.width)")
	///		}
	/// }
	/// ```
	/// - Parameter binding: A `CGSize` binding that will be updated with the size of the associated view
	/// - Returns: A view that updates `binding` with its own size
	func readSize(_ binding: Binding<CGSize>) -> some View {
		modifier(ReadSizeViewModifier(size: binding))
	}
}
