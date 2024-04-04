# RxSwift.with_Gom

#### RxSwift는 Swift에 ReactiveX를 적용시켜 비동기 프로그래밍을 작성할 수 있도록 지원하는 라이브러리입니다.

## RxSwift의 기본문법 (Doc참고)
#### Observable의 생명주기
* 1.Create
> Observable.create() : 직접적인 코드 구현을 통해 옵저버 메서드를 호출하여 Observable을 생성한다.
* 2.Subscribe
> observable.subscribe{ event in } : Observable이 배출하는 항목과 알림을 기반으로 동작
* 3.onNext
> emitter.onNext(json) : onNext에 매개변수로 넘겨 사용
* 4.onCompleted or onError
> guard err == nil else { emitter.onError(err!) return } : 에러처리 또는 정상 종료 처리
* 5.onCompleted or onError
> disposed(by: DisposeBag()) : Observable 해제

## RxSwift (Subject)
#### Observable과 Observer간의 연결 ( 외부에서 변화가 있을 시 처리시켜주는 개념 )
* 1.PublishSubject : Element없이 빈 상태로 생성, subscribe한 이후에 항목들만 전달
* 2.BehaviorSubject : 초기값을 한번 방출한 이후, Observable에 의해 방출된 항목들을 Observer에 전달
* 3.AsyncSubject : completed 이벤트가 전달되기 전까지 이벤트 발생 X, completed 이벤트가 전달되는 시점에 가장 최근에 전달된 값만 방출
* 4.ReplaySubject : Observer가 subscribe할 때 버퍼에 있는 모든 이벤트를 전달 ( 메모리 관리 중요 )
