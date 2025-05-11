// Views/HomeView.swift
import SwiftUI

// MARK: Home View
struct HomeView : View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    
                    
                    Image("EdSyncLogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 10)
                        .frame(width: 75)
                    
                    // MARK: Tabular ViewModel
                    TabView {
                        Tab("Resources", systemImage: "magnifyingglass") {
                            ResourceView()
                        }
                        Tab("Chatroom", systemImage:"message") {
                            ChatroomView()
                        }
                        Tab("Profile", systemImage:"person.fill") {
                            ProfileView()
                        }
                     }
                    
                    // Prototype Watermark
                    Text("Early prototype — features may be limited")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}


struct ChatroomView: View {
    // Sample messages that preview grouping feature
    var messages: [Message] = [
        Message(
            id: "1",
            sender: "EdSync Team",
            text: "Hello! Welcome to the Autism Support Community.",
            received: true,
            timestamp: Date().addingTimeInterval(-3600) // 1 hour ago
        ),
        Message(
            id: "2",
            sender: "EdSync Team",
            text: "This is a proof of concept for the chatroom feature of our application.",
            received: true,
            timestamp: Date().addingTimeInterval(-3540) // 59 minutes ago (within 20 min of previous)
        ),
        Message(
            id: "3",
            sender: "EdSync Team",
            text: "This feature will be further developed to help parents of children with autism connect and share resources.",
            received: true,
            timestamp: Date().addingTimeInterval(-3480) // 58 minutes ago (within 20 min of previous)
        ),
        Message(
            id: "4",
            sender: "You",
            text: "This looks great! When will we be able to share external resources?",
            received: false,
            timestamp: Date().addingTimeInterval(-1800) // 30 minutes ago
        ),
        Message(
            id: "5",
            sender: "EdSync Team",
            text: "We're planning to implement resource sharing in the next update. You'll be able to post links to helpful websites, articles, and local events.",
            received: true,
            timestamp: Date().addingTimeInterval(-900) // 15 minutes ago
        ),
        Message(
            id: "6",
            sender: "You",
            text: "That's exactly what I was hoping for!",
            received: false,
            timestamp: Date().addingTimeInterval(-840) // 14 minutes ago
        ),
        Message(
            id: "7",
            sender: "You",
            text: "Will there also be a feature to find local support groups?",
            received: false,
            timestamp: Date().addingTimeInterval(-820) // 13.6 minutes ago (within 20 min of previous)
        ),
        Message(
            id: "8",
            sender: "EdSync Team",
            text: "It's possible, but we must keep our ambitions achievable.",
            received: true,
            timestamp: Date().addingTimeInterval(-750)
        )
    ]
    
    var body: some View {
        VStack {
            // Title of Chatroom and Members Online
            TitleCard()
            
            // Message Bubbles
            MessageContainer(allMessages: messages)
                .defaultScrollAnchor(.bottom)
                .padding(.top, 10)
                .background(.white)
            
            MessageField()
        }
        .padding([.top, .horizontal], 5)
    }
}	    		

struct ProfileView : View {
    var body : some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue)
                .frame(width:100)
                .padding(20)
            Text("This is an early view of our Profile display\nDetails may be placeholder content")
                .font(.system(size: 20))
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            HStack {
                Text("Name:")
                    .bold()
                
                Text("Juan Nadie")
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("Email:")
                    .bold()
                
                Text(verbatim:"example@hotmail.com")
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("Member Since:")
                    .bold()
                
                Text("\(Date().formatted(date: .abbreviated, time: .omitted))")
            }
            Spacer()
        }
    }
}

struct Resource: Identifiable {
    let id = UUID()
    var title: String
    var url: String
}

struct ResourceView : View {
    @Environment(\.openURL) var openURL
    private var resources: [Resource] = [
        Resource(title: "Easterseals Therapy Services", url: "https://www.easterseals.com/southerncal/programs-and-services/autism-asd-services/new-oxnard-therapy-center.html"),
        Resource(title: "Parent Guides", url: "https://cdrv.org/parent-resources/"),
        Resource(title: "Behavioural Service Providers in Ventura", url: "https://autismventura.org/test/wpbdp_category/community-resources-behavioral-service-providers/")
    ]
    private var gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 8) {
                    ForEach(resources) { resource in
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(.gray)
                            VStack {
                                Text(resource.title)
                                    .font(.system(size: 500))
                                    .minimumScaleFactor(0.01)
                                    .padding()
                                    .lineLimit(Int.max)
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .onTapGesture {
                            if let url = URL(string: resource.url) {
                                openURL(url)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    HomeView()
}
