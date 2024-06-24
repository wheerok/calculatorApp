import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView()
        keypadView()
    }
    var resultString :String = "0" {
        didSet {
            resultLabel.text = resultString
        }
    }
    var resultLabel = UILabel()
    
    func resultView() {
        view.backgroundColor = .black
        resultLabel.text = "\(resultString)"
        resultLabel.textColor = .white
        resultLabel.font = UIFont.boldSystemFont(ofSize: 60)
        resultLabel.textAlignment = .right
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints{
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(30)
        }
    } //resultView
    
    func keypadView() {
        
        //line1
        let keypadBtn7 = UIButton()
        keypadBtn7.setTitle("7", for: .normal)
        
        let keypadBtn8 = UIButton()
        keypadBtn8.setTitle("8", for: .normal)
        
        let keypadBtn9 = UIButton()
        keypadBtn9.setTitle("9", for: .normal)
        
        let keypadBtnPlus = UIButton()
        keypadBtnPlus.setTitle("+", for: .normal)
        
        
        //line2
        let keypadBtn4 = UIButton()
        keypadBtn4.setTitle("4", for: .normal)
        
        let keypadBtn5 = UIButton()
        keypadBtn5.setTitle("5", for: .normal)
        
        let keypadBtn6 = UIButton()
        keypadBtn6.setTitle("6", for: .normal)
        
        let keypadBtnMinus = UIButton()
        keypadBtnMinus.setTitle("-", for: .normal)
        
        //line3
        let keypadBtn1 = UIButton()
        keypadBtn1.setTitle("1", for: .normal)
        
        let keypadBtn2 = UIButton()
        keypadBtn2.setTitle("2", for: .normal)
        
        let keypadBtn3 = UIButton()
        keypadBtn3.setTitle("3", for: .normal)
        
        let keypadBtnMultiply = UIButton()
        keypadBtnMultiply.setTitle("*", for: .normal)
        
        //line4
        let keypadBtnAC = UIButton()
        keypadBtnAC.setTitle("AC", for: .normal)
        
        let keypadBtn0 = UIButton()
        keypadBtn0.setTitle("0", for: .normal)
        
        let keypadBtnEquals = UIButton()
        keypadBtnEquals.setTitle("=", for: .normal)
        
        let keypadBtnDivide = UIButton()
        keypadBtnDivide.setTitle("/", for: .normal)
        
        let keypadBtnArr1 :[UIButton] = [keypadBtn7, keypadBtn8, keypadBtn9, keypadBtnPlus]
        let keypadBtnArr2 :[UIButton] = [keypadBtn4, keypadBtn5, keypadBtn6, keypadBtnMinus]
        let keypadBtnArr3 :[UIButton] = [keypadBtn1, keypadBtn2, keypadBtn3, keypadBtnMultiply]
        let keypadBtnArr4 :[UIButton] = [keypadBtnAC, keypadBtn0, keypadBtnEquals, keypadBtnDivide]
        
        for button in keypadBtnArr1 + keypadBtnArr2 + keypadBtnArr3 + keypadBtnArr4{
            // in에 여러 개를 추가 시 +로 연결하면 됨
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.titleLabel?.textColor = .white
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
            button.layer.cornerRadius = 40
            button.addTarget(self, action: #selector(btnTaped(_:)), for: .touchDown)
        }
    
        
        // 연산자 버튼 컬러 변경
        let operators :[UIButton] = [keypadBtnPlus, keypadBtnMinus, keypadBtnMultiply,
                                     keypadBtnAC, keypadBtnEquals, keypadBtnDivide]
        
        for oper in operators {
            oper.backgroundColor = UIColor.orange
        }
        
        // 수평 스택뷰 생성 (수평 라인이 4번 들어가야 하기 때문에 재사용성을 높이기 위하여 함수 사용)
        func makeHorizontalStackView(_ views: [UIButton]) -> UIStackView{
            //makeHorizontalStackView 함수는 매개변수로 UIButton타입 배열을 가진 views가 있다,
            let stackView = UIStackView(arrangedSubviews: views)
            //상수 stackView에 UIStackView(arrangedSubviews: views)를 할당하여 스택뷰 생성
            //arrangedSubviews는 UIStackView가 가진 속성으로, 스택뷰에 추가된 뷰들의 배열이다.
            //스택 뷰(Stack View)는 여러 개의 버튼이나 레이블 같은 것들을 가지런히 정렬해주는 상자라고 생각하기
            //이 상자 안에 들어가는 것들을 우리는 arrangedSubviews라고 부른다.
            stackView.axis = .horizontal
            stackView.backgroundColor = .black
            stackView.spacing = 10
            stackView.distribution = .equalSpacing
            return stackView
        }
        
        
        let stackView1 = makeHorizontalStackView(keypadBtnArr1)
        let stackView2 = makeHorizontalStackView(keypadBtnArr2)
        let stackView3 = makeHorizontalStackView(keypadBtnArr3)
        let stackView4 = makeHorizontalStackView(keypadBtnArr4)
        
        [stackView1, stackView2, stackView3, stackView4].forEach{view.addSubview($0)}
        
        
        let verticalStackView = UIStackView(arrangedSubviews: [stackView1, stackView2, stackView3, stackView4])
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints{
            $0.width.equalTo(350)
            $0.top.equalTo(resultLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
//            $0.leading.equalTo(view.snp.leading).offset(20)
//            $0.trailing.equalTo(view.snp.trailing).offset(-20)
        }
    }
    
        @objc
        func btnTaped(_ sender : UIButton) {
            guard let btnText = sender.title(for: .normal) else { return }
            
            //AC 클릭 시 초기회
            if btnText == "AC" { //UIButton의 title이 AC면
                resultString = "0" // resultString의 값을 0으로
            } else if resultString == "0" {
                resultString = btnText
            } else if btnText == "="{
                if let result = calculate(expression: resultString){
                    resultString = "\(result)"
                } else {
                    resultString = "Error"
                } //if let
            } else {
                resultString += btnText
            }
        }// btnTape
    
        func calculate(expression: String) -> Int? {
            let expression = NSExpression(format: expression)
            if let result = expression.expressionValue(with: nil, context: nil) as? Int {
                return result
            } else {
                return nil
            }
        }
    
    }
    

