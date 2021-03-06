# Ch.13 iOS앱의 구조와 코코아 터치 프레임워크
- 앱은 기본적으로 시스템 프레임워크에 정의된 원리에 따라 동작하지만, 이 영역을 제외한 나머지 범위에서는 커스텀 코드를 통해 원하는 기능과 유저 인터페이스를 구현할수 있음

## 13.1앱의 기본 구조
### 13.1.1 엔트리 포인트와 앱의 초기화 과정
- Objective-C 도 C를 기반으로 하고 있기 때문에 이를 이용하여 만들어진 iOS앱도 main()함수로부터 시작됨
- main()함수가 하는일은 실행시 시스템으로부터 전달받은 두 개의 인자값과 AppDelegate클래스를 이용하여 UIApplicationMain()함수를 호출하고 그결과로 UIApplication 객체를 반환
- 생성된 UIApplication 객체는 UIKit 프레임 워크에 속해있으므로 이후의 앱 제어권은 UIKit 프레임워크로 이관됨
- UIApplicationMain()함수는 iOS앱에 속하는 부분의 엔트리포인트라고 할수 있음
- 이 함수는 앱의 핵심객체를 생성하는 프로세스를 핸들링하고, 스토리보드 파일로부터 앱의 유저 인터페이스를 읽어들일뿐만 아니라 내가 작성한 커스텀 코드를 호출해줌으로써 앱 생성 초기에 필요한 설정을 구현할 수 있게 해줌, 또한 이벤트를 입력받기 위한 이벤트 루프를 실행시키키도 함
- UIApplicationMain()함수가 생성하는 UIApplication은 앱의 본체라고 할 수 있는 객체로 사실상 앱 그 자체를 의미함.
- UIApplication 객체는 AppDelegate라는 대리 객체를 내세우고 커스텀 코드를 처리할 수 있도록 약간의 권한을 부여함
- AppDelegate는 UIApplication으로부터 위임받은 일부 권한을 이용하여 커스텀 코드와 상호 작용을 하는 역할을 담당하고, 이를 통해 우리가 필요한 코드를 구현할 수 있도록 도와줌
- AppDelegate객체는 iOS 애플리케이션 내에서 오직 하나의 인스턴스만 생성되도록 시스템 적으로 보장을 받음
	- 앱이 처음 만들어 질때 객체가 생성되고 앱이 실행되는 동안 계속 유지되다가 앱이 종료되면 그때 함께 소멸하는 등 앱 전체의 생명주기와 함께 함

- Swift에서는 직접 UIApplicationMain()을 호출하여 delegate 클래스를 인자값으로 전달할 수 없으므로 대신 앱 델리게이트 역할을 할 클래스에 @UIApplicationMain 어노테이션을 걸어 표시하는 방식으로 시스템에 델리게이트 클래스 정보를 전달함.


![](7.png)

- Swift에서는 Main()함수를 통해 UIApplicationMain()을 호출하는 대신 @UIApplicationMain어노테이션을 찾아 해당 클래스를 실행
- application(_:didFiniShingLaunchingWithOptions:)메소드에 원하는 커스텀 코드를 작성해 두면 앱이 처음 시작될때 해당 코드를 실행할 수 있음
- 이벤트 루프가 실행되면서 내가 작성한 이벤트 핸들에 의해 커스텀 코드로 연결됨(핸들은 @IBAction등등)
- 앱이 실행목적 완료하고 더이상 사용되지 않으면 시스템은 앱을 메모리에서 제거하기 위한 준비를 함
- 이 과정에서 앱 시스템은 델리게이트 클래스applicationWillTerminate(_:)메소드를 호출, 앱 종료시 처리해야할 내용이 있다면 이 메소드 내부에 커스텀 코드로 작성해 두기만 하면 됨


#### 자세한 그림 참고
#### *Launching an app into the foreground
![](8.png)
#### *Launching an app into the background
![](9.png)
#### *Handling alert-based interruptions
![](10.png)
#### *Transitioning from the background to the foreground
![](11.png)
#### *Moving from the foreground to the background
![](12.png)



#### <[애플공식문서 참고링크] (https://goo.gl/4eEd4U)>

### 13.1.2 MVC패턴
- iOS 앱의 객체 관계는 MVC패턴에 기반하고 있음
- 모델(Model) - 데이터를 담당
- 뷰(View) - 데이터에 대한 화면 표현을 담당
- 컨트롤러(Controller) - 모델과 뷰 사이에 위치하여 데이터를 가공하여 뷰로 전달하고 뷰에서 발생하는 이벤트를 입력받아 처리하는 역할을 담당


![](13.png)

- 각각의 역할로 쪼개고 나누어 놓은 이유는 많은 장점을 가지기 때문
- 가장 큰 장점은 앱에서 사용되는 데이터와 비즈니스 로직을 데이터에 대한 시작적인 표현으로부터 분리해 줌으로써 화면을 신경쓰지 않고도 데이터나 비즈니스 로직을 작성할 수 있다는 점

### 13.1.3 앱의 상태 변화
- 앱의 상태변화는 운영체제가 처리하는 영역
- iOS에서 앱이 가질수 있는 상태값은 다음과 같음

```
- Not Running : 앱이 시작되지 않았거나 실행되었지만 시스템에 의해 종료된 상태를 나타냄
- Inactive : 앱이 전면에서 실행중이지만, 아무런 이벤트를 받지 않고 있는 상태를 나타냄
- Active : 앱이 전면에서 실행중이며, 이벤트를 받고 있는 상태를 나타냄
- Background : 앱이 백그라운드에 있지만 여전히 코드가 실행되고 있는 상태를 나타냄
- Suspended : 앱이 메모리에 유지되지만 실행되는 코드가 없는 상태
```
![](14.png)

- 앱의 상태가 변화할 때마다 앱 객체는 앱 델리게이트에 정의된 특정 메소드를 호출
- 주요 메소드는 다음과 같음

```
application(_:willFinishLaunchingWithOptions:)
	- 앱이 구동되어 필요한 초기실행과정이 완료되기 직전에 호출되는 메소드
application(_:didFinishLaunchingWithOptions:)
	- 앱이 사용자에게 화면으로 표시되기 직전에 호출되는 메소드
applicationDidBecomeActive(_:)
	- 실행된 앱이 포그라운드, 즉 화면 전면에 표시될때 호출되는 메소드
applicationDidEnterBackground(_:)
	- 앱이 백그라운드 상태에 진입했을때 호출
applicationWillTermainate(_:)
	- 앱이 종료되기 직전에 호출되는 메소드
```
#### [UIAppdelegateProtocol 공식문서 링크](https://goo.gl/mfZk74)


## 13.2 iOS와 코코아 터치 프레임 워크
### 13.2.1 iOS
### 13.2.2 코코아 터치 프레임워크

## 13.3 앱을 구성하는 핵심 객체들
### 13.3.1 iOS 유저 인터페이스의 표현구조
- 윈도우는 iOS에서 디바이스의 스크린을 빈틈없이 채우기 위한 객체로, 항상 유저 인터페이스 표현 계층의 최상위에 위치
- 뷰는 콘텐츠를 담아 이를 스크린상에 표시하고 사용자의 입력에 반응
- 윈도우 객체는 항상 루트 뷰 컨트롤러만을 참조
- 컨텐츠 뷰 컨트롤러 : 씬을 담당하고 콘텐츠를 표시하는 컨트롤러
- 컨테이너 뷰 컨트롤러 : 콘텐츠를 배치하는 대신 다른 뷰 컨트롤러를 배치하고, 이들을 서로 유기적인 관계로 엮이도록 만들어줌

### 13.3.2 뷰 컨트롤러
- 뷰 컨트롤러는 앱의 근간을 이루는 객체로 모든 앱은 최소한 하나 이상의 뷰 컨트롤러로 구성
- View Controller : iOS 에서 가장 기본이 되는 컨트롤러로서 앱의 데이터와 표시될 외형을 연결해서 하나의 동적인 화면을 만들어 내는 컨트롤러. 내부에 뷰를 포함하고 있음 (UIKit프레임워크의 클래스는 UIViewController)
- Navigation Controller : 앱의 화면 이동에 관한 관리와 그에 연관된 처리를 담당해주는 컨트롤러, 뷰를 포함하고 있지 않으므로 다른 컨트롤러와 결합하여 부분적으로 화면을 구성 (UIKit프레임워크의 클래스는 UINavigationController)
- Table View Controller : 내부에 리스트 형식의 테이블 뷰를 포함하고 있어 여러 항목이나 데이터를 화면에 나열하기 위한 목적으로 사용되는 컨트롤러 (UIKit프레임워크의 클래스는 UITableViewController)
- Tab Bar Controller : 화면을 나타내는 여러개의 탭이 있고 탭을 터치하면 화면이 전환되는 형태의 앱을 만들고자 할 때 사용되는 컨트롤러 (UIKit프레임워크의 클래스는 UITabbarController)
- Split View Controller : (UIKit프레임워크의 클래스는 UISplitViewController)

### 13.3.3 뷰컨트롤러의 상태변화와 생명주기
- 뷰컨트롤러의 생명 주기는 장면(Scene)의 전환과 복귀에 밀접하게 연관되어 있음
- 뷰 컨트롤러는 다음과 같이 네가지 상태로 나눌수 있음

```
	- Appearing : 뷰 컨트롤러가 스크린에 등장하기 시작한 순간부터 등장을 완료하기 직전까지의 상태
	- Appeared : 뷰 컨트롤러가 스크린 전체에 완전히 등장한 상태
	- Disappearing : 뷰 컨트롤러가 스크린에서 가려지기 시작해서 완전히 가려지기 직전까지의 상태
	- Disappeared : 뷰 컨트롤러가 스크린에서 완전히 가려졌거나 혹은 퇴장한 상태
```
![](15.png)

- 화면이 처음 실행되거나 또는 퇴장한 상태에서 다시 등장하기 시작하는 상태(Appearing)로 바뀌는 동안 뷰 컨트롤러는 앱 객체에 의해 viewWillAppear(_:)메소드가 호출
- 화면이 등장하기 시작한 단계를 넘어서 완전히 등장하고 나면 viewDidAppear(_:) 메소드가 호출
- 이 상태에서 다른 액션이 일어나 화면의 전환이 이루어지거나 홈 버튼을 눌러 앱이 백그라운드로 내려가는등 스크린에서 화면이 퇴장하는 상태 변화가 발생하면 그 즉시 viewWillDisappear(_:) 메소드가 호출
- 상태 변화가 완료 되었을때 viewDidDisappear(_:)메소드가 호출

# Life Cycle
![](6.png)
![](5.png)
![](4.png)
![](3.png)
![](2.png)
![](1.png)


