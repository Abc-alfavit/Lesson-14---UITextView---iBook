//
//  ViewController.swift
//  Lesson 14 - UITextView - iBook
//
//  Created by Валентин Ремизов on 18.02.2023.
//

import UIKit

class ReaderVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private let readTextView = UITextView()
    private let configureTextView = UIView()
    private let blackTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private let blueTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private let grayTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private let brownTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private let darkGrayblackTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private let nightImageView = UIImageView(image: UIImage(systemName: "moon.zzz.fill"))
    private let nightModeSwitch = UISwitch(frame: CGRect(x: 320,
                                                         y: 155,
                                                         width: 51,
                                                         height: 31))
    private let sizeLettersSlider = UISlider(frame: CGRect(x: 110,
                                                           y: 160,
                                                           width: 190,
                                                           height: 30))
    private let fontPicker = UIPickerView(frame: CGRect(x: 110,
                                                        y: 190,
                                                        width: 190,
                                                        height: 100))
    private let fontsArray = ["Arial", "Georgia", "Rockwell", "Noteworthy"]
    private let notBoldFontLabel = UILabel(frame: CGRect(x: 320,
                                                         y: 200,
                                                         width: 30,
                                                         height: 30))
    private let boldFontLabel = UILabel(frame: CGRect(x: 355,
                                                      y: 200,
                                                      width: 30,
                                                      height: 30))
    private var activityViewController : UIActivityViewController? = nil

    internal override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reader"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "textformat.size"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(editAdjustTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(shareButtonPressed))
        self.view.backgroundColor = .white
        createBlackTextColorImageView()
        createBlueTextColorImageView()
        createGrayTextColorImageView()
        createBrownTextColorImageView()
        createDarkGrayTextColorImageView()
        createConfigureTextView()
        createNightMode()
        createReaderView()
        createSizeLetterSlider()
        fontPicker.delegate = self
        fontPicker.dataSource = self
        fontPicker.isHidden = true
        createNotBoldLabel()
        createBoldLabel()

        [readTextView, configureTextView, blueTextColorImageView,
         blackTextColorImageView, grayTextColorImageView, brownTextColorImageView,
         darkGrayblackTextColorImageView, nightImageView, nightModeSwitch,
         sizeLettersSlider, fontPicker, notBoldFontLabel,
         boldFontLabel].forEach{view.addSubview($0)}
    }

//MARK: - Methods
    fileprivate func createReaderView() {
        readTextView.frame = CGRect(x: 0,
                                y: 50,
                                width: self.view.bounds.width,
                                height: self.view.bounds.height - 50)
        readTextView.backgroundColor = .white
        readTextView.contentInset = UIEdgeInsets(top: 10,
                                             left: 10,
                                             bottom: 10,
                                             right: 10)
        readTextView.font = UIFont.systemFont(ofSize: 20)
        readTextView.text = "Вот некоторые из людей, написавших книги о том, что они сделали и почему:Джон Дин. Генри Киссинджер. Адольф Гитлер. Кэрил Чессман. Джеб Магрудер. Наполеон. Талейран. Дизраэли. Роберт Циммерман, также. Известный как Боб Дилан. Локк. Чарлтон Хестон. Эррол Флинн. Аятолла Хомейни. Ганди. Чарльз Олсон. Чарльз Колсон. Викторианский джентльмен. Доктор Икс.Также многие верят, что Бог написал Книгу или несколько Книг, в которых рассказал нам о том, что Он сделал, и – хотя бы отчасти – объяснил, почему Он так сделал. А поскольку многие верят и в то, что Бог сотворил человека по образу и подобию Своему, значит, и Бога можно считать человеком… или, точнее, Человеком.А вот некоторые из людей, не писавших книги о том, что они сделали… и что видели:Человек, хоронивший Гитлера. Человек, делавший вскрытие Джона Уилкса Бута. Человек, бальзамировавший Элвиса Пресли. Человек, подготовивший к погребению – и подготовивший весьма посредственно, по словам большинства гробовщиков, – папу Иоанна XXIII. Четыре десятка рабочих из похоронных бригад, которые очищали Джонстаун, таскали мешки с телами, отгоняли мух, протыкали бумажные стаканчики острыми палками, как у смотрителей городских парков. Человек, кремировавший Уильяма Холдена. Человек, оправивший в золото тело Александра Македонского, чтобы оно не разлагалось. Люди, которые мумифицировали фараонов.Смерть – загадка, похороны – таинство."
    }

    fileprivate func createConfigureTextView() {
        configureTextView.frame = CGRect(x: 100,
                                         y: 100,
                                         width: self.view.bounds.width - 105,
                                         height: 240)
        //withAlphaComponent - устанавливает прозрачность цвета от 0 до 1.
        configureTextView.backgroundColor = .lightGray.withAlphaComponent(0.95)
        configureTextView.layer.cornerRadius = configureTextView.frame.size.height / 9
        configureTextView.isHidden = true
    }

    fileprivate func createBlackTextColorImageView() {
        blackTextColorImageView.frame = CGRect(x: 110, y: 110, width: 30, height: 30)
        blackTextColorImageView.tintColor = .black
        blackTextColorImageView.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackTextColorPressed))
        blackTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        blackTextColorImageView.isUserInteractionEnabled = true
    }

    fileprivate func createBlueTextColorImageView() {
        blueTextColorImageView.frame = CGRect(x: 150, y: 110, width: 30, height: 30)
        blueTextColorImageView.tintColor = .blue
        blueTextColorImageView.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blueTextColorPressed))
        blueTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        blueTextColorImageView.isUserInteractionEnabled = true
    }

    fileprivate func createGrayTextColorImageView() {
        grayTextColorImageView.frame = CGRect(x: 190, y: 110, width: 30, height: 30)
        grayTextColorImageView.tintColor = .gray
        grayTextColorImageView.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(grayTextColorPressed))
        grayTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        grayTextColorImageView.isUserInteractionEnabled = true
    }

    fileprivate func createBrownTextColorImageView() {
        brownTextColorImageView.frame = CGRect(x: 230, y: 110, width: 30, height: 30)
        brownTextColorImageView.tintColor = .brown
        brownTextColorImageView.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(brownTextColorPressed))
        brownTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        brownTextColorImageView.isUserInteractionEnabled = true
    }

    fileprivate func createDarkGrayTextColorImageView() {
        darkGrayblackTextColorImageView.frame = CGRect(x: 270, y: 110, width: 30, height: 30)
        darkGrayblackTextColorImageView.tintColor = .darkGray
        darkGrayblackTextColorImageView.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(darkGrayTextColorPressed))
        darkGrayblackTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        darkGrayblackTextColorImageView.isUserInteractionEnabled = true
    }

    fileprivate func createNightMode() {
        nightImageView.frame = CGRect(x: 330, y: 110, width: 35, height: 35)
        nightImageView.tintColor = .black
        nightImageView.isHidden = true
        nightModeSwitch.isHidden = true
        nightModeSwitch.addTarget(self, action: #selector(nightModePressed), for: .valueChanged)
    }

    fileprivate func createSizeLetterSlider() {
        sizeLettersSlider.isHidden = true
        sizeLettersSlider.maximumValue = 40
        sizeLettersSlider.minimumValue = 5
//Устанавливает значение по умолчанию у ползунка
        sizeLettersSlider.setValue(20, animated: true)
        sizeLettersSlider.minimumValueImage = UIImage(systemName: "textformat.size.smaller")
        sizeLettersSlider.maximumValueImage = UIImage(systemName: "textformat.size.larger")
        sizeLettersSlider.tintColor = .darkGray
        sizeLettersSlider.thumbTintColor = .white
        sizeLettersSlider.addTarget(self, action: #selector(sizeTextChangeValue), for: .valueChanged)
    }

    fileprivate func createNotBoldLabel() {
        notBoldFontLabel.text = "A"
        notBoldFontLabel.font = .systemFont(ofSize: 30)
        notBoldFontLabel.textColor = .darkGray
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(notBoldPressed))
        notBoldFontLabel.isUserInteractionEnabled = true
        notBoldFontLabel.addGestureRecognizer(gestureRecognizer)
        notBoldFontLabel.isHidden = true
    }

    fileprivate func createBoldLabel() {
        boldFontLabel.text = "A"
        boldFontLabel.font = .boldSystemFont(ofSize: 32)
        boldFontLabel.textColor = .darkGray
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boldPressed))
        boldFontLabel.isUserInteractionEnabled = true
        boldFontLabel.addGestureRecognizer(gestureRecognizer)
        boldFontLabel.isHidden = true
    }

    private enum textColor {
        case black
        case blue
        case gray
        case brown
        case darkGray
    }

    @objc private func blueTextColorPressed() {
        chooseTextColor(color: .blue)
    }

    @objc private func blackTextColorPressed() {
        chooseTextColor(color: .black)
    }

    @objc private func grayTextColorPressed() {
        chooseTextColor(color: .gray)
    }

    @objc private func brownTextColorPressed() {
        chooseTextColor(color: .brown)
    }

    @objc private func darkGrayTextColorPressed() {
        chooseTextColor(color: .darkGray)
    }

    private func chooseTextColor(color: textColor) {
        switch color {
        case .black: readTextView.textColor = .black
        case .blue: readTextView.textColor = .blue
        case .gray: readTextView.textColor = .gray
        case .brown: readTextView.textColor = .brown
        case .darkGray: readTextView.textColor = .darkGray
        }
    }

    @objc private func nightModePressed() {
        if nightModeSwitch.isOn {
            self.view.backgroundColor = .darkGray
            readTextView.textColor = .systemGray5
            readTextView.backgroundColor = .darkGray
            nightImageView.tintColor = .systemGray5
        } else {
            self.view.backgroundColor = .white
            readTextView.textColor = .black
            nightImageView.tintColor = .black
            readTextView.backgroundColor = .white
        }
    }

    @objc private func sizeTextChangeValue() {
        readTextView.font = UIFont.systemFont(ofSize: CGFloat(sizeLettersSlider.value))
    }

    @objc private func notBoldPressed() {
        readTextView.font = .systemFont(ofSize: CGFloat(sizeLettersSlider.value))
    }

    @objc private func boldPressed() {
        readTextView.font = .boldSystemFont(ofSize: CGFloat(sizeLettersSlider.value))
    }

    @objc private func editAdjustTap() {
        if configureTextView.isHidden {
            configureTextView.isHidden = false
            blueTextColorImageView.isHidden = false
            blackTextColorImageView.isHidden = false
            grayTextColorImageView.isHidden = false
            brownTextColorImageView.isHidden = false
            darkGrayblackTextColorImageView.isHidden = false
            nightModeSwitch.isHidden = false
            nightImageView.isHidden = false
            sizeLettersSlider.isHidden = false
            fontPicker.isHidden = false
            notBoldFontLabel.isHidden = false
            boldFontLabel.isHidden = false
        } else {
            configureTextView.isHidden = true
            blueTextColorImageView.isHidden = true
            blackTextColorImageView.isHidden = true
            grayTextColorImageView.isHidden = true
            brownTextColorImageView.isHidden = true
            darkGrayblackTextColorImageView.isHidden = true
            nightModeSwitch.isHidden = true
            nightImageView.isHidden = true
            sizeLettersSlider.isHidden = true
            fontPicker.isHidden = true
            notBoldFontLabel.isHidden = true
            boldFontLabel.isHidden = true
        }
    }

    @objc private func shareButtonPressed() {
        activityViewController = UIActivityViewController(activityItems: [readTextView.text ?? ""], applicationActivities: nil)
        guard let shareButton = activityViewController else { return }
        present(shareButton, animated: true)
    }
}

extension ReaderVC {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontsArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontsArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch fontsArray[row] {
        case fontsArray[0]: readTextView.font = UIFont(name: "Arial", size: CGFloat(sizeLettersSlider.value))
        case fontsArray[1]: readTextView.font = UIFont(name: "Georgia", size: CGFloat(sizeLettersSlider.value))
        case fontsArray[2]: readTextView.font = UIFont(name: "Rockwell", size: CGFloat(sizeLettersSlider.value))
        case fontsArray[3]: readTextView.font = UIFont(name: "Noteworthy", size: CGFloat(sizeLettersSlider.value))
        default: readTextView.font = UIFont(name: "Helvetica Neue", size: CGFloat(sizeLettersSlider.value))
        }
    }
}


