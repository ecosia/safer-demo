import SwiftUI
import Safer

struct BadgeView: View {
    @Binding var report: Report
    
    private var image: String {
        switch report.rating {
        case .good: return "lock.circle.fill"
        default: return "lock.open.fill"
        }
    }
    
    private var color: Color {
        switch report.rating {
        case .good: return .accentColor
        default: return .primary
        }
    }
    
    var body: some View {
        Image(systemName: image)
            .foregroundColor(color)
    }
}
