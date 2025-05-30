//
//  View+dataTask.swift
//  Suite
//
//  Created by Daniel Eden on 29/05/2025.
//

import SwiftUI

@available(iOS 17, watchOS 8, macOS 15, tvOS 15, *)
struct DataTaskModifier: ViewModifier {
	@Environment(\.scenePhase) var scenePhase
	
	let action: () async -> Void

	func body(content: Content) -> some View {
		content
			.task { await action() }
			.refreshable { await action() }
			.onChange(of: scenePhase) { currentScenePhase in
				if case .active = currentScenePhase {
					Task { await action() }
				}
			}
	}
}

@available(iOS 17, watchOS 8, macOS 15, tvOS 15, *)
public extension View {
	/// Adds an asynchronous function to the view that is called upon refresh, scene phase change, and changes to any equatable values in an array of dependencies.
	/// - Parameter action: An asynchronous handler called when the view first appears, when a refresh is requested, and when the app scene phase changes to active from any other state
	/// - Returns: A view which will call `action` when it first appears, when a refresh is requested, and when the app scene phase changes to active.
	func dataTask(perform action: @escaping () async -> Void) -> some View {
		modifier(DataTaskModifier(action: action))
	}
}
