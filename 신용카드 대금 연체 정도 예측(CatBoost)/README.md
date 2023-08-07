---

## 1. 배경 & 목적

---

- 신용카드 사용자들의 개인 신상 정보 데이터로 사용자의 신용카드 대금 연체 정도를 예측하는 task를 진행하였다.
- Dacon에서 Competition형식으로 진행하였다.
- 데이터를 통해 주어진 task를 가장 잘 수행하는 기계학습 알고리즘을 구축하였다. 학습 성능 뿐만 아니라 일반화 성능을 높이는 방향으로 학습을 진행했다. task에 적합한 feature를 생성하였고 데이터 형태에 따른 적합한 전처리를 수행하였다. 또한 적절한 모델과 하이퍼파라미터를 선정하기 위해 노력했다.

## 2. 주최 & 참가 대상 & 성과

---

- 주최: 데이터분석학회 D&A Machine Learning Session 프로젝트
- 참가 자격 및 팀 인원 제한 사항: D&A Machine Learning Session 팀원
- 성과: 참가

## 3. 프로젝트 기간

---

- Competition기간: 2023년 6월~7월C

## 4. 담당 역할

---

- Data Preprocessiong(Missing Value, Outlier)
- Feature Engineering
- Feature Generation
- Encoding
- Modeling 및 결과 해석

## 5. 내용

---

- gender, age, income, employ등의 feature를 이용해서 credit값을 0과 1로 분류하는 모델을 만들었다.
- Feature Preprocessing & Engineering, Featrue Generation, Encoding, Scaling, Feaure Selection을 진행하였고 모델링 과정에서는 Pipeline과 catboostregressor모델을 이용해서 분류 모델을 생성하였다.

## 6. 데이터 분석 Process

---

### Ch0. Import

- library import
- file import

### Ch1. Feature Preprocessing

- Missing Value
- Outlier

### Ch2. Feature Engineering

### Ch3. Feature Generation

- 나이
- 나이 대비 소득 수준
- 경력 공백기간
- ID
- 가구당 소득
- Income level q
- 가족수+자식수
- Income level age
- occyp type 파생변수
- 분류별 begin month 평균 & 연간 소득 평균

### Ch4. Encoding

- Ordinal Encoding
- Label Encoding

### Ch5. Scaling

- MinMax Scale
- Standard Scale
- Robust Scale
- Log Scale
- After Scale

![신용카드_1](https://github.com/Gayeon6423/Project/assets/113704015/fef60819-ab45-4b0b-85a8-ca8865eaff13)

### Ch6. Feature Selection

- corr-method
- feture-method

![신용카드_2](https://github.com/Gayeon6423/Project/assets/113704015/9afdc9a8-53c0-44cc-bbba-dde376102d09)

### Ch7. Modeling

- train, test, features split
- Pipeline
- Catboost Model

![신용카드_3](https://github.com/Gayeon6423/Project/assets/113704015/83a9b1ce-f5a3-40e4-9bb0-046bf0c50904)

## 7. 증빙자료

- Data

[Train Data](https://drive.google.com/file/d/1z4wMP3dM7R4Lg3HBPJV92BmMU6wf-GPj/view?usp=sharing)


[Test Data](https://drive.google.com/file/d/1s8TBo5rmBqtHJhRqeE2jDKezOE3_OIt8/view?usp=sharing)


[Submission Data](https://drive.google.com/file/d/1DLdUIafCQ-PVSRjdEz2oaN_7iWbiXeBG/view?usp=sharing)


- Code

[신용카드 대금 연체 정도 예측 분석 코드](https://drive.google.com/file/d/1O_PBikCWr40FRXfXSxq74AaYkZ71u6CN/view?usp=sharing)

