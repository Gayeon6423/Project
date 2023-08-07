## 1. 배경 및 목적

---

- 대학성적, 근무경력, 직종, 세부직종, 해외근무경력 등의 feature을 이용해서 Salary를 예측하는 모델을 제작했습니다.
- 파이프라인, OOF, CatBoostRegressor, 앙상블 기법을 이용해서 Salary예측을 진행하였고 최종적으로 RMSE는 794가 도출되었습니다.

## 2. 주관/주최 & 성과

---

- 주관/주최 : 국민대학교 머신러닝 수업 Kaggle Competition
- 성과 : Competition Score 1등

## 3. 프로젝트 기간

- Competiton 기간 : 2022년 7월~9월

## 4.  담당역할

- 데이터 EDA 및 시각화
- 데이터 전처리
- Regression 모델링
- Ensemble
- PPT제작

## 5.  데이터 및 소스코드

[Data](https://www.notion.so/705f05f4a5ab413a8f9509606061803a?pvs=21)

[Source Code ](https://www.notion.so/d1160739dd284fcdaf0e6487edc23e1f?pvs=21)

[Kaggle 제출파일 ](https://www.notion.so/8db1ac3408e54faaa4869af9eb6e15bd?pvs=21)

[기타 자료 ](https://www.notion.so/1e97f181336f4603b3c8571492d543a1?pvs=21)

## 6. 데이터 분석 Process

---

### **Ch1. Feature Preprocessing & Engineering**

- 대학성적, 근무경력, 근무지역, 대학전공, 직무태그, 어학시험

### **Ch2. Feature Generation**

- 숙련도, 대학별 그룹, 세부직종별 순위부여, 파생변수, 출신대학수치, 근무지역수치, 대학별 구간 분류, 대학별 경력 분류, 근무지역 분류, 근무지역 count

### **Ch3.** **Modeling**

[Features]

- Numerical Features, Categorical Features, Binary Features 분류

[Preprocessing]

- Numerical Features Preprocessing : SimpleImputer, FunctionTransformer
- Categorical Features Preprocessing : SimpleImputer, Oridnal Encoder
- Binary Features Preprocessing : Imputer, Corpus, CounterVectorizer, dencse

[Cross_validate]

- 최적화된 하이퍼파라미터로 OOF를 수행하여 최종 CatRegressor이용, cv=15

### **Ch4. Ensemble**

- 최고 성능 단일모델 : catboost_18_4 / Public Score : 795.1245
- Ensemble : 리더보드 점수가 좋으면서 모델에 사용한 피처의 차이가 있느느 서브미션 파일을 산술평균 앙상블 진행 / Public Score : 794.43719

## 7. 시사점

1-1) [직무태그] 각 value의 앞뒤, 문자사이 공백과 앞뒤에 있는 콤마 제거 후 각 value를 split(',')하여 첫 번째 단어만 추출하여 해당 단어로 value값을
변경하였습니다.

+변환 이후 value_counts 개수 1인 값들은 '기타'로 묶었습니다.(이상값(??, 1 등등), 홍보성문구 등)

1-2) [직무태그] 각 value의 앞뒤, 문자사이 공백과 앞뒤에 있는 콤마 제거 후 각 value를 split(',')하고 모든 열의 split된 단어들을 중복없이 리스트에 담
고 해당 리스트의 단어들로 새로운 feature를 만들었습니다. 그리고 원핫인코딩과 같이 첫번째 행 value에 포함되어 있는 단어와 동일한 feature의
value에 1을 부여하였습니다.
이후 최적 n_components 개수 찾는 코드를 이용하여 pca 진행하였으나 n_components 가 약 5,000으로 출력되어 교수님의 조언대로 50부터 500까
지 50 간격으로 늘려가면 테스트 해보았습니다.
위와 같이 실험해보았으나 TruncatedSVD가 제일 좋았습니다.

2) 1-1의 결과를 엑셀 파일로 저장해 수작업으로 이상값들과 오타를 수정하고 동일한 의미를 가지는 value들을 같은 단어로 통일해주었습니다.

3) feature selection을 3가지 방법 정도 시도해보았으나 유의미한 결과는 얻지 못했습니다.

4) Stacking을 구현하기 위해 수많은 구글링과 시도를 해보았지만 대다수가 실패 하였었고 XGB나 GBM, LGBM, LM의 단일 모델 성능이 Catboost보
다 높지 않아 기대가 많았지만 결과는 좋지 않았습니다.

5) Salary와 각 feature(원본 and 파생)와의 선형성을 보기 위해 시각화 해보았지만 유의미한 인사이트를 발굴하지 못했습니다.

6) 앙상블을 할 때 특정 기준을 찾고자 앙상블 할 submission 파일들을 가지고 [y축 - rmse / x축 - 상관계수] 다음과 같이 시각화 하여 ridge(능선) 기법
을 적용하여 이를 기준으로 삼고자 하였습니다.

![catboost_1](https://github.com/Gayeon6423/Project/assets/113704015/ac279db8-1d89-4cf9-85c1-46dbf332a62a)

7) 이외에도 Kaggle 제출한 파일 중 가장 성능이 좋은 파일과 제출하고자 하는 파일을 distplot을 통해 비교하여 두 파일간의 규칙성을 찾아보고자 하였습니다.

![catboost_2](https://github.com/Gayeon6423/Project/assets/113704015/c0ceb6d6-374a-437b-8a89-21c3b36f9024)

컴페티션 기간동안 약 250여 회의 테스트(단일 모델과 제출 파일 생성)를 하며 최선을 다하였습니다.
Kaggle 하루 제출 횟수가 20회뿐이어서 테스트 해본 모델들의 성능을 모두 확인해 볼 수 없었던 점이 가장 아쉬웠습니다. 제출 횟수 제한으로 인해 숨은 원석(성능이 좋은)을 놓쳤을 것이라고 생각합니다.

컴페티션 종료 이후 처음부터 제대로 EDA를 하지 않았던 저의 실책, 당장의 성능 올리기에 급급한 나머지 무분별한 feature 생성(기준, 근거 모호) 등 아쉬웠던 점이 많았습니다. 그러나 추후에 대회나 프로젝트를 진행함에 있어서 꼭 필요했던 중요한 경험이었던 것 같습니다.

### 8. 증빙자료

- 보고서 및 발표쟈료

[ml_competition_ppt](https://docs.google.com/presentation/d/1IW-exjGdM2WOHQyc_r-PM7e0YF-SwB6g/edit?usp=sharing&ouid=109060680601725630686&rtpof=true&sd=true)

- 코드

[KML Challenge 2022F_preprocessing](https://drive.google.com/file/d/1SVm5Bj4ImYFsMh83OKGBa0YLHHVTxYgv/view?usp=sharing)

[KML Challenge 2022F_v21.4(v20.4를 base로한 run papermill result)](https://drive.google.com/file/d/1VIlnPVwh6Hdj1XfOkhxa8yYatg3fq88w/view?usp=sharing)
