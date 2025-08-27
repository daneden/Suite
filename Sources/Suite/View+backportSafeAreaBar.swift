//
//  View+floatingOverlay.swift
//  Suite
//
//  Created by Daniel Eden on 29/05/2025.
//

import SwiftUI

@available(iOS 17, watchOS 10, macOS 14, tvOS 17, *)
private struct FloatingOverlayModifier<OverlayContent: View>: ViewModifier {
	@State private var size = CGSize.zero
	
	var edge: VerticalEdge
	var alignment: HorizontalAlignment
	var spacing: CGFloat?
	
	@ViewBuilder var overlayContent: OverlayContent
	
	var insetEdge: Edge.Set {
		switch edge {
		case .bottom: return .bottom
		case .top: return .top
		}
	}
	
	var resolvedAlignment: Alignment {
		switch alignment {
		case .leading: return .leading
		case .trailing: return .trailing
		default: return .center
		}
	}
	
	func body(content: Content) -> some View {
		content
			.contentMargins(insetEdge, size.height, for: .automatic)
			.overlay(alignment: resolvedAlignment) {
				self.overlayContent
					.padding(insetEdge, spacing)
					.overlay {
						GeometryReader { g in
							Color.clear
								.task(id: g.size) { size = g.size }
						}
					}
			}
	}
}

@available(iOS 17, watchOS 10, macOS 14, tvOS 17, *)
public extension View {
	/// Layers the view that you specify in front of this view, with content margins applied to scrolling containers.
	/// - Parameters:
	///   - edge: The vertical edge of the view on which content is placed
	///   - alignment: The alignment guide used to position `content` horizontally
	///   - spacing: Extra distance placed between the two views, or nil to use the default amount of spacing.
	///   - content: A view builder function providing the view to display as a custom bar.
	/// - Returns: A new view that displays content above or below the modified view, making space for the content view by vertically insetting the modified view, adjusting the safe area and scroll edge effects to match.
	func backportSafeAreaBar<OverlayContent: View>(
		edge: VerticalEdge = .bottom,
		alignment: HorizontalAlignment = .center,
		spacing: CGFloat? = nil,
		@ViewBuilder content: () -> OverlayContent
	) -> some View {
		if #available(iOS 26, macOS 26, visionOS 26, watchOS 26, *) {
			return safeAreaBar(edge: edge, alignment: alignment, spacing: spacing) {
				content()
			}
		} else {
			return modifier(
				FloatingOverlayModifier(
					edge: edge,
					alignment: alignment,
					spacing: spacing,
					overlayContent: content
				)
			)
		}
	}
}
