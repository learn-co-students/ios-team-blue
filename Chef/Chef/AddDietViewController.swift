import UIKit
import SnapKit

class AddDietViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createSettings()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createSettings() {
        view.backgroundColor = UIColor()
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)

        let diet = UILabel()
        diet.text = "Dietary Restrictions"
        diet.font = UIFont(name: "ArialMT", size: 20.0)

        view.addSubview(diet)
        diet.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }

        let allergies = UILabel()
        allergies.text = "Allergies"
        allergies.font = UIFont(name: "ArialMT", size: 20.0)
        view.addSubview(allergies)
        allergies.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
        }

        //Allergies
        let dairy = UIButton()
        let egg = UIButton()
        let gluten = UIButton()
        let peanut = UIButton()
        let sesame = UIButton()
        let seafood = UIButton()
        let shellfish = UIButton()
        let soy = UIButton()
        let sulfite = UIButton()
        let treeNut = UIButton()
        let wheat = UIButton()
        view.addSubview(dairy)
        view.addSubview(egg)
        view.addSubview(gluten)
        view.addSubview(peanut)
        view.addSubview(sesame)
        view.addSubview(seafood)
        view.addSubview(shellfish)
        view.addSubview(soy)
        view.addSubview(sulfite)
        view.addSubview(treeNut)
        view.addSubview(wheat)
        dairy.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        egg.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        gluten.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        peanut.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        sesame.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        seafood.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        shellfish.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        soy.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        sulfite.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        treeNut.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        wheat.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)


        //Allergies Button setup
        dairy.backgroundColor = Style.flatironBlue
        dairy.setTitle(" Dairy + ", for: .normal)
        dairy.setTitle(" Dairy ", for: .selected)
        dairy.layer.cornerRadius = 8
        dairy.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }
        egg.backgroundColor = Style.flatironBlue
        egg.setTitle(" Egg + ", for: .normal)
        egg.setTitle(" Egg ", for: .selected)
        egg.layer.cornerRadius = 8
        egg.snp.makeConstraints { (make) in
            make.left.equalTo(dairy.snp.right).offset(3)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }
        gluten.backgroundColor = Style.flatironBlue
        gluten.setTitle(" Gluten + ", for: .normal)
        gluten.setTitle(" Gluten ", for: .selected)
        gluten.layer.cornerRadius = 8
        gluten.snp.makeConstraints { (make) in
            make.left.equalTo(egg.snp.right).offset(3)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }
        peanut.backgroundColor = Style.flatironBlue
        peanut.setTitle(" Peanut + ", for: .normal)
        peanut.setTitle(" Peanut ", for: .selected)
        peanut.layer.cornerRadius = 8
        peanut.snp.makeConstraints { (make) in
            make.left.equalTo(gluten.snp.right).offset(3)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }

        sesame.backgroundColor = Style.flatironBlue
        sesame.setTitle(" Sesame + ", for: .normal)
        sesame.setTitle(" sesame ", for: .selected)
        sesame.layer.cornerRadius = 8
        sesame.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(dairy.snp.bottom).offset(3)
        }
        seafood.backgroundColor = Style.flatironBlue
        seafood.setTitle(" Seafood + ", for: .normal)
        seafood.setTitle(" Seafood ", for: .selected)
        seafood.layer.cornerRadius = 8
        seafood.snp.makeConstraints { (make) in
            make.left.equalTo(sesame.snp.right).offset(3)
            make.top.equalTo(dairy.snp.bottom).offset(3)
        }
        soy.backgroundColor = Style.flatironBlue
        soy.setTitle(" Soy + ", for: .normal)
        soy.setTitle(" Soy ", for: .selected)
        soy.layer.cornerRadius = 8
        soy.snp.makeConstraints { (make) in
            make.left.equalTo(seafood.snp.right).offset(3)
            make.top.equalTo(dairy.snp.bottom).offset(3)
        }
        wheat.backgroundColor = Style.flatironBlue
        wheat.setTitle(" Wheat + ", for: .normal)
        wheat.setTitle(" Wheat ", for: .selected)
        wheat.layer.cornerRadius = 8
        wheat.snp.makeConstraints { (make) in
            make.left.equalTo(soy.snp.right).offset(3)
            make.top.equalTo(dairy.snp.bottom).offset(3)
        }

        shellfish.backgroundColor = Style.flatironBlue
        shellfish.setTitle(" Shellfish + ", for: .normal)
        shellfish.setTitle(" Shellfish ", for: .selected)
        shellfish.layer.cornerRadius = 8
        shellfish.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(wheat.snp.bottom).offset(3)
        }
        sulfite.backgroundColor = Style.flatironBlue
        sulfite.setTitle(" Sulfite + ", for: .normal)
        sulfite.setTitle(" Sulfite ", for: .selected)
        sulfite.layer.cornerRadius = 8
        sulfite.snp.makeConstraints { (make) in
            make.left.equalTo(shellfish.snp.right).offset(3)
            make.top.equalTo(wheat.snp.bottom).offset(3)
        }
        treeNut.backgroundColor = Style.flatironBlue
        treeNut.setTitle(" Tree Nut + ", for: .normal)
        treeNut.setTitle(" Tree Nut ", for: .selected)
        treeNut.layer.cornerRadius = 8
        treeNut.snp.makeConstraints { (make) in
            make.left.equalTo(shellfish.snp.right).offset(3)
            make.top.equalTo(wheat.snp.bottom).offset(3)
        }


        //Dietary Retrictions
        let pescetarian = UIButton()
        let veg = UIButton()
        let vegan = UIButton()
        let lveg = UIButton()
        let oveg = UIButton()
        view.addSubview(pescetarian)
        view.addSubview(veg)
        view.addSubview(vegan)
        view.addSubview(lveg)
        view.addSubview(oveg)
        pescetarian.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        veg.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        vegan.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        lveg.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        oveg.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)

        pescetarian.backgroundColor = Style.flatironBlue
        pescetarian.setTitle(" Pescetarian + ", for: .normal)
        pescetarian.setTitle(" Pescetarian ", for: .selected)
        pescetarian.layer.cornerRadius = 8
        pescetarian.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(diet.snp.bottom).offset(10)
        }

        veg.backgroundColor = Style.flatironBlue
        veg.setTitle(" Vegetarian + ", for: .normal)
        veg.setTitle(" Vegetarian ", for: .selected)
        view.addSubview(veg)
        veg.layer.cornerRadius = 8
        veg.snp.makeConstraints { (make) in
            make.left.equalTo(pescetarian.snp.right).offset(3)
            make.top.equalTo(pescetarian.snp.top)
        }

        vegan.backgroundColor = Style.flatironBlue
        vegan.setTitle(" Vegan + ", for: .normal)
        vegan.setTitle(" Vegan ", for: .selected)
        view.addSubview(vegan)
        vegan.layer.cornerRadius = 8
        vegan.snp.makeConstraints { (make) in
            make.left.equalTo(veg.snp.right).offset(3)
            make.top.equalTo(pescetarian.snp.top)
        }

        lveg.backgroundColor = Style.flatironBlue
        lveg.setTitle(" Lacto Vegetarian + ", for: .normal)
        lveg.setTitle(" Lacto Vegetarian ", for: .selected)
        view.addSubview(lveg)
        lveg.layer.cornerRadius = 8
        lveg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(pescetarian.snp.bottom).offset(3)
        }

        oveg.backgroundColor = Style.flatironBlue
        oveg.setTitle(" Ovo Vegetarian + ", for: .normal)
        oveg.setTitle(" Ovo Vegetarian ", for: .selected)
        view.addSubview(oveg)
        oveg.layer.cornerRadius = 8
        oveg.snp.makeConstraints { (make) in
            make.left.equalTo(lveg.snp.right).offset(3)
            make.top.equalTo(lveg.snp.top)
        }
        

    }

    func dietButtonTapped(_ button: UIButton) {

        if button.isSelected {
            button.isSelected = false
            animate(button)
        } else {
            button.isSelected = true
            animate(button)
        }

//        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
//            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.9)
//        }) { (_) in
//            UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: .curveLinear, animations: {
//                button.transform = CGAffineTransform.identity
//            })
//        }



    }

    func animate(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (finished) in
            UIView.animate(withDuration: 0.1, animations: {
                button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }


    func saveButtonTapped() {

    }

}
