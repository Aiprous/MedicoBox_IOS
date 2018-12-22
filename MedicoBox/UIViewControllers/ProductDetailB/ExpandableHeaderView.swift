//
//  ExpandableHeaderView.swift
//  TableViewDropDown
//
//  Created by BriefOS on 5/3/17.
//  Copyright © 2017 BriefOS. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    var img = UIImageView()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        
        delegate?.toggleSection(header: self, section: cell.section)
        img.image = #imageLiteral(resourceName: "up-arrow-yellow");
    }
    
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
//        let width: CGFloat = textLabel?.frame.size.width ?? 0;
        img = UIImageView(frame: CGRect(x: 325, y: 12, width: 25, height: 25))
        img.image = #imageLiteral(resourceName: "downArrow_yellow");
        self.addSubview(img);
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.black
        self.contentView.backgroundColor = UIColor.white
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
