import Foundation

public protocol TextTableRepresentable {

    var columns: [String] { get }

    var rows: [[CustomStringConvertible]] { get }

}

public extension TextTableRepresentable {

    func renderTable(header: CustomStringConvertible? = nil) -> String {
        let columns = self.columns.map(TextTableColumn.init(header:))
        var table = TextTable(columns: columns, header: header)
        table.addRows(values: rows)
        return table.render()
    }

}

public extension Collection where Element: CustomStringConvertible {

    func renderTable(columnName: String) -> String {
        let columns = [TextTableColumn(header: columnName)]
        var table = TextTable(columns: columns)
        table.addRows(values: map { [$0] })
        return table.render()
    }

}

public extension Collection where Element: CustomStringConvertible, Element: Comparable {

    func renderTable(columnName: String, sorted: Bool = true) -> String {
        let columns = [TextTableColumn(header: columnName)]
        var table = TextTable(columns: columns)

        if sorted {
            table.addRows(values: self.sorted().map { [$0] })
        } else {
            table.addRows(values: map { [$0] })
        }

        return table.render()
    }

}
