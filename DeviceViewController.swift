import UIKit
import AVFoundation
import MultipeerConnectivity

class DeviceViewController: UIViewController, MCBrowserViewControllerDelegate,
MCSessionDelegate {
    
    let serviceType = "LCOC-Chat"
    
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!
    var peerID: MCPeerID!
    
    @IBOutlet var chatView: UITextView!
    @IBOutlet var messageField: UITextField!
    @IBOutlet var displayLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        self.browser = MCBrowserViewController(serviceType:serviceType,session:self.session)
        self.browser.delegate = self;
        self.assistant = MCAdvertiserAssistant(serviceType:serviceType,discoveryInfo:nil, session:self.session)
        self.assistant.start()

    }
    
    @IBAction func sendChat(sender: UIButton) {
        var error : NSError?
        let msg = self.messageField.text.dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)
        
        self.session.sendData(msg, toPeers: self.session.connectedPeers,withMode: MCSessionSendDataMode.Unreliable, error: &error)
        
        if error != nil {
            print("Error sending data: \(error?.localizedDescription)")
        }
        
        self.updateChat(self.messageField.text, fromPeer: self.peerID)
        self.messageField.text = ""
    }
    
    func updateChat(text : String, fromPeer peerID: MCPeerID) {
        var name : String
        
        switch peerID {
        case self.peerID:
            name = "Me"
        default:
            name = peerID.displayName
        }
        let message = "\(name): \(text)\n"
        self.chatView.text = self.chatView.text + message
        
    }
    
    @IBAction func showBrowser(sender: UIButton) {
        self.presentViewController(self.browser, animated: true, completion: nil)
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!)  {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!)  {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!,fromPeer peerID: MCPeerID!)  {
        dispatch_async(dispatch_get_main_queue()) {
            var msg = NSString(data: data, encoding: NSUTF8StringEncoding)
            self.updateChat(msg!, fromPeer: peerID)
        }
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(session: MCSession!,didStartReceivingResourceWithName resourceName: String!,fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!)  {
    }
    
    func session(session: MCSession!,didFinishReceivingResourceWithName resourceName: String!,fromPeer peerID: MCPeerID!,atURL localURL: NSURL!, withError error: NSError!)  {
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!,withName streamName: String!, fromPeer peerID: MCPeerID!)  {
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState)  {
        if(state.rawValue == 2){ // 2 means "Connected!" (successfully to a peer)
            displayLable.text = "Play Against: "+peerID.displayName
        }
    }
    
}