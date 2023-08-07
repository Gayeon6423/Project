## 1. 배경 & 목적

---

- Kaggle의 '[Credit score classification](https://www.kaggle.com/datasets/parisrohan/credit-score-classification?datasetId=2289007&sortBy=voteCount&select=train.csv)’ 데이터셋을 활용하여 데이터 전처리 과정과 신용점수 분류 모델을 생성하고 평가하였습니다.

## 2. 주최 & 참가 대상 & 성과

---

- 주최: FIND-A 개인 프로젝트
- 성과: -

## 3. 프로젝트 기간(대회 기간)

---

- 프로젝트 기간: 2023년 4월

## 4. 담당 역할

---

- EDA
- 데이터 분석 및 모델링
- 보고서 작성

## 5. 내용

---

- kaggle에서 Credit Score Classification 데이터를 다운로드 하였습니다.
- 이상값 처리, 결측치 처리, 범주형 변수 처리 등 데이터 전처리를 진행하였습니다.
- 데이터의 특성을 알아본 후 XGBoost Classifier을 이용해서 모델링을 진행하였습니다.
- 모델의 성능 평가 지표를 도출 후 해석하였습니다.

![credit score classificateion_1](https://github.com/Gayeon6423/Project/assets/113704015/54c93965-fccc-4c86-91a9-f51c78ce5cec)

## 6. 데이터 분석 Process

---

## Ch1. 프로젝트 개요

### 1-1. 프로젝트 개요

### 1-2. 가설 설정

### 1-3. 사용한 데이터 및 출처

## Ch2. 데이터 수집 및 전처리

### 2-1. 데이터 출처 및 수집 방법

### 2-2. 데이터 수집, 불러오기

### 2-3. 데이터 파악, 전처리

### 2-4. 통계적 요약과 변수 간 관계

### 2-5. 파생변수 생성과 데이터 정제

## Ch3. 머신러닝 모델링

### 3-1. 모델 선정

### 3-2. 훈련 및 검증 데이터 분할

### 3-3. 모델 학습

### 3-4. 모델 학습 결과 및 평가 지표

- XGBOOST 평가 지표
- 모델별 성능
- plot_tree함수로 결정기준 확인
- feature importance

## Ch4. 결과 해석 및 중요한 특성 분석

### 4-1. 분석 결과의 의미 및 가설 검증

### 4-2. 결과에 대한 해석 및 활용 방안

## 7. 증빙자료

- 보고서 및 발표자료

[Credit score classification.pdf](https://drive.google.com/file/d/1lIYK9ZT2o9DuaqmuUApTA_6Ejg9riWCa/view?usp=sharing)

[****Credit score classification****](https://www.notion.so/Credit-score-classification-9d276ba6697543298cb8d8cbb0aead2d?pvs=21)

- 코드

[신용등급분류_전처리_코드](https://colab.research.google.com/drive/1rKLYdXhQpCoR0ZdSygRcaAChhMk1OmHx?usp=sharing)

[신용등급분류_모델링_코드](https://colab.research.google.com/drive/1QvJCPjHQmT-M3U0Kk988vzdwxjmVaZ3G?usp=sharing)
