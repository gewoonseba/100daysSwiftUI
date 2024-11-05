//
//  UserListView.swift
//  Friendface
//
//  Created by Sebastian Stoelen on 05/11/2024.
//

import SwiftUI

struct UserRowView: View {
    let user: User

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text(user.company)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: user.isActive ? "checkmark.circle.fill" : "circle.fill")
                .foregroundStyle(user.isActive ? .green : .secondary.opacity(0.3))
        }
    }
}

#Preview {
    UserRowView(user: User(
        id: "1",
        isActive: false,
        name: "Sebastian Stoelen",
        age: 30,
        company: "Apple",
        email: "sebastian@example.com",
        address: "123 Swift Street",
        about: "iOS developer who loves SwiftUI",
        registered: Date(),
        tags: ["swift", "ios", "coding"],
        friends: []
    ))
}
