import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let mainLabel:UILabel
    let subLabel:UILabel
    let tableInput:UITextField
    let multiplierInput:UITextField
    let normalMode: UISwitch
    let normalLabel: UILabel
    let randomMode: UISwitch
    let randomLabel: UILabel
    let startButton: UIButton
    var modes: [UISwitch] = []
    var currentMode:String {
        get {
            if let mode = UserDefaults.standard.value(forKey: "mode") as? String {
                return mode
            } else {
                return "normal"
            }
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "mode")
        }
    }
    var currentTable:Int {
        get {
            if let table = UserDefaults.standard.value(forKey: "table") as? Int {
                return table
            }else{
                return 0
            }
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "table")
        }
    }
    var currentMultiplier:Int {
        get {
            if let multiplier = UserDefaults.standard.value(forKey: "multiplier") as? Int {
                return multiplier
            }else{
                return 0
            }
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "multiplier")
        }
    }
    
    convenience init() {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        mainLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "James McClay's Times Tables!"
            //label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            label.adjustsFontForContentSizeCategory = true
            return label
        }()
        subLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Enter a table to practice,\n or blank for all:"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .title2)
            label.adjustsFontForContentSizeCategory = true
            return label
        }()
        tableInput = {
            let input = UITextField()
            input.translatesAutoresizingMaskIntoConstraints = false
            input.placeholder = "All Tables"
            input.borderStyle = .bezel
            input.keyboardType = .numberPad
            return input
        }()
        multiplierInput = {
            let input = UITextField()
            input.translatesAutoresizingMaskIntoConstraints = false
            input.placeholder = "Max Multiplier (12)"
            input.borderStyle = .bezel
            input.keyboardType = .numberPad
            return input
        }()
        normalMode = {
            let mode = UISwitch()
            mode.translatesAutoresizingMaskIntoConstraints = false
            mode.tag = 0
            return mode
        }()
        normalLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Normal Mode"
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
            return label
        }()
        randomMode = {
            let mode = UISwitch()
            mode.translatesAutoresizingMaskIntoConstraints = false
            mode.tag = 1
            return mode
        }()
        randomLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Random Mode"
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
            return label
        }()
        startButton = {
            let button = UIButton(type: .system) as UIButton
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
            button.titleLabel?.adjustsFontForContentSizeCategory = true
            button.setTitle("Start!", for: .normal)
            return button
        }()
        super.init(coder: aDecoder)
        modes = [normalMode, randomMode]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = true
        setupLabels()
        setupInputs()
        setupModes()
        setupStartButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController!.navigationBar.isHidden = true
    }
    
    func setupLabels() {
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        mainLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: view.frame.height * 0.1
        ).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        //mainLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        subLabel.topAnchor.constraint(
            equalTo: mainLabel.bottomAnchor,
            constant: view.frame.height * 0.04
        ).isActive = true
        subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupInputs() {
        view.addSubview(tableInput)
        view.addSubview(multiplierInput)
        if currentTable != 0 {
            tableInput.text = String(currentTable)
        }
        if currentMultiplier != 0 {
            multiplierInput.text = String(currentMultiplier)
        }
        tableInput.delegate = self
        multiplierInput.delegate = self
        tableInput.topAnchor.constraint(
            equalTo: subLabel.bottomAnchor,
            constant: view.frame.height * 0.04
        ).isActive = true
        tableInput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        multiplierInput.topAnchor.constraint(
            equalTo: tableInput.bottomAnchor,
            constant: view.frame.height * 0.02
        ).isActive = true
        multiplierInput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        multiplierInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupModes() {
        view.addSubview(normalMode)
        view.addSubview(randomMode)
        view.addSubview(normalLabel)
        view.addSubview(randomLabel)
        
        if currentMode == "random" {
            randomMode.isOn = true
        }else{
            normalMode.isOn = true
        }
        
        normalMode.topAnchor.constraint(
            equalTo: multiplierInput.bottomAnchor,
            constant: view.frame.height * 0.04
        ).isActive = true
        normalMode.leadingAnchor.constraint(equalTo: tableInput.leadingAnchor).isActive = true
        //normalMode.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        normalMode.addTarget(self, action: #selector(modeTapped), for: .touchUpInside)
        
        normalLabel.leadingAnchor.constraint(
            equalTo: normalMode.trailingAnchor,
            constant: view.frame.width * 0.01
        ).isActive = true
        normalLabel.centerYAnchor.constraint(equalTo: normalMode.centerYAnchor).isActive = true
        normalLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
        randomMode.topAnchor.constraint(
            equalTo: normalMode.bottomAnchor,
            constant: view.frame.height * 0.02
        ).isActive = true
        randomMode.leadingAnchor.constraint(equalTo: tableInput.leadingAnchor).isActive = true
        //randomMode.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        randomMode.addTarget(self, action: #selector(modeTapped), for: .touchUpInside)
        
        randomLabel.leadingAnchor.constraint(
            equalTo: randomMode.trailingAnchor,
            constant: view.frame.width * 0.01
        ).isActive = true
        randomLabel.centerYAnchor.constraint(equalTo: randomMode.centerYAnchor).isActive = true
        randomLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupStartButton() {
        view.addSubview(startButton)
        startButton.topAnchor.constraint(
            equalTo: randomMode.bottomAnchor,
            constant: view.frame.height * 0.04
        ).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }
    
    @objc func modeTapped(sender:UISwitch) {
        modes.forEach { $0.isOn = false } // uncheck everything
        sender.isOn = true // check the button that is clicked on
        switch sender.tag {
        case 0:
            currentMode = "normal"
        case 1:
            currentMode = "random"
        default:
            currentMode = "normal"
        }
    }
    
    @objc func startTapped(sender:UIButton) {
        if let tableText = tableInput.text {
            if let table = Int(tableText) {
                currentTable = table
            }else{
                currentTable = 0
            }
        }else{
            currentTable = 0
        }
        if let multiText = multiplierInput.text {
            if let multiplier = Int(multiText) {
                currentMultiplier = multiplier
            }else{
                currentMultiplier = 0
            }
        }else {
            currentMultiplier = 0
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ttvc: TimesTableViewController = storyBoard.instantiateViewController(withIdentifier: "ttVC") as! TimesTableViewController
        self.navigationController!.setViewControllers([self,ttvc], animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
