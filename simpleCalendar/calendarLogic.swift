import Foundation

class calendarLogic {
    func create(yearAndMonth: DateComponents) -> [[Int]] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday Start

        let date = calendar.date(from: yearAndMonth)!

        let firstWeekdayOfThisMonth = calendar.component(.weekday, from: date)
        let numberOfDaysInThisMonth = calendar.range(of: .day, in: .month, for: date)!.count

        let previousMonth = calendar.date(byAdding: .month, value: -1, to: date)!
        let numberOfDaysInPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)!.count

        var daysToFillFromPreviousMonth = firstWeekdayOfThisMonth - 1
        if daysToFillFromPreviousMonth == 0 {
            daysToFillFromPreviousMonth = 7
        }

        var days: [[Int]] = Array(repeating: Array(repeating: 0, count: 7), count: 6)
        
        var currentDay = numberOfDaysInPreviousMonth - daysToFillFromPreviousMonth + 1
        var currentMonthDay = 1
        var nextMonthDay = 1
        var currentMonth = -1
            
        for row in 0..<6 {
            for col in 0..<7 {
                if currentMonth == -1 {
                    days[row][col] = currentDay
                    currentDay += 1
                    if currentDay > numberOfDaysInPreviousMonth {
                        currentDay = 1
                        currentMonth = 0
                    }
                } else if currentMonth == 0 {
                    days[row][col] = currentMonthDay
                    currentMonthDay += 1
                    if currentMonthDay > numberOfDaysInThisMonth {
                        currentMonthDay = 1
                        currentMonth = 1
                    }
                } else {
                    days[row][col] = nextMonthDay
                    nextMonthDay += 1
                }
            }
        }
        return days
    }

}


