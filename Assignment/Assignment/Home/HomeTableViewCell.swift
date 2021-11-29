import UIKit

// MARK: HomeTableViewCell
final class HomeTableViewCell: UITableViewCell {
    
    /// private variables
    private let label = UILabel()
    private let time = UILabel()
    
    /// Initializer
    /// - Parameters:
    ///   - style: cell style
    ///   - reuseIdentifier: resuable identifier
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureSubview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Update
    /// - Parameters:
    ///   - label: label data
    ///   - time: time data
    func update(label: String, time: String) {
        self.label.text = label
        self.time.text = time
    }
    
    /// Cell configuration
    private func configureSubview() {
        label.numberOfLines = 0
        time.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        time.font = UIFont.systemFont(ofSize: 15)
        time.textColor = .gray
        let stackView = UIStackView(arrangedSubviews: [label, time])
        stackView.axis = .vertical
        stackView.spacing = 8

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
        ])
    }
}
