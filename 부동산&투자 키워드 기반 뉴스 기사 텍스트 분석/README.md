# 1. 배경 및 목적

---

부동산&투자 관련 주제 10개를 선정한 후 각 주제별 뉴스 기사 데이터를 수집하여 분석을 진행하였다. 네이버 API를 활용하였고 텍스트 데이터 전처리를 진행하였습니다. WordCloud, Text Classification, Similar document retrieval, Topic Modeling을 진행하였다.

# 2. 주최/주관 & 참가 대상 & 성과

---

- 주관/주최 : 국민대학교 텍스트데이터분석 수업 과제
- 성과 : A+

# 3. 프로젝트 기간

---

- Assignment 기간 : 2023년 6월~7월

# 4. 내용

---

NAVER 뉴스 API source를 활용하여 스크래핑한 뉴스 데이터를 바탕으로, 다양한 텍스트 분석 기법을 적용하여 뉴스 데이터를 분석해 볼 수 있다. 

먼저, WordCloud를 활용하여 각 주제별로 어떤 키워드가 가장 중요한지를 쉽게 파악할 수 있다. WordCloud는 단어의 빈도수를 기반으로 한 시각화 방법으로, 크기가 큰 단어일수록 중요한 단어임을 시각적으로 나타낸다.

또한, Text Classification을 활용하여 주어진 뉴스 기사를 자동으로 분류할 수 있다. 뉴스 데이터를 라벨링한 후, 분류 모델을 학습시켜 새로운 뉴스 기사의 라벨 값을 예측할 수 있다. 예를 들어, 정치, 경제, 사회, 문화 등의 카테고리로 뉴스 기사를 분류하는 모델을 만들어 볼 수 있다.

또한, 토픽 모델링을 활용하여 뉴스 기사의 주요 토픽을 파악할 수 있다. 토픽 모델링은 문서에서 토픽을 추출하는 기술로, 뉴스 기사에서 다루는 주요 주제를 파악할 수 있다.

이러한 텍스트 분석 기술들을 활용하여 뉴스 데이터를 분석함으로써, 뉴스 기사에서 다양한 정보를 추출하고 인사이트를 도출할 수 있다. 뉴스 데이터를 분석함으로써, 뉴스 시장의 흐름을 파악하고, 소비자의 관심사를 파악하는 등의 다양한 분야에서 유용하게 활용할 수 있을 것이다.

# 5.  담당역할

---

- 크롤링을 통한 데이터 수집
- 데이터 전처리
- 데이터 분석
- PPT제작

# 6. 데이터 분석 PROCESS

---

## Ch1. 텍스트 수집

[**데이터 수집 개요]**

- 필요한 데이터  : 10,000개
- 키워드 10개 * 100페이지
- 네이버 API를 활용해서 각 키워드당 하루에 300~500개씩 데이터 수집(데이터 항목  :기사 제목, 기사 링크, 기사 본문)
- 날짜별 검색어별로 데이터 수집 후 데이터프레임으로 제작 및 csv파일로 저장
- 제작했던 csv파일 모두 합한 후 하나의 csv파일로 저장
- 각 일자의 최신순으로 정렬된  데이터를 수집하였다. 일자별 데이터의 중복을 방지하기 위해서 2일에 한번씩 데이터를 수집했다. 확인해본 결과 데이터의 중복은 발생하지 않았다.

### 1-1. 검색어 입력 및 API 불러오기

### 1-2. 검색 결과에서 실제 뉴스 가져오기

### 1-3. 뉴스 본문 가져오기

### 1-4. 수집한 데이터 dataframe으로 제작

### 1-5. 키워드/날짜/데이터수 데이터 수집

### 1-6. 최종 데이터

전체 수집 데이터 수 : 18,014개 / 중복 제거한 데이터 수 : 10,191개

![부동산 투자_1](https://github.com/Gayeon6423/Project/assets/113704015/0a0f631a-77d3-4111-9c6d-d5672411aebb)

## Ch2. 텍스트 전처리

---

### 2-1. Cleaning

- 정규표현식을 이용해서 필요없는 특수문자 제거

### 2-2. ****Tokenization & Pos Tagging****

- Tokenization : 가장 빈번하게 등장하는 형태소 20개를 출력한다
- Pos  Tagging : 단어별로 품사를 태깅해준다.

### 2-3. Normalization

- 품사가 조사, 한국 특수어, 접미사, 접속사이면 제외한다.

### 2-4. Stopword Removel

- Stopword list에 있는 불용어를 제거해준다

### 2-5. 전처리 완료 후 데이터프레임 생성

![부동산 투자_2](https://github.com/Gayeon6423/Project/assets/113704015/89a99c9c-20d9-4bbd-b11a-e83a9916f554)

## Ch3. 텍스트 분석

---

### 3-**1. WordCloud & 빈도 Chart**

- **Search Word : 부동산, 주식, 아파트, 대출, 투자, 전세, 코스피, 채권, 월세, 금리**

![부동산 투자_3](https://github.com/Gayeon6423/Project/assets/113704015/cbaf2407-7bea-407a-a9c6-0d95d4b9e1f2)

### ****3-2. Text Classification****

- TF_IDF 생성한다.
- train data, test data분리한다.
- Logistic Regression 모델 학습한다.

`accuracy_score :  0.6546934865900383`

### 3-****3. Similar document retrieval****

- 뉴스 본문의 tf-idf를 기준으로 cosine similarity가 가장 높은 10개의 문서 도출한다.
- 기사 제목과 index간 매핑 작업한다.
- 뉴스 본문이 가장 유사한 뉴스 기사 10개를 추출한다.
- 코사인 유사도를 기준으로 가장 비슷한 뉴스 10개 출력한다.

### 3-4. Topic Modeling(LDA)

- 각 행에 있는 기사 본문을 토큰화한다.
- LDA모델을 사용해서 문서 집합을 토픽으로 분류한다.
- LDA모델을 훈련한 후 토픽 분포를 확인한다.
- 각 문서에 대한 topic비중의 수를 확인한다.

![부동산 투자_4](https://github.com/Gayeon6423/Project/assets/113704015/817ce70b-c4f9-45fa-9adb-ad9bee36645c)

# 7. 참고자료, 첨부파일

---

[[텍스트데이터분석][Assignment1][경제학과20200856정가연]](https://drive.google.com/file/d/1d6DGUD343hRMn9KSvERE4pHnFprI3yTW/view?usp=sharing)


[[Assignment1][경제학과20200856정가연][코드]](https://drive.google.com/file/d/1gZ718_uhlljE9-B3bLnP3Qbek7NoSgoz/view?usp=sharing)
