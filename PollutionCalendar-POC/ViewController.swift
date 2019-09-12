//
//  ViewController.swift
//  PollutionCalendar-POC
//
//  Created by Kimchheang on 9/12/19.
//  Copyright © 2019 Kimchheang. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: JTACMonthView!
    
    
    var dateFormatter = DateFormatter()
    var currentCalendar = Calendar.current
    var generateInDates: InDateCellGeneration = .forAllMonths
    var generateOutDates: OutDateCellGeneration = .tillEndOfGrid
    var hasStrictBoundaries = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.layer.cornerRadius = 4
        calendarView.layer.masksToBounds = true
        
        calendarView.visibleDates { [unowned self] visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
        calendarView.reloadData(withAnchor: Date())
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView.visibleDates()
        calendarView.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates.monthDates.first?.date)
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else { return }
        let month = currentCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        let year = currentCalendar.component(.year, from: startDate)
        monthLabel.text = "\(monthName) \(String(year))"
    }
    
    func configureVisibleCell(customCell: DayCell, cellState: CellState, date: Date, indexPath: IndexPath) {
        let pollutionType = PollutionType(rawValue: Int.random(in: 1..<3))!
        customCell.configCell(cellState: cellState, pollutionType: pollutionType)
    }
}

// MARK: - JTAppleCalendarDelegate
extension ViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = currentCalendar.timeZone
        dateFormatter.locale = currentCalendar.locale
        
        let startDate = dateFormatter.date(from: "2019 01 01")!
        let endDate = dateFormatter.date(from: "2019 12 31")!
        
        let parameters = ConfigurationParameters(
            startDate: startDate, endDate: endDate,
            numberOfRows: 6,
            calendar: currentCalendar,
            generateInDates: generateInDates, generateOutDates: generateOutDates,
            firstDayOfWeek: .monday,
            hasStrictBoundaries: hasStrictBoundaries)
        return parameters
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell,
                  forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        guard let customCell = cell as? DayCell else { return }
        configureVisibleCell(customCell: customCell, cellState: cellState, date: date, indexPath: indexPath)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date,
                  cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        let customCell = calendar.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        configureVisibleCell(customCell: customCell, cellState: cellState, date: date, indexPath: indexPath)
        return customCell
    }
    
//    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date,
//                  cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
//
//        cell?.alpha = cellState.dateBelongsTo == .thisMonth ? 1.0 : 0.1
//    }
//
//    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date,
//                  cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
//
//        cell?.alpha = cellState.dateBelongsTo == .thisMonth ? 1.0 : 0.1
//    }
    
    func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    func sizeOfDecorationView(indexPath: IndexPath) -> CGRect {
        let stride = calendarView.frame.width * CGFloat(indexPath.section)
        return CGRect(x: stride + 5, y: 5, width: calendarView.frame.width - 10, height: calendarView.frame.height - 10)
    }
}

