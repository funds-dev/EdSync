import SwiftUI

// Helper func to format timestamp
func formattedTimestamp(for message: Message) -> String {
  let calendar = Calendar.current
  if calendar.isDateInToday(message.timestamp) {
    return message.timestamp.formatted(.dateTime.hour().minute())
  } else {
    return message.timestamp.formatted(.dateTime.day().month())
  }
}

// Helper func to determine if messages should be grouped
func shouldGroup(current: Message, previous: Message?) -> Bool {
  guard let previous = previous else { return false }

  // Check if same sender
  if current.sender != previous.sender || current.received != previous.received {
    return false
  }

  // Check if within 10 minutes
  let timeInterval = current.timestamp.timeIntervalSince(previous.timestamp)
  return abs(timeInterval) <= 600
}

struct MessageBubbleComponent: View {
  var message: Message
  var position: MessagePosition
  var showSender: Bool
  var showTimestamp: Bool

  var body: some View {
    VStack(alignment: message.received ? .leading : .trailing, spacing: 2) {
      // Only show sender on first message
      if showSender && message.received {
        Text(message.sender)
          .font(.footnote)
          .foregroundStyle(.gray)
          .padding(message.received ? .leading : .trailing, 12)
      }

      // Message Bubble
      HStack {
        Text(message.text)
          .padding()
          .background(message.received ? .gray : .blue)
          .foregroundStyle(.white)
          .cornerRadius(20)
      }
      .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)

      if showTimestamp {
        Text("\(formattedTimestamp(for: message))")
          .foregroundStyle(.gray)
          .font(.caption)
          .padding(message.received ? .leading : .trailing, 12)
      }
    }
    .padding(message.received ? .leading : .trailing)
    .padding(message.received ? .trailing : .leading, 50)
    .padding(.bottom, position == .last || position == .single ? 10 : 2)
  }
}

// Message group view
struct MessageGroup : View {
  var messages : [Message]

  var body : some View {
    VStack(spacing: 0) {
      ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
        // Determine position
        let position: Message Position = {
          if messages.count == 1 {
            return .single
          } else if index == 0 {
            return .first
          } else if index == messages.count - 1 {
            return .last
          } else {
            return .middle
          }
        }()

        // Determine whether to show sender and timestamp
        let showSender = index == 0
        let showTimestamp = index == messages.count - 1

        // Return view component
        MessageBubbleComponent(
          message: message,
          position: position,
          showSender: showSender,
          showTimestamp
        )
      }
    }
  }
}
