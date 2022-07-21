//
//  BaseViewController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import GoogleMobileAds

class BaseViewController: UIViewController {
    
    private var StackViewTitleButtons: UIStackView!
    private var ButtonTabs: [UIButton]!
    private var Tab: Int!
    
    private static var time: Date?
//    private static let BANNER_ID = "ca-app-pub-3940256099942544/4411468910" // TEST
    private static let BANNER_ID = "ca-app-pub-4411899771994288/3804817719"
    
    public let collectionView: UICollectionView = {
      let view = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
      view.backgroundColor = .black
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(tab: Int){
        self.init(nibName: nil, bundle: nil)
        
        self.Tab = tab
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeHideKeyboard()
        self.subscribeToKeyboardNotifications()
        self.setupBaseViewController()
    }
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        self.unsubscribeFromAllNotifications()
    }
    
    private func setupBaseViewController(){
        self.view.backgroundColor = UIColor.backgroundColor
                
        self.ButtonTabs = [UIButton]()
        
        let numButton = UIButton()
        numButton.setImage(UIImage(named: "NumbersIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        numButton.imageView?.tintColor = UIColor.backgroundColor
        numButton.setTitle("Numbers", for: .normal)
        numButton.imageView?.contentMode = .left
        numButton.titleLabel?.numberOfLines = 1
        numButton.titleLabel?.adjustsFontSizeToFitWidth = true
        numButton.titleLabel?.lineBreakMode = .byClipping
        numButton.layer.cornerRadius = 5;
        numButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        numButton.addTarget(self, action: #selector(titleButton_TouchUpInside), for: .touchUpInside)
        self.ButtonTabs.append(numButton)
        
        let txtButton = UIButton()
        txtButton.setImage(UIImage(named: "TextIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        txtButton.imageView?.tintColor = UIColor.backgroundColor
        txtButton.setTitle("Text", for: .normal)
        txtButton.imageView?.contentMode = .left
        txtButton.titleLabel?.numberOfLines = 1
        txtButton.titleLabel?.adjustsFontSizeToFitWidth = true
        txtButton.titleLabel?.lineBreakMode = .byClipping
        txtButton.layer.cornerRadius = 5;
        txtButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        txtButton.addTarget(self, action: #selector(titleButton_TouchUpInside), for: .touchUpInside)
        self.ButtonTabs.append(txtButton)
        
        let ipButton = UIButton()
        ipButton.setImage(UIImage(named: "IpIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        ipButton.imageView?.tintColor = UIColor.backgroundColor
        ipButton.setTitle("Network", for: .normal)
        ipButton.imageView?.contentMode = .left
        ipButton.titleLabel?.numberOfLines = 1
        ipButton.titleLabel?.adjustsFontSizeToFitWidth = true
        ipButton.titleLabel?.lineBreakMode = .byClipping
        ipButton.layer.cornerRadius = 5;
        ipButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        ipButton.addTarget(self, action: #selector(titleButton_TouchUpInside), for: .touchUpInside)
        self.ButtonTabs.append(ipButton)
        
        let bitButton = UIButton()
        bitButton.setImage(UIImage(named: "BitwiseIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bitButton.imageView?.tintColor = UIColor.backgroundColor
        bitButton.setTitle("Bitwise", for: .normal)
        bitButton.imageView?.contentMode = .left
        bitButton.titleLabel?.numberOfLines = 1
        bitButton.titleLabel?.adjustsFontSizeToFitWidth = true
        bitButton.titleLabel?.lineBreakMode = .byClipping
        bitButton.layer.cornerRadius = 5;
        bitButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        bitButton.addTarget(self, action: #selector(titleButton_TouchUpInside), for: .touchUpInside)
        self.ButtonTabs.append(bitButton)
        
        self.StackViewTitleButtons = UIStackView(arrangedSubviews: self.ButtonTabs)
        self.StackViewTitleButtons.alignment = .center
        self.StackViewTitleButtons.axis = .horizontal
        self.StackViewTitleButtons.distribution = .fillProportionally
        self.StackViewTitleButtons.spacing = 10
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        self.toggleButtons(selectedButton: self.ButtonTabs[self.Tab])
        
        super.navigationItem.titleView = self.StackViewTitleButtons
        
        collectionView.backgroundColor = UIColor.backgroundColor
        
        view.addSubview(collectionView)
        
        collectionView.register(TextfieldViewCell.self, forCellWithReuseIdentifier: TextfieldViewCell.identifier)
        collectionView.register(LabelViewCell.self, forCellWithReuseIdentifier: LabelViewCell.identifier)
        collectionView.register(ResultsLabelViewCell.self, forCellWithReuseIdentifier: ResultsLabelViewCell.identifier)
        collectionView.register(SubnetViewCell.self, forCellWithReuseIdentifier: SubnetViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      collectionView.frame = view.bounds
    }
    
    private func toggleButtons(selectedButton: UIButton){
        for button in self.ButtonTabs {
            button.backgroundColor = button == selectedButton ? UIColor.backgroundColor : UIColor.clear
            button.setTitleColor(button == selectedButton ? UIColor.primaryColor : UIColor.backgroundColor, for: .normal)
            button.imageView?.tintColor = button == selectedButton ? UIColor.primaryColor : UIColor.backgroundColor
        }
    }
    
    private func navigateToNumbers(){
        let vc = NumbersViewController()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    private func navigateToText(){
        let vc = TextViewController()
        self.navigationController?.setViewControllers([vc], animated: true)
        displayInterstitialAd(viewController: vc)
    }
    private func navigateToNetwork(){
        let vc = NetworkViewController()
        self.navigationController?.setViewControllers([vc], animated: true)
        displayInterstitialAd(viewController: vc)
    }
    private func navigateToBitwise(){
        let vc = BitwiseViewController()
        self.navigationController?.setViewControllers([vc], animated: true)
        displayInterstitialAd(viewController: vc)
    }
    
    private func displayInterstitialAd(viewController: UIViewController) {
        if BaseViewController.time == nil || BaseViewController.time!.addingTimeInterval(TimeInterval(45)) < Date() {
            BaseViewController.time = Date()
            GADInterstitialAd.load(withAdUnitID: BaseViewController.BANNER_ID, request: GADRequest()) { ad, error in
                if let error = error {
                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                  return
                }
                ad?.present(fromRootViewController: viewController)
            }
        }
    }
    
    private func navigateToView(button: UIButton){
        let index = self.ButtonTabs.firstIndex(of: button)
        if(index != self.Tab){
            
            switch index {
            case 0:
                self.navigateToNumbers(); break
            case 1:
                self.navigateToText(); break
            case 2:
                self.navigateToNetwork(); break
            case 3:
                self.navigateToBitwise(); break
            default:
                break;
            }
        }
    }
    
    @objc func titleButton_TouchUpInside(_ sender: UIButton) -> Void {
        navigateToView(button: sender)
    }
    
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}
extension BaseViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.collectionView.contentInset = UIEdgeInsets(top: self.collectionView.contentInset.top, left: self.collectionView.contentInset.left, bottom: keyboardSize.height, right: self.collectionView.contentInset.right)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.collectionView.contentInset = UIEdgeInsets(top: self.collectionView.contentInset.top, left: self.collectionView.contentInset.left, bottom: 10, right: self.collectionView.contentInset.right)
    }

}
