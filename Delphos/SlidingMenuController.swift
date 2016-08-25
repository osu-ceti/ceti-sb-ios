/**
 * FileName     :   SlidingMenuController.swift
 * Created by   :   Prabhu
 * Date Created :   5/20/2015
 * Description  :   SlideMenuOption class handles navigation of left and right drawer in controller
 * All Copyrights reserved
 */

import UIKit
import Foundation

/**
 * SlideMenuOption class handles navigation of left and right drawer in controller
 */
class SlideMenuOption {
    
    let leftViewWidth: CGFloat = 270.0
    let leftBezelWidth: CGFloat = 16.0
    let contentViewScale: CGFloat = 0.96
    let contentViewOpacity: CGFloat = 0.5
    let shadowOpacity: CGFloat = 0.0
    let shadowRadius: CGFloat = 0.0
    let shadowOffset: CGSize = CGSize(width: 0,height: 0)
    let panFromBezel: Bool = true
    let animationDuration: CGFloat = 0.4
    let rightViewWidth: CGFloat = 270.0
    let rightBezelWidth: CGFloat = 16.0
    let rightPanFromBezel: Bool = true
    let hideStatusBar: Bool = true
    let pointOfNoReturnWidth: CGFloat = 44.0
    
    init() {
        
    }
}

class SlidingMenuController: BaseController, UIGestureRecognizerDelegate {
    
    enum SlideAction {
        case open
        case close
    }
    
    enum TrackAction {
        case tapOpen
        case tapClose
        case flickOpen
        case flickClose
    }
    
    struct PanInfo {
        var action: SlideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }
    
    var opacityView = UIView()
    var mainContainerView = UIView()
    var leftContainerView = UIView()
    var rightContainerView =  UIView()
    var mainViewController: UIViewController?
    var leftViewController: UIViewController?
    var leftPanGesture: UIPanGestureRecognizer?
    var leftTapGetsture: UITapGestureRecognizer?
    var rightViewController: UIViewController?
    var rightPanGesture: UIPanGestureRecognizer?
    var rightTapGesture: UITapGestureRecognizer?
    var options = SlideMenuOption()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        self.leftViewController = leftMenuViewController
        self.initView()
    }
    
    convenience init(mainViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        self.rightViewController = rightMenuViewController
        self.initView()
    }
    
    convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        self.leftViewController = leftMenuViewController
        self.rightViewController = rightMenuViewController
        self.initView()
    }
    
    deinit { }
    
    func initView() {
        
        mainContainerView = UIView(frame: self.view.bounds)
        mainContainerView.backgroundColor = UIColor.clear
        mainContainerView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.view.insertSubview(mainContainerView, at: 0)
        
        var opacityframe: CGRect = self.view.bounds
        let opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = UIColor.black
        opacityView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        opacityView.layer.opacity = 0.0
        self.view.insertSubview(opacityView, at: 1)
        
        var leftFrame: CGRect = self.view.bounds
        leftFrame.size.width = self.options.leftViewWidth
        leftFrame.origin.x = self.leftMinOrigin();
        let leftOffset: CGFloat = 0
        leftFrame.origin.y = leftFrame.origin.y + leftOffset
        leftFrame.size.height = leftFrame.size.height - leftOffset
        leftContainerView = UIView(frame: leftFrame)
        leftContainerView.backgroundColor = UIColor.clear
        leftContainerView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.view.insertSubview(leftContainerView, at: 2)
        
        var rightFrame: CGRect = self.view.bounds
        rightFrame.size.width = self.options.rightViewWidth
        rightFrame.origin.x = self.rightMinOrigin()
        let rightOffset: CGFloat = 0
        rightFrame.origin.y = rightFrame.origin.y + rightOffset;
        rightFrame.size.height = rightFrame.size.height - rightOffset
        rightContainerView = UIView(frame: rightFrame)
        rightContainerView.backgroundColor = UIColor.clear
        rightContainerView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.view.insertSubview(rightContainerView, at: 3)
        
        self.addLeftGestures()
        self.addRightGestures()
        
        
        
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        super.willRotate(to: toInterfaceOrientation, duration: duration)
        
        self.mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.leftContainerView.isHidden = true
        self.rightContainerView.isHidden = true
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotate(from: fromInterfaceOrientation)
        
        self.closeLeftNonAnimation()
        self.closeRightNonAnimation()
        self.leftContainerView.isHidden = false
        self.rightContainerView.isHidden = false
        
        self.removeLeftGestures()
        self.removeRightGestures()
        self.addLeftGestures()
        self.addRightGestures()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge()
        rootViewController = self
    }
    
    override func viewWillLayoutSubviews() {
        
        self.setUpViewController(self.mainContainerView, targetViewController: self.mainViewController)
        self.setUpViewController(self.leftContainerView, targetViewController: self.leftViewController)
        self.setUpViewController(self.rightContainerView, targetViewController: self.rightViewController)
    }
    
    override func openLeft() {
        self.setOpenWindowLevel()
        
        //leftViewController
        self.leftViewController?.beginAppearanceTransition(self.isLeftHidden(), animated: true)
        self.openLeftWithVelocity(0.0)
        
        self.track(.tapOpen)
    }
    
    override func openRight() {
        self.setOpenWindowLevel()
        
        //menuViewController
        self.rightViewController?.beginAppearanceTransition(self.isRightHidden(), animated: true)
        self.openRightWithVelocity(0.0)
    }
    
    override func closeLeft() {
        self.closeLeftWithVelocity(0.0)
        self.setCloseWindowLebel()
    }
    
    override func closeRight() {
        self.closeRightWithVelocity(0.0)
        self.setCloseWindowLebel()
    }
    
    func addLeftGestures() {
        
        if (self.leftViewController != nil) {
            //            if self.leftPanGesture == nil {
            //                self.leftPanGesture = UIPanGestureRecognizer(target: self, action: "handleLeftPanGesture:")
            //                self.leftPanGesture!.delegate = self
            //                self.view.addGestureRecognizer(self.leftPanGesture!)
            //            }
            
            if self.leftTapGetsture == nil {
                self.leftTapGetsture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.toggleLeft))
                self.leftTapGetsture!.delegate = self
                self.view.addGestureRecognizer(self.leftTapGetsture!)
            }
        }
    }
    
    func addRightGestures() {
        
        if (self.rightViewController != nil) {
            //            if self.rightPanGesture == nil {
            //                self.rightPanGesture = UIPanGestureRecognizer(target: self, action: "handleRightPanGesture:")
            //                self.rightPanGesture!.delegate = self
            //                self.view.addGestureRecognizer(self.rightPanGesture!)
            //            }
            
            if self.rightTapGesture == nil {
                self.rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.toggleRight))
                self.rightTapGesture!.delegate = self
                self.view.addGestureRecognizer(self.rightTapGesture!)
            }
        }
    }
    
    func removeLeftGestures() {
        
        if self.leftPanGesture != nil {
            self.view.removeGestureRecognizer(self.leftPanGesture!)
            self.leftPanGesture = nil
        }
        
        if self.leftTapGetsture != nil {
            self.view.removeGestureRecognizer(self.leftTapGetsture!)
            self.leftTapGetsture = nil
        }
    }
    
    func removeRightGestures() {
        
        if self.rightPanGesture != nil {
            self.view.removeGestureRecognizer(self.rightPanGesture!)
            self.rightPanGesture = nil
        }
        
        if self.rightTapGesture != nil {
            self.view.removeGestureRecognizer(self.rightTapGesture!)
            self.rightTapGesture = nil
        }
    }
    
    func isTagetViewController() -> Bool {
        // Function to determine the target ViewController
        // Please to override it if necessary
        return true
    }
    
    func track(_ trackAction: TrackAction) {
        // function is for tracking
        // Please to override it if necessary
    }
    
    struct LeftPanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
    }
    
    func handleLeftPanGesture(_ panGesture: UIPanGestureRecognizer) {
        
        if !self.isTagetViewController() {
            return
        }
        
        if self.isRightOpen() {
            return
        }
        
        switch panGesture.state {
        case UIGestureRecognizerState.began:
            
            LeftPanState.frameAtStartOfPan = self.leftContainerView.frame
            LeftPanState.startPointOfPan = panGesture.location(in: self.view)
            LeftPanState.wasOpenAtStartOfPan = self.isLeftOpen()
            LeftPanState.wasHiddenAtStartOfPan = self.isLeftHidden()
            
            self.leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
            self.addShadowToView(self.leftContainerView)
            self.setOpenWindowLevel()
        case UIGestureRecognizerState.changed:
            
            let translation: CGPoint = panGesture.translation(in: panGesture.view!)
            self.leftContainerView.frame = self.applyLeftTranslation(translation, toFrame: LeftPanState.frameAtStartOfPan)
            self.applyLeftOpacity()
            self.applyLeftContentViewScale()
        case UIGestureRecognizerState.ended:
            
            self.leftViewController?.beginAppearanceTransition(!LeftPanState.wasHiddenAtStartOfPan, animated: true)
            let velocity:CGPoint = panGesture.velocity(in: panGesture.view)
            let panInfo: PanInfo = self.panLeftResultInfoForVelocity(velocity)
            
            if panInfo.action == .open {
                self.openLeftWithVelocity(panInfo.velocity)
                self.track(.flickOpen)
                
            } else {
                self.closeLeftWithVelocity(panInfo.velocity)
                self.setCloseWindowLebel()
                
                self.track(.flickClose)
            }
        default:
            break
        }
        
    }
    
    struct rightPanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
    }
    
    func handleRightPanGesture(_ panGesture: UIPanGestureRecognizer) {
        
        if !self.isTagetViewController() {
            return
        }
        
        if self.isLeftOpen() {
            return
        }
        
        switch panGesture.state {
        case UIGestureRecognizerState.began:
            
            rightPanState.frameAtStartOfPan = self.rightContainerView.frame
            rightPanState.startPointOfPan = panGesture.location(in: self.view)
            rightPanState.wasOpenAtStartOfPan =  self.isRightOpen()
            rightPanState.wasHiddenAtStartOfPan = self.isRightHidden()
            
            self.rightViewController?.beginAppearanceTransition(rightPanState.wasHiddenAtStartOfPan, animated: true)
            self.addShadowToView(self.rightContainerView)
            self.setOpenWindowLevel()
        case UIGestureRecognizerState.changed:
            
            let translation: CGPoint = panGesture.translation(in: panGesture.view!)
            self.rightContainerView.frame = self.applyRightTranslation(translation, toFrame: rightPanState.frameAtStartOfPan)
            self.applyRightOpacity()
            self.applyRightContentViewScale()
            
        case UIGestureRecognizerState.ended:
            
            self.rightViewController?.beginAppearanceTransition(!rightPanState.wasHiddenAtStartOfPan, animated: true)
            let velocity: CGPoint = panGesture.velocity(in: panGesture.view)
            let panInfo: PanInfo = self.panRightResultInfoForVelocity(velocity)
            
            if panInfo.action == .open {
                self.openRightWithVelocity(panInfo.velocity)
            } else {
                self.closeRightWithVelocity(panInfo.velocity)
                self.setCloseWindowLebel()
            }
        default:
            break
        }
    }
    
    func openLeftWithVelocity(_ velocity: CGFloat) {
        let xOrigin: CGFloat = self.leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0
        
        var frame = self.leftContainerView.frame;
        frame.origin.x = finalXOrigin;
        
        var duration: TimeInterval = Double(self.options.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.addShadowToView(self.leftContainerView)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.leftContainerView.frame = frame
            self.opacityView.layer.opacity = Float(self.options.contentViewOpacity)
            self.mainContainerView.transform = CGAffineTransform(scaleX: self.options.contentViewScale, y: self.options.contentViewScale)
        }) { (Bool) -> Void in
            self.disableContentInteraction()
        }
    }
    
    func openRightWithVelocity(_ velocity: CGFloat) {
        let xOrigin: CGFloat = self.rightContainerView.frame.origin.x
        
        let finalXOrigin: CGFloat = self.view.bounds.width - self.rightContainerView.frame.size.width
        
        var frame = self.rightContainerView.frame
        frame.origin.x = finalXOrigin
        
        var duration: TimeInterval = Double(self.options.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - self.view.bounds.width) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.addShadowToView(self.rightContainerView)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.rightContainerView.frame = frame
            self.opacityView.layer.opacity = Float(self.options.contentViewOpacity)
            self.mainContainerView.transform = CGAffineTransform(scaleX: self.options.contentViewScale, y: self.options.contentViewScale)
        }) { (Bool) -> Void in
            self.disableContentInteraction()
        }
    }
    
    func closeLeftWithVelocity(_ velocity: CGFloat) {
        
        let xOrigin: CGFloat = self.leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = self.leftMinOrigin()
        
        var frame: CGRect = self.leftContainerView.frame;
        frame.origin.x = finalXOrigin
        
        var duration: TimeInterval = Double(self.options.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.leftContainerView.frame = frame
            self.opacityView.layer.opacity = 0.0
            self.mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (Bool) -> Void in
            self.removeShadow(self.leftContainerView)
            self.enableContentInteraction()
        }
    }
    
    func closeRightWithVelocity(_ velocity: CGFloat) {
        
        let xOrigin: CGFloat = self.rightContainerView.frame.origin.x
        let finalXOrigin: CGFloat = self.view.bounds.width
        
        var frame: CGRect = self.rightContainerView.frame
        frame.origin.x = finalXOrigin
        
        var duration: TimeInterval = Double(self.options.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - self.view.bounds.width) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.rightContainerView.frame = frame
            self.opacityView.layer.opacity = 0.0
            self.mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (Bool) -> Void in
            self.removeShadow(self.rightContainerView)
            self.enableContentInteraction()
        }
    }
    
    override func toggleLeft() {
        if self.isLeftOpen() {
            self.closeLeft()
            self.setCloseWindowLebel()
            // closeMenu
            self.track(.tapClose)
        } else {
            self.openLeft()
        }
    }
    
    func isLeftOpen() -> Bool {
        return self.leftContainerView.frame.origin.x == 0.0
    }
    
    func isLeftHidden() -> Bool {
        return self.leftContainerView.frame.origin.x <= self.leftMinOrigin()
    }
    
    override func toggleRight() {

        gObjRightViewController?.hidingOverlay()
        if self.isRightOpen() {
            self.closeRight()
            self.setCloseWindowLebel()
        } else {
            
            self.openRight()
        }
    }
    
    func isRightOpen() -> Bool {
        return self.rightContainerView.frame.origin.x == self.view.bounds.width - self.rightContainerView.frame.size.width
    }
    
    func isRightHidden() -> Bool {
        return self.rightContainerView.frame.origin.x >= self.view.bounds.width
    }
    
    func changeMainViewController(_ mainViewController: UIViewController,  close: Bool) {
        if (close) {
            self.closeLeft()
            self.closeRight()
        }
        self.removeViewController(self.mainViewController)
        self.mainViewController = mainViewController
        self.setUpViewController(self.mainContainerView, targetViewController: self.mainViewController)
        
    }
    
    func changeLeftViewController(_ leftViewController: UIViewController, closeLeft:Bool) {
        
        self.removeViewController(self.leftViewController)
        self.leftViewController = leftViewController
        self.setUpViewController(self.leftContainerView, targetViewController: self.leftViewController)
        if (closeLeft) {
            self.closeLeft()
        }
    }
    
    func changeRightViewController(_ rightViewController: UIViewController, closeRight:Bool) {
        self.removeViewController(self.rightViewController)
        self.rightViewController = rightViewController;
        self.setUpViewController(self.rightContainerView, targetViewController: self.rightViewController)
        if (closeRight) {
            self.closeRight()
        }
    }
    
    fileprivate func leftMinOrigin() -> CGFloat {
        return  -self.options.leftViewWidth
    }
    
    fileprivate func rightMinOrigin() -> CGFloat {
        return self.view.bounds.width
    }
    
    
    fileprivate func panLeftResultInfoForVelocity(_ velocity: CGPoint) -> PanInfo {
        
        let thresholdVelocity: CGFloat = 1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(self.leftMinOrigin())) + self.options.pointOfNoReturnWidth
        let leftOrigin: CGFloat = self.leftContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .close : .open;
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    fileprivate func panRightResultInfoForVelocity(_ velocity: CGPoint) -> PanInfo {
        
        let thresholdVelocity: CGFloat = -1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(self.view.bounds.width) - self.options.pointOfNoReturnWidth)
        let rightOrigin: CGFloat = self.rightContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = rightOrigin >= pointOfNoReturn ? .close : .open
        
        if velocity.x <= thresholdVelocity {
            panInfo.action = .open
            panInfo.velocity = velocity.x
        } else if (velocity.x >= (-1.0 * thresholdVelocity)) {
            panInfo.action = .close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    fileprivate func applyLeftTranslation(_ translation: CGPoint, toFrame:CGRect) -> CGRect {
        
        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = self.leftMinOrigin()
        let maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    fileprivate func applyRightTranslation(_ translation: CGPoint, toFrame: CGRect) -> CGRect {
        
        var  newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = self.rightMinOrigin()
        //        var maxOrigin: CGFloat = self.options.rightViewOverlapWidth
        let maxOrigin: CGFloat = self.rightMinOrigin() - self.rightContainerView.frame.size.width
        var newFrame: CGRect = toFrame
        
        if newOrigin > minOrigin {
            newOrigin = minOrigin
        } else if newOrigin < maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    fileprivate func getOpenedLeftRatio() -> CGFloat {
        
        let width: CGFloat = self.leftContainerView.frame.size.width
        let currentPosition: CGFloat = self.leftContainerView.frame.origin.x - self.leftMinOrigin()
        return currentPosition / width
    }
    
    fileprivate func getOpenedRightRatio() -> CGFloat {
        
        let width: CGFloat = self.rightContainerView.frame.size.width
        let currentPosition: CGFloat = self.rightContainerView.frame.origin.x
        return -(currentPosition - self.view.bounds.width) / width
    }
    
    fileprivate func applyLeftOpacity() {
        
        let openedLeftRatio: CGFloat = self.getOpenedLeftRatio()
        let opacity: CGFloat = self.options.contentViewOpacity * openedLeftRatio
        self.opacityView.layer.opacity = Float(opacity)
    }
    
    
    fileprivate func applyRightOpacity() {
        let openedRightRatio: CGFloat = self.getOpenedRightRatio()
        let opacity: CGFloat = self.options.contentViewOpacity * openedRightRatio
        self.opacityView.layer.opacity = Float(opacity)
    }
    
    fileprivate func applyLeftContentViewScale() {
        let openedLeftRatio: CGFloat = self.getOpenedLeftRatio()
        let scale: CGFloat = 1.0 - ((1.0 - self.options.contentViewScale) * openedLeftRatio);
        self.mainContainerView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    fileprivate func applyRightContentViewScale() {
        let openedRightRatio: CGFloat = self.getOpenedRightRatio()
        let scale: CGFloat = 1.0 - ((1.0 - self.options.contentViewScale) * openedRightRatio)
        self.mainContainerView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    fileprivate func addShadowToView(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowOffset = self.options.shadowOffset
        targetContainerView.layer.shadowOpacity = Float(self.options.shadowOpacity)
        targetContainerView.layer.shadowRadius = self.options.shadowRadius
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).cgPath
    }
    
    fileprivate func removeShadow(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        self.mainContainerView.layer.opacity = 1.0
    }
    
    fileprivate func removeContentOpacity() {
        self.opacityView.layer.opacity = 0.0
    }
    
    
    fileprivate func addContentOpacity() {
        self.opacityView.layer.opacity = Float(self.options.contentViewOpacity)
    }
    
    fileprivate func disableContentInteraction() {
        self.mainContainerView.isUserInteractionEnabled = false
    }
    
    fileprivate func enableContentInteraction() {
        self.mainContainerView.isUserInteractionEnabled = true
    }
    
    fileprivate func setOpenWindowLevel() {
        if (self.options.hideStatusBar) {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindowLevelStatusBar + 1
                }
            })
        }
    }
    
    fileprivate func setCloseWindowLebel() {
        if (self.options.hideStatusBar) {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindowLevelNormal
                }
            })
        }
    }
    
    fileprivate func setUpViewController(_ taretView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            self.addChildViewController(viewController)
            viewController.view.frame = taretView.bounds
            taretView.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    
    fileprivate func removeViewController(_ viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.willMove(toParentViewController: nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParentViewController()
        }
    }
    
    func closeLeftNonAnimation(){
        self.setCloseWindowLebel()
        var xOrigin: CGFloat = self.leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = self.leftMinOrigin()
        var frame: CGRect = self.leftContainerView.frame;
        frame.origin.x = finalXOrigin
        self.leftContainerView.frame = frame
        self.opacityView.layer.opacity = 0.0
        self.mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.removeShadow(self.leftContainerView)
        self.enableContentInteraction()
    }
    
    func closeRightNonAnimation(){
        self.setCloseWindowLebel()
        let finalXOrigin: CGFloat = self.view.bounds.width
        var frame: CGRect = self.rightContainerView.frame
        frame.origin.x = finalXOrigin
        self.rightContainerView.frame = frame
        self.opacityView.layer.opacity = 0.0
        self.mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.removeShadow(self.rightContainerView)
        self.enableContentInteraction()
    }
    
    //pragma mark – UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let point: CGPoint = touch.location(in: self.view)
        
        if gestureRecognizer == self.leftPanGesture {
            return self.slideLeftForGestureRecognizer(gestureRecognizer, point: point)
        } else if gestureRecognizer == self.rightPanGesture {
            return self.slideRightViewForGestureRecognizer(gestureRecognizer, withTouchPoint: point)
        } else if gestureRecognizer == self.leftTapGetsture {
            return self.isLeftOpen() && !self.isPointContainedWithinLeftRect(point)
        } else if gestureRecognizer == self.rightTapGesture {
            return self.isRightOpen() && !self.isPointContainedWithinRightRect(point)
        }
        
        return true
    }
    
    fileprivate func slideLeftForGestureRecognizer( _ gesture: UIGestureRecognizer, point:CGPoint) -> Bool{
        
        var slide = self.isLeftOpen()
        slide = self.options.panFromBezel && self.isLeftPointContainedWithinBezelRect(point)
        return slide
    }
    
    fileprivate func isLeftPointContainedWithinBezelRect(_ point: CGPoint) -> Bool{
        var leftBezelRect: CGRect = CGRect.zero
        var tempRect: CGRect = CGRect.zero
        let bezelWidth: CGFloat = self.options.leftBezelWidth
        
        //CGRectDivide(self.view.bounds, &leftBezelRect, &tempRect, bezelWidth, CGRectEdge.minXEdge)
        return leftBezelRect.contains(point)
    }
    
    fileprivate func isPointContainedWithinLeftRect(_ point: CGPoint) -> Bool {
        return self.leftContainerView.frame.contains(point)
    }
    
    
    
    fileprivate func slideRightViewForGestureRecognizer(_ gesture: UIGestureRecognizer, withTouchPoint point: CGPoint) -> Bool {
        
        var slide: Bool = self.isRightOpen()
        slide = self.options.rightPanFromBezel && self.isRightPointContainedWithinBezelRect(point)
        return slide
    }
    
    fileprivate func isRightPointContainedWithinBezelRect(_ point: CGPoint) -> Bool {
        var rightBezelRect: CGRect = CGRect.zero
        var tempRect: CGRect = CGRect.zero
        //CGFloat bezelWidth = self.rightContainerView.frame.size.width;
        let bezelWidth: CGFloat = self.view.bounds.width - self.options.rightBezelWidth
        
        //CGRectDivide(self.view.bounds, &tempRect, &rightBezelRect, bezelWidth, CGRectEdge.minXEdge)
        
        return rightBezelRect.contains(point)
    }
    
    fileprivate func isPointContainedWithinRightRect(_ point: CGPoint) -> Bool {
        return self.rightContainerView.frame.contains(point)
    }
    
}


extension UIViewController {
    
    func slideMenuController() -> SlidingMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlidingMenuController {
                return viewController as? SlidingMenuController
            }
            viewController = viewController?.parent
        }
        return nil;
    }
    
    func addLeftBarButtonWithImage(_ buttonImage: UIImage) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.bordered, target: self, action: #selector(UIViewController.toggleLeft))
        self.navigationItem.leftBarButtonItem = leftButton;
    }
    
    func addRightBarButtonWithImage(_ buttonImage: UIImage) -> UIBarButtonItem{
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.bordered, target: self, action: #selector(UIViewController.toggleRight))
       // self.navigationItem.rightBarButtonItem = rightButton;
        return rightButton
        
    }
    
    func addLeftButtonToRightToggle(_ buttonImage: UIImage) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.bordered, target: self, action: #selector(UIViewController.toggleRight))
        self.navigationItem.leftBarButtonItem = leftButton;
    }
    
    func addRightButtonToLeftToggle(_ buttonImage: UIImage) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.bordered, target: self, action: #selector(UIViewController.toggleLeft))
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
    func toggleLeft() {
        self.slideMenuController()?.toggleLeft()
    }
    
    func toggleRight() {
        
        self.slideMenuController()?.toggleRight()
    }
    
    func openLeft() {
        self.slideMenuController()?.openLeft()
    }
    
    func openRight() {
        self.slideMenuController()?.openRight()
    }
    
    func closeLeft() {
        self.slideMenuController()?.closeLeft()
    }
    
    func closeRight() {
        self.slideMenuController()?.closeRight()
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    func addPriorityToMenuGesuture(_ targetScrollView: UIScrollView) {
        if let slideControlelr = self.slideMenuController() {
            let recognizers =  slideControlelr.view.gestureRecognizers
            for recognizer in recognizers as! [UIPanGestureRecognizer] {
                if recognizer is UIPanGestureRecognizer {
                    targetScrollView.panGestureRecognizer.require(toFail: recognizer)
                }
            }
        }
    }
}
