//: Playground - noun: a place where people can play

import UIKit
//
//클로저
//- 클로저는 일회용 함수를 작성할 수 있는 구문들의 집합이면서 그 형식은 함수로 작성되어야 하는 제약조건이 있을 때 만들어 사용할 수 있는 함수
//
//###클로저 표현식
//{() -> () in
//    print("클로저가 실행됩니다")
//    }
//- 반환값이 없을 때는 일반함수와 다르게 빈괄호를 사용하여 반환값이 없음을 명시적으로 표현해야 함
//- 반환값이 아예 없어서 작성되지 않은 경우와, 반환값이 있지만 생략된 경우를 컴파일러가 구분하게 하기 위함
//- 클로저 표현식은 대부분 인자값으로 함수를 넘겨주어야 할때 사용


//매개변수가 없는 클로저의 형태
({() -> (Void) in
    print("클로저A가 실행됨")
})()

let f = {() -> (Void) in
    print("클로저B가 실행됨")
}
f()

//매개변수가 있는 클로저의 형태
let c = {(s1:Int, s2:String) -> () in
    print("s1:\(s1), s2:\(s2)")
}
c(3,"이재성")

({(s1:Int, s2:String) -> () in
    print("s1:\(s1), s2:\(s2)")
})(1, "이혜진")


//클로저의 경우 가독성이 떨어지므로 작성시 간결성과 가독성의 비율을 항상 고려해야함.
//클로저 표현식은 주로 인자값으로 사용되는 객체인 만큼 간결성을 극대화하기 위해 생략할수 있는 구문들로 이루어져 있음.

  var value = [1,9,5,7,3,2]

//func order(s1:Int, s2:Int) -> Bool{
//    if s1 > s2 {
//        return true
//    } else {
//        return false
//    }
//}
//
//value.sort(by: order)


//order함수를 클로저 표현식으로 바꾸어 작성
//value.sort(by:{
//    (s1:Int, s2:Int) -> Bool in
//    if s1 > s2 {
//        return true
//    } else {
//        return false
//    }
//})

//클로져 표현식 간결화 1
//{ (s1:Int, s2:Int) -> Bool in
//    return s1 > s2
//}
//value.sort(by: {(s1:Int, s2:Int) -> Bool in return s1 > s2})


//클로저 표현식 간결화 2 - 반환값 타입을 컴파일러가 추론 (Bool)
//{ (s1:Int, s2:Int)  in
//    return s1 > s2
//}
//value.sort(by: {(s1:Int, s2:Int)  in return s1 > s2 })
//print(value)


//클로저 표현식 간결화 3 - 매개변수 타입 어노테이션이 생략되면서 매개변수를 감싸고 있던 괄호도 함께 생략
//value.sort(by:{ s1, s2 in return s1 > s2 })
//print(value)


//매개변수가 생략되면 매개변수명 대신 $0, $1, $2와 같은 이름으로 할당된 내부 상수를 이용할수 있음. 이값은 입력받은 인자값의 순서대로 매칭됨
//value.sort(by: { return $0 > $1 })
//print(value)

//클로저 표현식 간결화 4 - 연산자함수를 이용
//value.sort(by: > )
//print(value)
