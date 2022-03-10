//
//  ViewController.swift
//  DropdownPlayground
//
//  Created by Vitalii Azarov on 2022-03-10.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    
    enum LandingScreenMoreMenuAction {
        case assignAll
        case unassignAll
        case exportHoles
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func didMenuOpenned(_ sender: UIButton) {
        showMoreMenu()
    }
        
    lazy var moreMenu: DropDown<LandingScreenMoreMenuAction> = {
        let dd = DropDown<LandingScreenMoreMenuAction>()
        dd.backgroundColor = UIColor.white
        dd.selectionBackgroundColor = UIColor.white
        dd.anchorView = menuButton.plainView
        dd.direction = .bottom
        dd.bottomOffset = CGPoint(x: -150, y: 40)
        dd.width = 175
        dd.customCellConfiguration = { [unowned self] (_, rowAction, cell) in
            let isOffline: Bool = true
            func setText(_ str: String, disabled: Bool) {
                if disabled {
                    let astr = NSAttributedString(string: str, attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.3)])
                    cell.optionLabel.attributedText = astr
                } else {
                    cell.optionLabel.text = str
                }
            }
            switch rowAction {
            case .assignAll:
                let unassignedHoleCount = 2
                let str = "Assign \(unassignedHoleCount) drill collar"
                setText(str, disabled: isOffline || unassignedHoleCount == 0 || true)
            case .unassignAll:
                let assignedHoleCount = 3
                let str = "Unassign \(assignedHoleCount) collars"
                setText(str, disabled: isOffline || assignedHoleCount == 0 || true)
            case .exportHoles:
                let collarCount = 1
                let str = "Export \(collarCount)"
                setText(str, disabled: collarCount < 1 || true)
            }
        }
        return dd
    }()
    
    func showMoreMenu() {
        moreMenu.dataSource = [.assignAll, .unassignAll, .exportHoles]
        moreMenu.show()
    }
}

