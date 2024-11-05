//
//  UserDetailView.swift
//  Friendface
//
//  Created by Sebastian Stoelen on 05/11/2024.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(user.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    Image(systemName: user.isActive ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundStyle(user.isActive ? .green : .secondary.opacity(0.3))
                }
                
                Group {
                    LabeledContent("Age", value: String(user.age))
                    LabeledContent("Company", value: user.company)
                    LabeledContent("Email", value: user.email)
                    LabeledContent("Address", value: user.address)
                    LabeledContent("Member since", value: user.registered.formatted(date: .long, time: .omitted))
                }
                .textSelection(.enabled)
                
                Text("About")
                    .font(.headline)
                Text(user.about)
                    .textSelection(.enabled)
                
                Text("Tags")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(.secondary.opacity(0.2))
                                .clipShape(.capsule)
                        }
                    }
                }
                
                if !user.friends.isEmpty {
                    Text("Friends")
                        .font(.headline)
                    ForEach(user.friends, id: \.id) { friend in
                        HStack {
                            Image(systemName: "person.fill")
                            Text(friend.name)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    UserDetailView(user: User(
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
        friends: [
            Friend(id: "1", name: "Mr. Nobody"),
            Friend(id: "2", name: "Ms. All Allone")
        ]
    ))
}
