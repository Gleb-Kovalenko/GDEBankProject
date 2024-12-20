//
//  DXCalendarViewController.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 03.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import FSCalendar
import Foundation
import UIKit
import ComposableArchitecture
import Combine
import Layout

// MARK: - DXCalendarViewController

/// A customizable calendar view with a header that allows date selection within a specified range.
public class DXCalendarViewController: UIViewController {
    
    // MARK: - Properties
    
    /// The store powering the view controller
    public let store: StoreOf<DXCalendar>
    
    /// Calendar instance
    private let calendar = FSCalendar()
    
    // MARK: Initialization
    
    /// Creates a new store view controller with the given store
    ///
    /// - Parameter store: The store to use with the view controller
    ///
    /// - Returns: A new view controller.
    public init(store: StoreOf<DXCalendar>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    // MARK: - View Lifecycle
    
    /// Called after the controller's view is loaded into memory. Sets up the calendar view and its appearance.
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        /// Initialize the calendar
        calendar.delegate = self
        calendar.dataSource = self
        
        /// Customize appearance
        calendar.backgroundColor = .clear
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = Colors.textDefault.color
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = .clear
        calendar.appearance.titleDefaultColor = Colors.textDefault.color
        calendar.appearance.weekdayTextColor = Colors.textDefault.color
        calendar.appearance.weekdayFont = .inter(size: 14, weight: .medium)
        calendar.appearance.titleFont = .inter(size: 14, weight: .medium)
        
        /// Setup header view
        let headerView = DXCalendarHeaderView(
            calendar: calendar,
            maxDate: store.maximumDate,
            minDate: store.minimumDate
        )
        calendar.calendarHeaderView = headerView
        calendar.headerHeight = 60
        calendar.addSubview(headerView)
        
        /// Set up constraints
        view.addSubview(calendar.prepareForAutolayout())
        calendar.fullPin(to: view, withInsets: .zero)
        
        /// Register cell
        calendar.register(DXCalendarCell.self, forCellReuseIdentifier: DXCalendarCell.reusableIdentifier)
        
        observe { [weak self] in
            guard let self else { return }
            self.observe(store: store)
        }
    }
    
    public func observe(store: StoreOf<DXCalendar>) {
        if let defaultDate = store.defaultSelectedDate {
            calendar.setCurrentPage(defaultDate, animated: true)
            calendar.select(defaultDate, scrollToDate: true)
        }
        calendar.locale = store.language.locale
        (calendar.calendarHeaderView as? DXCalendarHeaderView)?.update(
            with: calendar.currentPage,
            maximumDate: store.maximumDate,
            minimumDate: store.minimumDate
        )
    }
}

// MARK: - FSCalendarDelegate

extension DXCalendarViewController: FSCalendarDelegate {
    
    /// Provides the fill color for the selected date.
    public func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        Colors.control1.color
    }
    
    /// Provides the border radius for the selected date.
    public func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        0.6
    }
    
    /// Called when the current calendar page changes. Updates the header view with the new date.
    public func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        (calendar.calendarHeaderView as? DXCalendarHeaderView)?.update(
            with: calendar.currentPage
        )
    }
}

// MARK: - FSCalendarDelegateAppearance

extension DXCalendarViewController: FSCalendarDelegateAppearance {
    
    /// Called when a date is selected in the calendar. Triggers the date selection action.
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        store.send(.onDateSelection(date))
    }
    
    public func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: DXCalendarCell.reusableIdentifier, for: date, at: position)
        return cell
    }
}

extension DXCalendarViewController: FSCalendarDataSource {
    
    /// Provides the minimum selectable date for the calendar.
    public func minimumDate(for calendar: FSCalendar) -> Date {
        store.minimumDate
    }
    
    /// Provides the maximum selectable date for the calendar.
    public func maximumDate(for calendar: FSCalendar) -> Date {
        store.maximumDate
    }
}

// MARK: - DXCalendarHeaderView

/// A custom header view for the calendar that displays the current month and year, and provides navigation buttons.
private class DXCalendarHeaderView: FSCalendarHeaderView {
    
    // MARK: - Properties
    
    /// The date formatter used to format the month and year displayed in the header.
    private let dateFormatter: DateFormatter
    
    // MARK: - Subviews

    /// The label that displays the current month and year.
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .inter(size: 16, weight: .medium)
        label.textColor = Colors.textDefault.color
        label.textAlignment = .left
        return label
    }()
    
    /// The button used to navigate to the previous month.
    private let leftArrowButton = arrowButton(with: Assets.chevronLeft.name)
    
    /// The button used to navigate to the next month.
    private let rightArrowButton = arrowButton(with: Assets.chevronRight.name)
    
    // MARK: - Initializers

    /// Initializes a `DXCalendarHeaderView` with the associated calendar.
    ///
    /// - Parameter calendar: The calendar associated with this header view.
    init(calendar: FSCalendar, maxDate: Date, minDate: Date) {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        super.init(frame: .zero)
        self.calendar = calendar
        self.scrollEnabled = calendar.scrollEnabled
        setup()
        update(with: calendar.currentPage, maximumDate: maxDate, minimumDate: minDate)
    }

    /// This initializer is required by the superclass but is not used in this context.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update

    /// Updates the header view with the given date.
    ///
    /// - Parameter date: The date to display in the header view.
    public func update(with date: Date, maximumDate: Date? = nil, minimumDate: Date? = nil) {
        titleLabel.text = dateFormatter.string(from: date).uppercasedFirstLetter()
        let calendar = Calendar.current
        let maximumDate = maximumDate ?? self.calendar.maximumDate
        let minimumDate = minimumDate ?? self.calendar.minimumDate
        let currentDate = calendar.dateComponents([.year, .month], from: date)
        let minDate = calendar.dateComponents([.year, .month], from: minimumDate)
        let maxDate = calendar.dateComponents([.year, .month], from: maximumDate)
        guard let currentYear = currentDate.year,
              let currentMonth = currentDate.month,
              let minYear = minDate.year,
              let minMonth = minDate.month,
              let maxYear = maxDate.year,
              let maxMonth = maxDate.month else {
            return
        }
        let previousMonthAvailable = (currentYear > minYear) || (currentYear == minYear && currentMonth > minMonth)
        let nextMonthAvailable = (currentYear < maxYear) || (currentYear == maxYear && currentMonth < maxMonth)
        leftArrowButton.isEnabled = previousMonthAvailable
        rightArrowButton.isEnabled = nextMonthAvailable
    }
    
    // MARK: - Private
    
    private static func arrowButton(with imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        configuration.imagePadding = 8
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 16)
        button.configuration = configuration
        button.contentHorizontalAlignment = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.configurationUpdateHandler = { button in
            switch button.state {
            case .highlighted, .selected, .disabled:
                button.configuration?.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate).withTintColor(Colors.gray2.color)
            default:
                button.configuration?.image = UIImage(named: imageName)
            }
        }
        return button
    }
    
    // MARK: - Actions

    /// Called when the left arrow button is tapped. Navigates to the previous month.
    @objc private func didTapLeftArrow() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: calendar.currentPage) {
            setCalendarPage(date: newDate)
        }
    }

    /// Called when the right arrow button is tapped. Navigates to the next month.
    @objc private func didTapRightArrow() {
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: calendar.currentPage) {
            setCalendarPage(date: newDate)
        }
    }
    
    /// Sets the calendar's current page to the specified date and updates the header view.
    ///
    /// - Parameter date: The date to set as the calendar's current page.
    private func setCalendarPage(date: Date) {
        calendar.setCurrentPage(date, animated: true)
        update(with: calendar.currentPage)
    }
}

// MARK: - Layout

extension DXCalendarHeaderView {
    
    /// Sets up the layout and constraints for the header view's subviews.
    private func setup() {
        setupTitle()
        setupButtons()
    }
    
    /// Sets up the layout and constraints for the title label.
    private func setupTitle() {
        addSubview(titleLabel.prepareForAutolayout())
        titleLabel
            .left(to: left + 8)
            .centerY(to: centerY)
        titleLabel.text = dateFormatter.string(from: Date())
    }
    
    /// Sets up the layout and constraints for the navigation buttons.
    private func setupButtons() {
        
        leftArrowButton.addTarget(self, action: #selector(didTapLeftArrow), for: .touchUpInside)
        rightArrowButton.addTarget(self, action: #selector(didTapRightArrow), for: .touchUpInside)
        
        addSubview(leftArrowButton.prepareForAutolayout())
        addSubview(rightArrowButton.prepareForAutolayout())
        
        leftArrowButton
            .right(to: rightArrowButton.left - 8)
            .centerY(to: centerY)
            .size(40)
        rightArrowButton
            .right(to: right)
            .centerY(to: centerY)
            .size(40)
    }
}

// MARK: - DXCalendarCell

private class DXCalendarCell: FSCalendarCell {
    
    // MARK: - Reuse
    
    public static var reusableIdentifier: String {
        String(describing: self)
    }
    
    // MARK: - Overriding
    
    override func performSelecting() {
        configureAppearance()
    }
}
