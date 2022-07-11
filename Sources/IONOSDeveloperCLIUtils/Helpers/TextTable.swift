import Foundation

struct TextTable {

    var header: String?

    private let columnFence = "|"
    private let rowFence = "-"
    private let cornerFence = "+"
    private var columns: [TextTableColumn]

    init(columns: [TextTableColumn], header: CustomStringConvertible? = nil) {
        self.columns = columns
        self.header = header?.description
    }

    mutating func addRow(values: [CustomStringConvertible]) {
        let values = values.count >= columns.count ? values :
            values + [CustomStringConvertible](repeating: "", count: columns.count - values.count)
        columns = zip(columns, values).map { (column, value) in
            var column = column
            column.values.append(value.description)
            return column
        }
    }

    mutating func addRows(values: [[CustomStringConvertible]]) {
        for index in 0..<columns.count {
            let columnValues: [String] = values.map { row in index < row.count ? row[index].description : "" }
            columns[index].values.append(contentsOf: columnValues)
        }
    }

    func render() -> String {
        let separator = Self.fence(strings: columns.map({ column in
            return repeatElement(rowFence, count: column.width() + 2).joined()
        }), separator: cornerFence)

        let top = renderTableHeader() ?? separator

        let columnHeaders = Self.fence(
            strings: columns.map({ " \($0.header.withPadding(count: $0.width())) " }),
            separator: columnFence
        )

        let values = columns.isEmpty ? "" : (0..<columns.first!.values.count).map({ rowIndex in
            Self.fence(
                strings: columns.map { " \($0.values[rowIndex].withPadding(count: $0.width())) " },
                separator: columnFence
            )
        }).paragraph()

        return [top, columnHeaders, separator, values, separator].paragraph()
    }

    private func renderTableHeader() -> String? {
        guard let header = header else {
            return nil
        }

        let calculatewidth: (Int, TextTableColumn) -> Int = { $0 + $1.width() + 2 }
        let separator = cornerFence +
            repeatElement(rowFence, count: columns.reduce(0, calculatewidth) + columns.count - 1).joined() +
            cornerFence
        let separatorCount = separator.count
        let title = Self.fence(strings: [" \(header.withPadding(count: separatorCount - 4)) "], separator: columnFence)

        return [separator, title, separator].paragraph()
    }

    private static func fence(strings: [String], separator: String) -> String {
        separator + strings.joined(separator: separator) + separator
    }

}

struct TextTableColumn {

   var header: String {
        didSet {
            computeWidth()
        }
    }

    fileprivate var values: [String] = [] {
        didSet {
            computeWidth()
        }
    }

    private var precomputedWidth: Int = 0

    init(header: String) {
        self.header = header
        computeWidth()
    }

    func width() -> Int {
        return precomputedWidth
    }

    private mutating func computeWidth() {
        let valueLengths = [header.strippedLength()] + values.map { $0.strippedLength() }
        if let max = valueLengths.max() {
            precomputedWidth = max
        }
    }

}

private let strippingPattern = "\\\u{001B}\\[([0-9][0-9]?m|[0-9](;[0-9]*)*m)"

// swiftlint:disable:next force_try
private let strippingRegex = try! NSRegularExpression(pattern: strippingPattern, options: [])

private extension String {

    func stripped() -> String {
        strippingRegex.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: count),
            withTemplate: ""
        )
    }

    func withPadding(count: Int) -> String {
        let length = self.strippedLength()

        if length < count {
            return self +
                repeatElement(" ", count: count - length).joined()
        }

        return self
    }

    func strippedLength() -> Int {
        stripped().count
    }

}

private extension Array where Element: CustomStringConvertible {

    func paragraph() -> String {
        self
            .map { $0.description }
            .joined(separator: "\n")
    }

}
