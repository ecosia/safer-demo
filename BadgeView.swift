import SwiftUI
import Safer

struct BadgeView: View {
    @Binding var report: Report
    
    private var image: String {
        switch report.rating {
        case .good, .unknown: return "lock.circle.fill"
        default: return "lock.open.fill"
        }
    }
    
    private var color: Color {
        switch report.rating {
        case .good, .unknown: return .accentColor
        default: return Color.red
        }
    }
    
    var body: some View {
        Image(systemName: image)
            .foregroundColor(color)
    }
}
