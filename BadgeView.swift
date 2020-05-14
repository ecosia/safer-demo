import SwiftUI

struct BadgeView: View {
    @Binding var rating: Rating
    
    private var image: String {
        switch rating {
        case .good: return "lock.circle.fill"
        default: return "lock.open.fill"
        }
    }
    
    private var color: Color {
        switch rating {
        case .good: return .accentColor
        default: return .primary
        }
    }
    
    var body: some View {
        Image(systemName: image)
            .foregroundColor(color)
    }
}
