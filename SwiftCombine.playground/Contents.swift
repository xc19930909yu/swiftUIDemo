import UIKit
import Combine

var greeting = "Hello, playground"

final class  CommonOperationDemo {
    
    private var cancellabels = Set<AnyCancellable>()
    
    func printDemo() {
        [1,2].publisher
            .print("_")
            .sink { _ in
            }
            .store(in: &cancellabels)
    }
    
    //breakpoint 操作符可以发送调试信号来让调试器暂停进程的运行，只要在给定的闭包中返回 true 即可。
    func breakpointDemo() {
        [1,2].publisher
            .breakpoint(receiveSubscription: { subscription in
                return false  //返回 true 以抛出 SIGTRAP 中断信号，调试器会被调起
            }, receiveOutput: { value in
                return false  //返回 true 以抛出 SIGTRAP 中断信号，调试器会被调起
            }, receiveCompletion: { completion in
                return false  //返回 true 以抛出 SIGTRAP 中断信号，调试器会被调起
            })
            .sink { _ in
                
            }
            .store(in: &cancellabels)
        
    }
    
}


CommonOperationDemo().printDemo()

CommonOperationDemo().breakpointDemo()




// Combine中的Subjects  PassthroughSubject对象
final class  SubjectsDemo {
    
    private var cancellable: AnyCancellable?
    private let passThroughtSubject = PassthroughSubject<Int, Never>()
    
    
    func passThroughtSubjectDemo() {
        cancellable = passThroughtSubject
            .sink(receiveValue: {
                print(#function, $0)
            })
        
        passThroughtSubject.send(1)
        passThroughtSubject.send(2)
        passThroughtSubject.send(3)
    }
}

SubjectsDemo().passThroughtSubjectDemo()


// Subject作为订阅者 CurrentValueSubject对象
final  class   SubjecttwoDemo {
    
    private var cancellable: AnyCancellable?
    private let currentValueSubject = CurrentValueSubject<Int, Never>(1)
    
    func currentValueSubjectDemo() {
        cancellable = currentValueSubject
            .sink(receiveValue: {
                print(#function,$0)
                print("Value of currentValueSubject:", self.currentValueSubject.value)
            })
        
        currentValueSubject.send(2)
        currentValueSubject.send(3)
        
    }
}


SubjecttwoDemo().currentValueSubjectDemo()


//Subject 作为订阅者
final  class  SubjectThreeDemo {
    
    private  var  cancellable1: AnyCancellable?
    private  var  cancellable2: AnyCancellable?
    
    private  let optionalCurrentValueSubject = CurrentValueSubject<Int?,Never>(nil)
    
    func  subjectSubscriber(){
        cancellable1 = optionalCurrentValueSubject
            .sink {
                print(#function, $0  ?? 0)
            }
        
        cancellable2 = [1,2,3].publisher
            .subscribe(optionalCurrentValueSubject)
    }
}

SubjectThreeDemo().subjectSubscriber()



// 使用Subject时，我们不会将其暴露给调用方。这时候，可以使用eraseToAnyPublisher操作符来隐藏内部的Subject
struct Model {
    let id: UUID
    let name: String
}

final class  ViewModel {
    private let modelSubject = CurrentValueSubject<Model?,Never>(nil)
    var  modelPublisher:AnyPublisher<Model? ,Never>{
        return modelSubject.eraseToAnyPublisher()
    }
    
    func updateName(_ name: String) {
        modelSubject.send(.init(id: UUID(), name: name))
    }
}


ViewModel().updateName("hello")
