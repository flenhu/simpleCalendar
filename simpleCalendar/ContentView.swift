import SwiftUI

struct ContentView: View {
    @State private var calendar: String = ""
    @State private var month: String = ""
    @State private var current = Date()
    
    init() {
        _calendar = State(wrappedValue: show())
        _month = State(wrappedValue: display())
    }
    
    private var daysOfWeekHeader: String {
        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        return days.joined(separator: " ")
    }
    
    private func display() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: current)
    }
    
    private func show() -> String {
        let yearAndMonth = Calendar.current.dateComponents([.year, .month], from: current)
        let days: [[Int]] = calendarLogic().create(yearAndMonth: yearAndMonth)
        var month: String = ""
        for row in 0...5 {
            for col in 0...6 {
                month += (col > 0 ? " " : "") + String(format: "%2d", days[row][col])
            }
            if row < 5 {
                month += "\n"
            }
        }
        return month
    }
    
    var body: some View {

        VStack {
            
            Label("Calendar", systemImage: "calendar")
                .font(.title)
                .foregroundColor(.blue)
            
            TextField("", text: $month)
                .multilineTextAlignment(.center)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 24, design: .monospaced))
                .padding(.vertical, 12)
            
            Text(daysOfWeekHeader)
                .font(.system(size: 18, design: .monospaced))
                .padding(.vertical, 6)
                .foregroundColor(.blue)
                
            Text(calendar)
                .multilineTextAlignment(.center)
                .font(.system(size: 24, design: .monospaced))
                .padding(.bottom, 12)
                
            HStack(spacing: 18) {
                Button("Previous", action: {
                    current = Calendar.current.date(byAdding: .month, value: -1, to: current)!
                    month = display()
                    calendar = show()
                })
                .frame(width: 100, height: 44) // Set a fixed width and height for the button
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(8)
                .foregroundColor(.black) // Set the button text color to black
                
                Button("Today", action: {
                    current = Date()
                    month = display()
                    calendar = show()
                })
                .frame(width: 100, height: 44)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(8)
                .foregroundColor(.black)
                
                Button("Next", action: {
                    current = Calendar.current.date(byAdding: .month, value: 1, to: current)!
                    month = display()
                    calendar = show()
                })
                .frame(width: 100, height: 44)
                .background(Color.green.opacity(0.3))
                .cornerRadius(8)
                .foregroundColor(.black)
            }

            Spacer()
            
        }
        .padding()
    }
}
