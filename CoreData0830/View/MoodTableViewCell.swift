//
//  MoodTableViewCell.swift
//  CoreData0830
//
//  Created by leslie on 9/4/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class MoodTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        formatter.formattingContext = .standalone
        return formatter
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MoodTableViewCell {
    func configure(for mood: Mood) {
        nameLbl.text = mood.name
        dateLbl.text = dateFormatter.string(from: mood.date!)
    }
}
