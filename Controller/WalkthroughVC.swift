//
//  WalkthroughVC.swift
//  just camping
//
//  Created by 則佑林 on 2020/12/31.
//

import UIKit

class WalkthroughVC: UIViewController, walkthroughPageVCDelegate {
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var skipButton: UIButton!
    var walkthroughPageViewController: PageVC?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
    
    //MARK: - Button Func
    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "Walkthrough")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                walkthroughPageViewController?.forwardPage()
            case 3:
                UserDefaults.standard.set(true, forKey: "Walkthrough")
                dismiss(animated: true, completion: nil)
            default :
                break
            }
        }
        updateUI()
    }
    //控制NEXT標題，判斷Skip是否隱藏
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                nextButton.setTitle(NSLocalizedString("NEXT", comment: ""), for: .normal)
                skipButton.isHidden = false
            case 3:
                nextButton.setTitle(NSLocalizedString("start using", comment: ""), for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? PageVC {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.PageDelegate = self
        }
    }
    
    
}
