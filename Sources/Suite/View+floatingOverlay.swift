//
//  View+floatingOverlay.swift
//  Suite
//
//  Created by Daniel Eden on 29/05/2025.
//

import SwiftUI

@available(iOS 17, watchOS 10, macOS 15, tvOS 17, *)
private struct FloatingOverlayModifier<OverlayContent: View>: ViewModifier {
	@State private var size = CGSize.zero
	
	var alignment: Alignment
	var insetEdges: Edge.Set
	
	@ViewBuilder var overlayContent: OverlayContent
	
	func body(content: Content) -> some View {
		content
			.contentMargins(insetEdges, size.height, for: .automatic)
			.overlay(alignment: alignment) {
				self.overlayContent
					.overlay {
						GeometryReader { g in
							Color.clear
								.task(id: g.size) { size = g.size }
						}
					}
			}
	}
}

@available(iOS 17, watchOS 10, macOS 15, tvOS 17, *)
extension View {
	/// Layers the view that you specify in front of this view, with content margins applied to scrolling containers.
	/// - Parameters:
	///   - alignment: The alignment for the foreground content
	///   - insetEdges: The container edges to indent
	///   - content: The content to overlay
	/// - Returns: A view that uses the specified content as a foreground, with content margins equal to the overlaid content size applied to the specified inset edges.
	func floatingOverlay<OverlayContent: View>(
		alignment: Alignment = .bottom,
		insetEdges: Edge.Set = .bottom,
		@ViewBuilder content: () -> OverlayContent
	) -> some View {
		modifier(
			FloatingOverlayModifier(
				alignment: alignment,
				insetEdges: insetEdges,
				overlayContent: content
			)
		)
	}
}
