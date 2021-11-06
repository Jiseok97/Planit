# Planit 📖
***Start → 21.10.13***

</br>

## 📱 View Progress ▾
* Login View → ✅

* Terms of Use View → ✅

* Input User Name & NickName View → ✅

* Select User Gender View → ✅

* Input User Date of birth View → ✅

* Select User Job View → ✅

* Input Recommender View → ✅

* Added BaseTabBar Controller → ✅

* Home View → ***proceeding***

</br>

## 🔗 API Progress ▾
* Validate-nickname → ✅

* Register User → ✅
    * Validate-recommender-nickname → ✅

* Login → ✅

* Token renewal → ✅   *dev only & didn't apply* 😱

</br>


## Additional Info 🚴🏻
* **Coming to use "Moya" library (Server)** → ***code refactoring***

</br> </br>

## Dev Issues ☕️

* Collection View Layout ⁉️
* 문제의 화면 ▾
<img width="290" alt="Issue" src="https://user-images.githubusercontent.com/64394744/140598746-18606682-2df4-4924-8d75-fd464e3d4132.png">

* 위 사진처럼 처음 뷰가 로드될 때, Layout이 밀려서 나왔다가 드래그를 해야 정의했던 Width 값으로 돌아갔다.
* 이를 해결하기 위해서 아래와 같이 코드를 넣어주었다.

```swift

if let collectionViewLayout = studyLstCV.collectionViewLayout as? UICollectionViewFlowLayout {
    collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
}

```

* **estimatedItemSize**는 셀의 크기가 고정되는 것은 아니지만 동적으로 크기를 바꾸어야 할 ㅅ때 실제 크기와 estimatedItemSize의 값이 차이가 적을수록 계산이 빨라 퍼포먼스 향상에 도움이 된다고 한다.

* 해결된 화면 ▾
<img width="293" alt="Issue" src="https://user-images.githubusercontent.com/64394744/140598873-7afc97ad-6ceb-43e9-823a-d5a5842863a1.png">
