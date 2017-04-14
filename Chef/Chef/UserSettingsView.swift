import Foundation
import UIKit
import SnapKit

class UserSettingsView: UIView {

    var delegate: UserSettingsDelegate!
    var heading: UILabel!
    var diet: UILabel!
    var logOut: UILabel!
    var resetData: UILabel!
    var deleteAcct: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    
    func commonInit() {
        createBackground()
        createHeading()
        createDiet()
        createLogOut()
        createResetData()
        createDltAcct()
    }


    func createBackground() {
//        let imageView = UIImageView(image: UIImage(named: "food-background"))
//        self.addSubview(imageView)
//        imageView.snp.makeConstraints { (make) in
//            make.height.width.equalToSuperview()
//        }
        //Edit blur effect here
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.backgroundColor = UIColor.white
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(blurEffectView)
        } else {
            self.backgroundColor = .darkGray
        }
    }

    func createHeading() {
        heading = UILabel()
        self.addSubview(heading)
        heading.text = "User Settings"
        heading.textColor = .white
        heading.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 40)
        heading.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
    }

    func createDiet() {
        diet = UILabel()
        self.addSubview(diet)
        diet.font = UIFont(name: "HelveticaNeue", size: 30)
        diet.textColor = .white
        diet.text = "Set Dietary Restrictions"
        let dietGest = UITapGestureRecognizer(target: self, action: #selector(tapDiet))
        self.diet.isUserInteractionEnabled = true
        self.diet.addGestureRecognizer(dietGest)
        diet.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(heading.snp.bottom).offset(10)
        }
    }

    func createLogOut() {
        logOut = UILabel()
        self.addSubview(logOut)
        logOut.text = "Log out"
        logOut.font = UIFont(name: "HelveticaNeue", size: 30)
        logOut.textColor = .white
        logOut.snp.makeConstraints { (make) in
            make.top.equalTo(diet.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        let logoutGest = UITapGestureRecognizer(target: self, action: #selector(tapLogOut))
        self.logOut.isUserInteractionEnabled = true
        self.logOut.addGestureRecognizer(logoutGest)
    }

    func createResetData() {
        resetData = UILabel()
        self.addSubview(resetData)
        resetData.font = UIFont(name: "HelveticaNeue", size: 30)
        resetData.textColor = .red
        resetData.text = "Reset Data"
        resetData.snp.makeConstraints { (make) in
            make.top.equalTo(logOut.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        let resetDataGest = UITapGestureRecognizer(target: self, action: #selector(tapResetData))
        self.resetData.isUserInteractionEnabled = true
        self.resetData.addGestureRecognizer(resetDataGest)
    }

    func createDltAcct() {
        deleteAcct = UILabel()
        self.addSubview(deleteAcct)
        deleteAcct.font = UIFont(name: "HelveticaNeue", size: 30)
        deleteAcct.textColor = .red
        deleteAcct.text = "Delete account"
        deleteAcct.snp.makeConstraints { (make) in
            make.top.equalTo(resetData.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        let deleteAcctGest = UITapGestureRecognizer(target: self, action: #selector(tapDeleteAcct))
        self.deleteAcct.isUserInteractionEnabled = true
        self.deleteAcct.addGestureRecognizer(deleteAcctGest)
    }
    

    func tapDiet() {
        self.delegate.tapDiet()
    }

    func tapLogOut() {
        self.delegate.tapLogOut()
    }

    func tapResetData() {
        self.delegate.tapResetData()
    }

    func tapDeleteAcct() {
        self.delegate.tapDeleteAcct()
    }

}
