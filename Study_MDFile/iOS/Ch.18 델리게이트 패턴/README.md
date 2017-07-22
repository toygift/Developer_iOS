# Ch.18 델리게이트 패턴

* iOS 앱의 객체는 델리게이트 패턴이라고 불리는 일종의 위임 패턴을 많이 사용함
> 델리게이트 패턴   
> 객체지향 프로그래밍에서 하나의 객체가 모든일을 처리하는것이 아니라 처리해야 할 일중 일부를 다른 객체에 넘기는 것을 말함. 효율성 관점에서 아주 중요한 역할  

## 18.1 텍스트 필드
* 텍스트 필드에 델리게이트 패턴을 적용하려면 다음과 같은 두가지 작업이 필요함
	* 텍스트필드에 대한 델리게이트 프로토콜을 구현
	* 텍스트필드의 델리게이트 속성을 뷰 컨트롤러에 연결
* 델리게이트 프로토콜을 구현한다는 것은 프로토콜에 정의된 메소드를 실질적으로 정의하는 것 까지를 포함(@optional키워드가 붙은 메소드는 선택적)

### 18.1.1 텍스트 필드의 특성
```
inputText.borderStyle = UITextBorderStyle.roundedRect
inputText.autocapitalizationType = UITextAutocapitalizationType.sentences
inputText.autocorrectionType = UITextAutocorrectionType.no
inputText.spellCheckingType = UITextSpellCheckingType.no
inputText.keyboardType = UIKeyboardType.emailAddress
inputText.keyboardAppearance = UIKeyboardAppearance.dark
inputText.returnKeyType = UIReturnKeyType.joinㅔ
inputText.enablesReturnKeyAutomatically = true
inputText.isSecureTextEntry = true
```

> 최초 응답자(First Responder)  
> UIWindow는 이벤트가 발생했을때 우선적으로 응답한 객체를 가리키는 최초 응답자라는 포인터를 가지고 있음  
> 특정 객체를 최초 응답자로 만들고 싶다면 그 객체에 대한 becomeFirstResponder()메소드를 호출하면 됨. 이 메소드는 UIResponder클래스에 정의 되어 있음. 이 클래스를 상속 받은 객체들은 모두 becomeFirstResponder() 메소드를 호출하여 최초 응답자 객체가 될 수 있음.  
> 해당 객체로부터 최초 응답자 상태를 해제하고 싶을 때에는 resignFirstResponder()메소드를 호출하면 됨  

### 18.1.2 텍스트 필드에 델리게이트 패턴 적용하기
* self.inputText.delegate = self
* 텍스트 필드의 delegate는 텍스트 필드에 특정 이벤트가 발생했을 때 알려줄 대상 객체를 가리키는 속성
* 이 속성에 대입된 self는 현재의 뷰 컨트롤러 인스턴스를 의미
> 뷰 컨트롤러가 텍스트 필트의 델리게이트 객체로 지정되었다!  

## 18.2 이미지 피커 컨트롤러
