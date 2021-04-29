import UIKit

class VenueTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
}

extension VenueTableViewCell: VenueCellView {
    func updateView(with venue: Venue) {
        nameLabel.text = venue.name
        addressLabel.text = venue.location?.address
        distanceLabel.text = "Distance: \(venue.location?.distance ?? 0)m"
    }
}
