# Ch.1 플레이그라운드 살펴보기


## 데이터 구조의 중요성
- 데이터 구조는 프로그래밍에 있어 효율적이며, 확장가능하고 유지 보수성 높은 시스템을 만들기 위한 주요요소중 하나로서, 시스템에서 데이터의 공유, 유지, 정렬, 검색등 데이터 활용을 위한 데이터의 체계화 방법이다.

### 데이터 구조 + 알고리즘 = 프로그램
- 데이터의 추상화(abstraction)기법은 데이터가 지닌 복잡성을 관리하기 위한 기술이다.
- 데이터 구조를 디자인할 때 데이터 추상화 기법을 사용하는데, 이는 개발자가 애플리케이션을 만들려고 할 때 내부의 상세한 구현 방식을 몰라도 되도록 하기 위함이다.
- 내부의 복잡한 구현 방식을 드러내지 않음으로써 개발자는 알고리즘이 제공하는 인터페이스의 활용에 더욱 집중할 수 있으며, 이 때문에 데이터 구조는 프로그램 내부에서 구현하게 된다.

## 기본적인 데이터 구조
- 데이터 구조의 가장 근원적인 형태는 사실상 배열과 포인터 두가지 타입이며, 다른 데이터 구조는 여기서 파생된다고 할 수 있다.
	- 인접 데이터 구조(Contiguous Data Structures) : 데이터를 메모리 영역 중 인접한 부분에 저장한다
		- Arrays, Heaps, Matrices, Hash Tables 등이 있다.
	- 연결 데이터 구조(Linked Data Structures) : 서로 명확히 구분되는 메모리 영역을 차지하되, 포인터라는 주소 체계로 연결, 관리되는  구조이다
		- Lists, Trees, Graphs 등이 있다.

### 인접 데이터 구조
[1] 배열(Array)

- 일차원배열(선형배열)
	- swift에서 배열의 인덱스 값은 0부터 시작하며, 데이터 간에 순서가 있으먀, 임의로 특정 요소에 접근할 수 있는 데이터 집합의 성질을 지닌다.
- 다차원배열
	- 행렬은 다차원 배열의 대표적인 형식

[2] 배열 선언

- var myIntArray: Array<Int> = [1,3,5,7,9] / 기본형
- var myIntArray: [Int] = [1,3,5,7,9] / 축약형
- var myIntArray = [1,3,5,7,9] / 타입추측
- var my2Darray =[[Int]] = [[1,2],[10,11],[20,30]] / 다중 배열

[3] 배열 요소 가져오기
```
6> var myIntArray: [Int] = [1,3,5,7,9]
myIntArray: [Int] = 5 values {
  [0] = 1
  [1] = 3
  [2] = 5
  [3] = 7
  [4] = 9
}
  7> var someNumber = myIntArray[2]
someNumber: Int = 5
  8> for elemebt in myIntArray {
  9.     print(elemebt)
 10. }
1
3
5
7
9
 11> var someSubset = myIntArray[2...4]
someSubset: ArraySlice<Int> = 3 values {
  [2] = 5
  [3] = 7
  [4] = 9
}

12> var my2dArray: [[Int]] = [[1,2],[10,11],[20,30]]
my2dArray: [[Int]] = 3 values {
  [0] = 2 values {
    [0] = 1
    [1] = 2
  }
  [1] = 2 values {
    [0] = 10
    [1] = 11
  }
  [2] = 2 values {
    [0] = 20
    [1] = 30
  }
}
 13> var element = my2dArray[0][0]
element: Int = 1
 14> element = my2dArray[1][1]
 15> print(element)
11
```

[4] 배열 요소 추가

- 기존 배열의 맨 끝 부분에 요소를 추가하는 방법

```
16> var myIntArray = [1,3,5,7,9]
myIntArray: [Int] = 5 values {
  [0] = 1
  [1] = 3
  [2] = 5
  [3] = 7
  [4] = 9
}
 17> myIntArray.append(10)
 18> print(myIntArray)
[1, 3, 5, 7, 9, 10]
```

- 기존 배열의 특정 인덱스 위치에 요소를 삽입하는 방법

```
19> var myIntArray: [Int] = [1,3,5,7,9]
myIntArray: [Int] = 5 values {
  [0] = 1
  [1] = 3
  [2] = 5
  [3] = 7
  [4] = 9
}
 20> myIntArray.insert(4, at:2)
 21> print(myIntArray)
[1, 3, 4, 5, 7, 9]
```

[5] 배열 요소 삭제

- 배열의 맨 끝 부분에 있는 요소를 삭제 하는 방법

```
22> var myIntArray: [Int] = [1,3]
myIntArray: [Int] = 2 values {
  [0] = 1
  [1] = 3
}
 23> myIntArray.removeLast()
$R2: Int = 3
 24> print(myIntArray)
[1]
```

- 특정 인덱스 위치의 요소를 삭제하는 방법

```
25> var myIntArray: [Int] = [1,3,5,7,9]
myIntArray: [Int] = 5 values {
  [0] = 1
  [1] = 3
  [2] = 5
  [3] = 7
  [4] = 9
}
 26> myIntArray.remove(at: 3)
$R3: Int = 7
 27> print(myIntArray)
[1, 3, 5, 9]
```

### 연결 데이터 구조
- 연결 데이터 구조는 데이터 타입과 이를 다른 데이터와 묶어주는 포인터로 구성된다. 여기서 포인터(pointer)란 메모리상의 위치 주소를 의미한다.
- 스위프트는 직접적으로 포인터에 접근하지 않으먀, 포인터를 활용할 수 있는 별도의 추상 체계를 제공한다.
- 연결 리스트(linked list)
  - 일련의 노드로 구성되며, 이들 노드는 링크 필드를 통해 서로 연결되어 있다.
  - 가장 간단한 형태의 연결 리스트는 데이터와 다음 노드에 연결할 수 있는 레퍼런스(또는 링크)정보를 포함한다.
  - 좀 더 복잡한 형태의 경우, 추가 링크 정보를 통해 연결된 데이터에서 앞 또는 뒤로 이동할 수 있다.
  - 연결 리스트에서 추가 노드를 삽입하거나 삭제하는 일은 매우 간단하다.

### 단일 연결 리스트
```
28> class LinkedList<T> {
 29.     var item: T?
 30.     var next: LinkedList<T>?
 31. }
```
- 자세한 연결 리스트 구현은 3장으로..


## 데이터 구조의 종류와 단점
-
### 알고리즘 개요
- 대부분의 데이터 구조에서 다음과 같은 내용은 필수적으로 파악하고 있어야 한다.

  - 새로운 데이터 아이템을 삽입하는 방법
  - 데이터 아이템을 삭제하는 방법
  - 특정 데이터 아이템을 찾는 방법
  - 모든 데이터 아이템을 순회하는 방법
  - 데이터 아이템을 정렬하는 방법


## 스위프트에서의 데이터 타입
### 벨류 타입과 레퍼런스 타입
- 스위프트의 기본 데이터 타입은 벨류 타입과 레퍼런스 타입 두가지이다.
- 벨류 타입은 오직 하나의 소유 객체만을 지니며, 해당 타입의 데이터가 변수 또는 상수에 할당됐을 때 혹은 함수에 전달됐을 때, 지니고 있던 값을 복사한다
- 벨류 타입에는 다시 구조체와 열거형, 두 가지 유형이 있으며, 스위프트의 모든 데이터 타입은 기본적으로 구조체이다.
- 반면, 레퍼런스 타입은 벨류 타입과 달리 값을 복사하지 않고 공유한다.
- 즉, 레퍼런스 타입은 변수에 할당하거나 함수에 전달할 때 값을 복사해서 제공하는 대신 동일한 인스턴스를 참조값으로 활용한다.
- 레퍼런스 타입은 여러 개의 소유 객체가 참조라는 방식으로 공유할 수 있다.
### 기명 타입과 복합 타입
- 스위프트의 또 다른 데이터 타입 분류 체계는 기명 타입(named type) 과 복합 타입(compound type)이다.
- 기명 타입은 사용자가 정의할 수 있는 데이터 타입이자, 해당 타입이 정의될 당시 특정한 이름을 부여할 수 있는 타입이다.
- 기명 타입에는 클래스, 구조체, 열거형, 프로토타입이 있다
- 사용자 정의 기명 타입 외에 스위프트 라이브러리에는 배열, 딕셔너리, 세트, 옵셔널 값을 나타낼 수 있는 기명 타입이 별도로 마련되어 있다.
- 또한 기명 타입은 익스텐션 선언을 통해 동작 범위를 확장할 수 있다.
- 복합 타입은 별도의 이름이 붙여지지 않은 타입이며, 스위프트에서는 function 타입과 tuple 타입 두개의 복합 타입이 정의 되어 있다.

### 타입 에일리어스
- 타입 에일리어스는 기존의 타입을 또 다른 이름으로 부를 수 있는 방법을 제공한다
```
32> typealias TCPPacket = UInt16
 33> var maxTCPPacketSize = TCPPacket.max
maxTCPPacketSize: UInt16 = 65535
```

### 스위프트 표준 라이브러리 컬렌션 타입
- 스위프트는 배열, 딕셔너리, 세트 등 세가지의 컬렉션 타입을 제공한다.
- 이외에도 정식 컬렉션 타입은 아니지만, 복합적인 값을 한꺼번에 묶어서 사용할 수 있는 튜플도 있다.



## 점근적 분석
### 데이터 크기 분석 방법
```
func insertionSort(alist: inout [Int]){
    for i in 1..<alist.count {
        let tmp = alist[i]
        var j = i-1
        while (j >= 0 && alist[j] > tmp) {
            alist[j+1] = alist[j]
            j = j-1
        }
        alist[j+1] = tmp
    }
}
```

## 정리
