## 1. 배경 & 목적

---

- 게임 플레이 이력을 바탕으로 이상유저를 분류하는 문제입니다.
- 대부분의 변수는 비식별화가 적용되어 구체적인 의미를 알 수 없는 상황을 가정합니다.

## 2. 주최 & 참가 대상 & 성과

---

- 주최: FIND-A 코칭스터디 팀
- 성과: 팀 1등

## 3. 프로젝트 기간(대회 기간)

---

- 프로젝트 기간: 2023년 4월

## 4. 담당 역할

---

- 데이터 수집
- EDA
- 데이터 분석 및 모델링
- 보고서 작성
- 발표

## 5. 내용

---

- Data Preprocessing, Feature Generation, Scaling을 진행 해준 후 Classifier Model(DT Tree, Extra Tree, Randomforest, KNN) 들을 이용해서 분류를 진행해주었습니다.

## 6. 데이터 분석 Process

---

### Ch0**. Import**

- Import Library
- Load Data

### Ch**1. Data Preprocessing**

- Checking Column
- Missing Value
- Outlier
- Onehot Encoding

### Ch**2. Feature Generation**

- Heatmap
- Histogram
- 파생변수 생성

### Ch**3. Scaling**

- Standard Scale
- Log Scale

<img width="472" alt="게임 플레이 이력_1" src="https://github.com/Gayeon6423/Project/assets/113704015/286e77d1-ed5f-447f-b196-0b532fcb4b6d">

### Ch**4. Feature Importance**

- Feataue Importance 시각화

### Ch**5. Modeling**

- Data Split
- DecisionTreeClassifier
- RandomForestClassifier
- ExtraTreeClassifier
- LightBGM
- AdaBoostClassifier
- KNN
- HyperParameter Tuning

### Ch6. ****test파일 생성 및 성능 확인****

- test파일 생성
- test파일 성능 확인

<img width="592" alt="게임 플레이 이력_2" src="https://github.com/Gayeon6423/Project/assets/113704015/fc6eed75-4b58-473d-9ad0-76824e8f8e70">

## 7. 증빙자료

---

- 보고서 및 발표자료
    
    [게임플레이이력바탕_이상유저분류.pdf](https://drive.google.com/file/d/1BCafVVRLC7OCQyavgZwajCbCSQcQXJUk/view?usp=sharing)
    
    [게임 플레이 이력 바탕_이상유저 분류](https://www.notion.so/_-1f34ea0416254c829b2f594e0490b66f?pvs=21)
    
- 코드
    
    [코드](https://drive.google.com/file/d/1Thp2WmYsu2jGRNWqkBGREPwwsCDkixBa/view?usp=sharing)
