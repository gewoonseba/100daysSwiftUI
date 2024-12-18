//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Sebastian Stoelen on 03/12/2024.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State private var navigationPath = NavigationPath()

    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }

    init(filter: FilterType) {
        self.filter = filter
        if filter != .none {
            let showContactedOnly = filter == .contacted
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }

    var body: some View {
            NavigationStack(path: $navigationPath) {
                List(prospects, selection: $selectedProspects) { prospect in
                    ProspectItemView(prospect: prospect, showContactStatus: filter == .none)
                        .onTapGesture {
                            navigationPath.append(prospect)
                        }
                        .swipeActions {
                            ProspectSwipeActionsView(prospect: prospect, modelContext: modelContext, addNotification: addNotification)
                        }
                        .tag(prospect)
                }
                .navigationTitle(title)
                .navigationDestination(for: Prospect.self) { prospect in
                    EditProspectView(prospect: prospect)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    if selectedProspects.isEmpty == false {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Delete Selected", action: delete)
                        }
                    }
                    ToolbarItem {
                        Button("Scan", systemImage: "qrcode.viewfinder") {
                            isShowingScanner = true
                        }
                    }
                    ToolbarItem {
                        Button("Sort", systemImage: "arrow.up.arrow.down") {
                            toggleSort()
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Seba Stoelen\nseba@gewoonseba.com", completion: handleScan)
                }
            }
        }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func toggleSort() {
        
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct ProspectItemView: View {
    let prospect: Prospect
    let showContactStatus: Bool
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.emailAddress)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if showContactStatus {
                Image(systemName: prospect.isContacted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(prospect.isContacted ? .green : .gray.opacity(0.4))
            }
        }
    }
}

struct ProspectSwipeActionsView: View {
    let prospect: Prospect
    let modelContext: ModelContext
    let addNotification: (Prospect) -> Void

    var body: some View {
        Group {
            if prospect.isContacted {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                    prospect.isContacted.toggle()
                }
                .tint(.blue)
            } else {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                    prospect.isContacted.toggle()
                }
                .tint(.green)
                Button("Remind Me", systemImage: "bell") {
                    addNotification(prospect)
                }
                .tint(.orange)
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
}
