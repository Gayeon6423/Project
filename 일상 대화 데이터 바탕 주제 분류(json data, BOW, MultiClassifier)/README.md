# 1. 배경 & 목적

---

- AI Hub의 ‘주제별 텍스트 일상 대화 데이터’를 이용해서 텍스트별 대화 주제를 예측하는 프로젝트입니다.

# 2. 주최 & 참가 대상 & 성과

---

- 주최: Adam 개인 프로젝트
- 성과: 동아리 발표 진행

# 3. 프로젝트 기간(대회 기간)

---

- 프로젝트 발표: 2023년 4월 17일

# 4. 담당 역할

---

- 데이터 수집
- EDA
- 데이터 분석 및 모델링
- 보고서 작성
- 발표

# 5. 내용

---

- json파일 형태를 데이터프레임으로 전처리한 후 konlpy와 BOW를 이용해 텍스트 처리를 진행하였고RandomForestClassifier을 이용해서 주제를 예측하였습니다.

![일상 대화 데이터_1](https://github.com/Gayeon6423/Project/assets/113704015/c1dd5120-95e9-4820-857d-8d2a4e777fec)

# 6. 데이터 분석 Process

---

## Ch1. 데이터 수집

### 1-1. 파일 불러오기

### 1-2. 데이터 리스트 만들기

### 1-3. 텍스트, 주제 불러오기

### 1-4. 특정 주제 불러오기

## Ch2. BOW Vectorizer

### 2-1. 형태소 추출

### 2-2. Noun, Adjective, verb, adverb 추출

### 2-3. 중복값 제거

### 2-4. BOW 데이터프레임 만들기

### 2-5. Subject 칼럼 추가

## Ch3. Modeling

### 3-1. RandomForestClassifier

### 3-2. GridSearchCV

# 7. 증빙자료

---

- 보고서 및 발표자료
    
    [일상_대화_데이터_바탕_주제_분류_보고서.pdf](https://drive.google.com/file/d/1ObEuj9RWa1kIx37vUh_B3w-LfpCTfTeq/view?usp=sharing)
    
    [일상 대화 데이터 바탕 주제 분류](https://www.notion.so/96e5f2862f5146d497ceebbe04fdb0ac?pvs=21)
    
- 코드
    
    [코드](https://drive.google.com/file/d/1qTo1Yz3vtJW4effAOicoFjKDoj3KR8Az/view?usp=sharing)
    
- 외부 링크
