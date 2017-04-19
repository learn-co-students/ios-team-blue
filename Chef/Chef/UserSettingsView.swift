import Foundation
import UIKit
import SnapKit

class UserSettingsView: UIView {

    var delegate: UserSettingsDelegate!
    var diet: UIButton!
    var logOut: UIButton!
    var resetData: UIButton!
    var deleteAcct: UIButton!

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
        createDiet()
        createLogOut()
        createResetData()
        createDltAcct()
    }

    func createBackground() {
        self.backgroundColor = .white
        //Edit blur effect here
//        if !UIAccessibilityIsReduceTransparencyEnabled() {
//            self.backgroundColor = Style.flatironBlue
//            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            blurEffectView.frame = self.bounds
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            self.addSubview(blurEffectView)
//        } else {
//            self.backgroundColor = Style.flatironBlue
//        }
    }

    func createDiet() {
        diet = UIButton()
        self.addSubview(diet)
        diet.backgroundColor = .white
        diet.layer.cornerRadius = 8
        diet.layer.borderColor = Style.flatironBlue.cgColor
        diet.layer.borderWidth = CGFloat(3)
        diet.setTitle(" Set Dietary Restrictions ", for: .normal)
        diet.setTitleColor(Style.flatironBlue, for: .normal)
        diet.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        diet.addTarget(self, action: #selector(tapDiet), for: .touchUpInside)
        diet.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.width.equalToSuperview().offset(-150)
        }
    }

    func createLogOut() {
        logOut = UIButton()
        self.addSubview(logOut)
        logOut.backgroundColor = .white
        logOut.layer.cornerRadius = 8
        logOut.layer.borderColor = Style.flatironBlue.cgColor
        logOut.layer.borderWidth = CGFloat(3)
        logOut.setTitle(" Log Out ", for: .normal)
        logOut.setTitleColor(Style.flatironBlue, for: .normal)
        logOut.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        logOut.addTarget(self, action: #selector(tapLogOut), for: .touchUpInside)
        logOut.snp.makeConstraints { (make) in
            make.top.equalTo(diet.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(diet.snp.width)
        }
    }

    func createResetData() {
        resetData = UIButton()
        self.addSubview(resetData)
        resetData.backgroundColor = .white
        resetData.layer.cornerRadius = 8
        resetData.layer.borderColor = Style.flatironBlue.cgColor
        resetData.layer.borderWidth = CGFloat(3)
        resetData.setTitle(" Reset Data ", for: .normal)
        resetData.setTitleColor(UIColor(red:0.81, green:0.19, blue:0.19, alpha:1.0), for: .normal)
        resetData.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        resetData.addTarget(self, action: #selector(tapResetData), for: .touchUpInside)
        resetData.snp.makeConstraints { (make) in
            make.top.equalTo(logOut.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(diet.snp.width)
        }
    }

    func createDltAcct() {
        deleteAcct = UIButton()
        self.addSubview(deleteAcct)
        deleteAcct.backgroundColor = .white
        deleteAcct.layer.cornerRadius = 8
        deleteAcct.layer.borderColor = Style.flatironBlue.cgColor
        deleteAcct.layer.borderWidth = CGFloat(3)
        deleteAcct.setTitle(" Delete Account ", for: .normal)
        deleteAcct.setTitleColor(UIColor(red:0.81, green:0.19, blue:0.19, alpha:1.0), for: .normal)
        deleteAcct.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        deleteAcct.addTarget(self, action: #selector(tapDeleteAcct), for: .touchUpInside)
        deleteAcct.snp.makeConstraints { (make) in
            make.top.equalTo(resetData.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(diet.snp.width)
        }
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
