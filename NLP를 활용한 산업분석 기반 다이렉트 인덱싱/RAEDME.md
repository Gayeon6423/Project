## 1. 배경 & 목적

---

- 대회명: 신한AI, 보다 나은 금융 생활을 위한 AI 서비스 아이디어 경진대회
- 프로젝트명 : NLP를 활용한 산업분석 기반 다이렉트 인덱싱
- 목적 : 자연어처리를 활용해서 유망한 산업군에 투자할 수 있는 개인 맞춤형 포트폴리오 제작

## 2. 주최/주관 & 참가 대상 & 성과

---

- 주최: 신한AI
- 주관: 데이콘
- 참가대상 : 국내 거주자로 참가팀(5인 이내)구성
- 평가지표 : 리더보드 및 심사위언 평가
- 성과: 14등 / 67등(상위 20%)

## 3. 대회 기간

---

- 예선-리더보드 평가기간: 2023년 4월 10일~5월 15일
- 본선-오프라인 발표

## 4. 내용

---

자연어처리를 활용해서 산업 분석 기반의 다이렉트 인덱싱을 기획해보았다.

먼저 산업 섹터별로 월별 뉴스기사 본문 데이터를 수집하였다. 데이터 전처리를 진행한 후 뉴스 기사 본문을 바탕으로 감성분석을 진행하였고 이를 바탕으로 산업별 월별 전망지수를 생성하였다.

산업 전망지수를 이용해서 MVO기반 다이렉트 인덱싱을 구현하였고 나만의 포트폴리오를 만들 수 있도록 모바일 어플리케이션으로 UI/UX를 구현해보았다.

![nlp_1](https://github.com/Gayeon6423/Project/assets/113704015/ae260173-33e7-4ef2-b9ba-ab3a6d259a0e)

## 5. 담당 역할

---

- 뉴스 데이터 수집(API활용 크롤링)
- 뉴스 데이터 전처리(Cleaning, Tokenization, Normaliztion, Stopword Removal)
- 산업별 월별 감성지수 도출
- 그래핑 및 시각화 자료 제작
- 코드 정리

## 6. 데이터 분석 Process

---

### 1. 뉴스 데이터 수집

- 1-1. 검색어 입력 및 API 불러오기
- 1-2. 검색 결과에서 실제 뉴스 가져오기
- 1-3 뉴스 본문 가져오기
- 1-4 수집한 데이터 dataframe으로 제작

### 2. 데이터 전처리

- 2-1. Cleaning
- 2-2. Tokenization & Pos Tagging
- 2-3. Normalization
- 2-4. Stopword Removal

### 3. 산업 현황 분석 및 산업 감정 지표 도출

- 3.1 WordCloud 및 단어빈도 수를 통한 산업 현황 파악
- 3.2 산업별 월별 감성지수

### 4. 블랙리터만 모델을 활용한 다이렉트 인덱싱

## 7. 증빙자료

---

- PPT

https://docs.google.com/presentation/d/1Ce55AkkZyK6oMZT6ODzvYuLw_O6MOujW/edit?usp=sharing&ouid=109060680601725630686&rtpof=true&sd=true

- 코드

https://drive.google.com/file/d/1q-4RZH6FWn7CQVb1zzfZEaG9j5buuDmy/view?usp=sharing

- 데이터

https://drive.google.com/file/d/1qNt3FKXziz3ACQAHBOopFFpOH9hahFco/view?usp=sharing

- Github
