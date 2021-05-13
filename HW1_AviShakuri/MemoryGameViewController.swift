//
//  MemoryGameViewController.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 06/05/2021.
//

import UIKit

class MemoryGameViewController: UIViewController {
    @IBOutlet weak var mg_LBL_moves: UILabel!

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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi memory game")
        resizeStackView()
        startGame()
        
        }

    func resizeStackView(){
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
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
            
        }else if(score==8){
            timer.invalidate()
        }
        
        

    }
}
extension UIView {
    var allSubviews: [UIView] {
        return self.subviews + self.subviews.map { $0.allSubviews }.joined()
    }
}
