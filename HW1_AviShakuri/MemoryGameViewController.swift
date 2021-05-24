//
//  MemoryGameViewController.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 06/05/2021.
//

import UIKit



class MemoryGameViewController: UIViewController {
    @IBOutlet weak var mg_LBL_moves: UILabel!

    @IBOutlet weak var mg_LBL_name: UILabel!
    
    @IBOutlet weak var mg_BTN_saveName: UIButton!
    @IBOutlet weak var mg_TXF_name: UITextField!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var mg_TXF_timer: UITextField!
   
    var myButtonArr : [UIButton?]=[]
    var randCard=[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8]
    var dict = [Int:Int]()
    var match : [Int?]=[]
    var firstCard:UIButton!
    var secondCard:UIButton!
    var score = 0
    var moves = 0
    var timer:Timer = Timer()
    var second=0
    var minutes=0
    var choice=0
    var player1 : Player!
    var player=[String:AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi memory game")
        resizeStackView()
        startGame()
        
        }
    func readLevel(){
        let preferences = UserDefaults.standard
        let currentKey = "currentLevel"
        print(preferences.integer(forKey: currentKey))
     
        choice = preferences.integer(forKey: currentKey)
            
        
    }
    func resizeStackView(){
        readLevel()
        if(choice==1){
            randCard=[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]
            let stackView = UIStackView(frame: self.view.bounds)
            stackView.distribution = .fillEqually
            for i in 16...19{
            let button = UIButton()
            button.setImage(UIImage(named: "imgCardMemory"), for: .normal)
            button.tag = i
                button.addTarget(self, action: #selector(self.btnClick(_:)), for: UIControl.Event.touchUpInside)
            stackView.addArrangedSubview(button)
            }
            
            verticalStackView?.addArrangedSubview(stackView)
        }
    }
    func startGame(){
        mg_LBL_name.isHidden=true
        mg_TXF_name.isHidden=true
        mg_BTN_saveName.isHidden=true
        
        insertButonToArr()
        randCard.shuffle()
        showImage()
        initTimer()

    }
    func insertButonToArr(){
        for case let horizontalStackView as UIStackView in verticalStackView.arrangedSubviews {
                for case let button as UIButton in horizontalStackView.arrangedSubviews {
                    myButtonArr.append(button)
                    print(button.tag)
                }
        }
    }
    
    func showImage(){
        for image in myButtonArr{
            image?.isEnabled = false
            image?.setImage(UIImage(named: "c\(randCard[image!.tag])"), for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            for temp in self.myButtonArr{
                temp?.setImage(UIImage(named: "imgCardMemory"), for: .normal)
                temp?.isEnabled = true
            }
            
        }
        
    }
    func initTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
                   
    }
    @objc func countTime() {
        if (second==60){
            second=0
            minutes+=1
        }
        second+=1
        mg_TXF_timer.text = "\(minutes) : \(second)"
    }
    
    func finishGame(){
        mg_LBL_name.isHidden=false
        mg_TXF_name.isHidden=false
        mg_BTN_saveName.isHidden=false
        
    }
    func writeJson(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(player1)
        let temp :String = String(data: data, encoding: .utf8)!
        UserDefaults.standard.setValue(temp, forKey: "player")
    
    }
    func writeDict(){

        
        let preferences = UserDefaults.standard

        let currentKey = "player"

        let currentdict = player
        preferences.set(currentdict, forKey: currentKey)

        //  Save to disk
        let didSave = preferences.synchronize()

        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }

    }
    @IBAction func saveGameClick(_ sender: Any) {
        let _name = mg_TXF_name.text!
        let _minutes = minutes
        let _seconds = second
        let _moves = moves
       // player1 = Player(name: _name,minutes: _minutes,seconds: _seconds,moves: _moves)
        player = [ "name": _name as! AnyObject ,"minutes":_minutes as! AnyObject, "seconds":_seconds as! AnyObject,"moves":_moves as! AnyObject] 
        writeDict()
       //writeJson()
        self.dismiss(animated:true,completion:nil)

    }
    
    @IBAction func btnClick(_ sender: UIButton) {

        //print(dict[randCard[sender.tag]])
        if (nil == dict[randCard[sender.tag]]) {
            if firstCard==nil {
            firstCard = sender
            firstCard.setImage(UIImage(named: "c\(randCard[firstCard.tag])"), for: .normal)
            }else if secondCard==nil && sender != firstCard{
            secondCard = sender
                self.firstCard.isEnabled=false
                self.secondCard.isEnabled=false
                    self.secondCard.setImage(UIImage(named: "c\(self.randCard[(self.secondCard.tag)])"), for: .normal)
            if randCard[secondCard.tag]==randCard[firstCard.tag] && firstCard != secondCard{
                score+=1
                moves+=1
                mg_LBL_moves.text="\(moves)"
                dict[randCard[secondCard.tag]] = 2
                firstCard=nil
                secondCard=nil
            }
            else if(randCard[secondCard.tag] != randCard[firstCard.tag] && firstCard != secondCard){

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.firstCard.setImage(UIImage(named: "imgCardMemory"), for: .normal)
                    self.secondCard.setImage(UIImage(named: "imgCardMemory"),
                        for: .normal)
                    self.moves+=1
                    self.mg_LBL_moves.text="\(self.self.moves)"
                    self.firstCard.isEnabled=true
                    self.secondCard.isEnabled=true
                    self.firstCard=nil
                    self.secondCard=nil

                }

                
            }
        }
        }
      
        
        if(score==10 && choice==1){
            timer.invalidate()
            finishGame()
            
        }else if(score==8 && choice == 0){
            timer.invalidate()
            finishGame()
        }
        
        

    }
}
//extension UIView {
//    var allSubviews: [UIView] {
//        return self.subviews + self.subviews.map { $0.allSubviews }.joined()
//    }

