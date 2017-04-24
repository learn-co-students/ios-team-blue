import UIKit

class AddDietView: UIView {

    var diet: UILabel!
    var allergies: UILabel!
    var pescetarian: UIButton!
    var veg: UIButton!
    var vegan: UIButton!
    var paleo: UIButton!
    var save: UIButton!
    var dairy: UIButton!
    var egg: UIButton!
    var gluten: UIButton!
    var peanut: UIButton!
    var sesame: UIButton!
    var seafood: UIButton!
    var shellfish: UIButton!
    var soy: UIButton!
    var sulfite: UIButton!
    var treeNut: UIButton!
    var wheat: UIButton!

    var delegate: AddDietDelegate!

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
        createLabels()
        createDiets()
        createAllergies()
        createSaveButton()
    }

    func createBackground() {
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }


    func createLabels() {
        diet = UILabel()
        diet.text = "Dietary Restrictions"
        diet.font = UIFont(name: "ArialMT", size: 20)
        self.addSubview(diet)
        diet.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }

        allergies = UILabel()
        allergies.text = "Allergies"
        allergies.font = UIFont(name: "ArialMT", size: 20)
        self.addSubview(allergies)
        allergies.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
        }
    }

    func createDiets() {
        //Dietary Retrictions
        pescetarian = UIButton()
        veg = UIButton()
        vegan = UIButton()
        paleo = UIButton()
        self.addSubview(pescetarian)
        self.addSubview(veg)
        self.addSubview(vegan)
        self.addSubview(paleo)
        pescetarian.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        veg.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        vegan.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)
        paleo.addTarget(self, action: #selector(dietButtonTapped), for: .touchUpInside)

        pescetarian.backgroundColor = Colors.flatironBlue
        pescetarian.setTitle(" Pescetarian + ", for: .normal)
        pescetarian.setTitle(" Pescetarian ", for: .selected)
        pescetarian.layer.cornerRadius = 8
        pescetarian.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(1.5)
            make.top.equalTo(diet.snp.bottom).offset(10)
        }
        veg.backgroundColor = Colors.flatironBlue
        veg.setTitle(" Vegetarian + ", for: .normal)
        veg.setTitle(" Vegetarian ", for: .selected)
        self.addSubview(veg)
        veg.layer.cornerRadius = 8
        veg.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-1.5)
            make.top.equalTo(diet.snp.bottom).offset(10)
        }
        vegan.backgroundColor = Colors.flatironBlue
        vegan.setTitle(" Vegan + ", for: .normal)
        vegan.setTitle(" Vegan ", for: .selected)
        self.addSubview(vegan)
        vegan.layer.cornerRadius = 8
        vegan.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-1.5)
            make.top.equalTo(pescetarian.snp.bottom).offset(3)
        }

        paleo.backgroundColor = Colors.flatironBlue
        paleo.setTitle(" Paleo + ", for: .normal)
        paleo.setTitle(" Paleo ", for: .selected)
        self.addSubview(paleo)
        paleo.layer.cornerRadius = 8
        paleo.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(1.5)
            make.top.equalTo(pescetarian.snp.bottom).offset(3)
        }
    }

    func createAllergies() {

        //Allergies
        dairy = UIButton()
        egg = UIButton()
        gluten = UIButton()
        peanut = UIButton()
        sesame = UIButton()
        seafood = UIButton()
        shellfish = UIButton()
        soy = UIButton()
        sulfite = UIButton()
        treeNut = UIButton()
        wheat = UIButton()
        self.addSubview(dairy)
        self.addSubview(egg)
        self.addSubview(gluten)
        self.addSubview(peanut)
        self.addSubview(sesame)
        self.addSubview(seafood)
        self.addSubview(shellfish)
        self.addSubview(soy)
        self.addSubview(sulfite)
        self.addSubview(treeNut)
        self.addSubview(wheat)
        dairy.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        egg.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        gluten.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        peanut.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        sesame.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        seafood.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        shellfish.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        soy.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        sulfite.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        treeNut.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)
        wheat.addTarget(self, action: #selector(allergyButtonTapped), for: .touchUpInside)

        egg.backgroundColor = Colors.flatironBlue
        egg.setTitle(" Egg + ", for: .normal)
        egg.setTitle(" Egg ", for: .selected)
        egg.layer.cornerRadius = 8
        egg.snp.makeConstraints { (make) in
            make.right.equalTo(wheat.snp.left).offset(-1.5)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }
        wheat.backgroundColor = Colors.flatironBlue
        wheat.setTitle(" Wheat + ", for: .normal)
        wheat.setTitle(" Wheat ", for: .selected)
        wheat.layer.cornerRadius = 8
        wheat.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(8.5)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }
        soy.backgroundColor = Colors.flatironBlue
        soy.setTitle(" Soy + ", for: .normal)
        soy.setTitle(" Soy ", for: .selected)
        soy.layer.cornerRadius = 8
        soy.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(10.5)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }
        dairy.backgroundColor = Colors.flatironBlue
        dairy.setTitle(" Dairy + ", for: .normal)
        dairy.setTitle(" Dairy ", for: .selected)
        dairy.layer.cornerRadius = 8
        dairy.snp.makeConstraints { (make) in
            make.left.equalTo(soy.snp.right).offset(1.5)
            make.top.equalTo(allergies.snp.bottom).offset(10)
        }

        sesame.backgroundColor = Colors.flatironBlue
        sesame.setTitle(" Sesame + ", for: .normal)
        sesame.setTitle(" Sesame ", for: .selected)
        sesame.layer.cornerRadius = 8
        sesame.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dairy.snp.bottom).offset(3)
        }
        peanut.backgroundColor = Colors.flatironBlue
        peanut.setTitle(" Peanut + ", for: .normal)
        peanut.setTitle(" Peanut ", for: .selected)
        peanut.layer.cornerRadius = 8
        peanut.snp.makeConstraints { (make) in
            make.right.equalTo(sesame.snp.left).offset(-3)
            make.top.equalTo(dairy.snp.bottom).offset(3)
        }
        gluten.backgroundColor = Colors.flatironBlue
        gluten.setTitle(" Gluten + ", for: .normal)
        gluten.setTitle(" Gluten ", for: .selected)
        gluten.layer.cornerRadius = 8
        gluten.snp.makeConstraints { (make) in
            make.left.equalTo(sesame.snp.right).offset(3)
            make.top.equalTo(dairy.snp.bottom).offset(3)
        }

        shellfish.backgroundColor = Colors.flatironBlue
        shellfish.setTitle(" Shellfish + ", for: .normal)
        shellfish.setTitle(" Shellfish ", for: .selected)
        shellfish.layer.cornerRadius = 8
        shellfish.snp.makeConstraints { (make) in
            make.right.equalTo(sulfite.snp.left).offset(-3)
            make.top.equalTo(sesame.snp.bottom).offset(3)
        }
        sulfite.backgroundColor = Colors.flatironBlue
        sulfite.setTitle(" Sulfite + ", for: .normal)
        sulfite.setTitle(" Sulfite ", for: .selected)
        sulfite.layer.cornerRadius = 8
        sulfite.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(sesame.snp.bottom).offset(3)
        }
        treeNut.backgroundColor = Colors.flatironBlue
        treeNut.setTitle(" Tree Nut + ", for: .normal)
        treeNut.setTitle(" Tree Nut ", for: .selected)
        treeNut.layer.cornerRadius = 8
        treeNut.snp.makeConstraints { (make) in
            make.left.equalTo(sulfite.snp.right).offset(3)
            make.top.equalTo(sesame.snp.bottom).offset(3)
        }

        seafood.backgroundColor = Colors.flatironBlue
        seafood.setTitle(" Seafood + ", for: .normal)
        seafood.setTitle(" Seafood ", for: .selected)
        seafood.layer.cornerRadius = 8
        seafood.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(sulfite.snp.bottom).offset(3)
        }
        
    }

    func createSaveButton() {
        save = UIButton()
        self.addSubview(save)
        save.backgroundColor = .white
        save.layer.cornerRadius = 8
        save.layer.borderColor = Colors.flatironBlue.cgColor
        save.layer.borderWidth = CGFloat(1)
        save.setTitle(" Save and Close ", for: .normal)
        save.setTitleColor(Colors.flatironBlue, for: .normal)
        save.titleLabel?.font = UIFont(name: "ArialMT", size: 20)
        save.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        save.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    //TODO: - persist button selections so that user sees thier preferences upon re opening page
    func dietButtonTapped(_ button: UIButton) {
        self.delegate.dietButtonTapped(button)
    }
    func saveButtonTapped() {
        self.delegate.saveButtonTapped()
    }

    func allergyButtonTapped(_ button: UIButton) {
        self.delegate.allergyButtonTapped(button)
    }
}
