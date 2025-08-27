//
//  View+backportCircleSymbolVariant.swift
//  Suite
//
//  Created by Daniel Eden on 27/08/2025.
//

import SwiftUI

@available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension View {
	func backportCircleSymbolVariant() -> some View {
		if #available(iOS 26, macOS 26, visionOS 26, *) {
			return self
		} else {
			return self.symbolVariant(.circle)
		}
	}
}
