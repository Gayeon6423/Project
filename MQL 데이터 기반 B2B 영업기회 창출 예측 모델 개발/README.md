## LG Aimers 4th : LG AI Hackathon

---

## 1. 배경 & 목적

---

- 프로젝트명 : MQL 데이터 기반 B2B 영업기회 창출 예측 모델 개발
- 목적 : LG Aimers 4기 해커톤
- 배경 : B2B 마케팅의 목표는 고객(기업)을 상대로 영업기회를 발굴하는 것이고, 이를 통해 지속적인 재매출을 이루어 내는 것이다. MQL 고객들 중 영업 전환 가능성이 높은 고객을 대상으로 영업 사원을 할당하여 마케팅 진행한다.

## 2. 주최/주관 & 참가 대상 & 성과

---

- 주최: LG 인화원
- 참가대상 : LG Aimers Phase1 수료자
- 평가지표 : 리더보드 순위
- 성과: 참가

## 3. 대회 기간

---

- 대회 기간 : 2024년 2월 1일 ~ 2024년 2월 26일


## 4. 담당 역할

---

- 팀장, EDA, 데이터 전처리, 머신러닝 기반 모델 학습 및 추론, 버전 관리

## 5. 분석

---

### 1. 데이터 파악(EDA)

- Feature : MQL 관련 변수 30개 + 고객이 직접 작성한 요청 메시지
- Target : 영업전환이력(성공True, 실패False)

### 2. 전처리

- 결측치 처리
- 이상치 처리
- 인코딩(범주형 변수→수치형 변수)
    - onehot encoding, label encoding, fequency encoding, target encoding, embedding, ordinal encoding
- 표준화 및 스케일링
    - standardization, min-max scaling, robust scaling, clipping

| **Field** | **설명** | 특징 | 전처리 |
| --- | --- | --- | --- |
| bant_submit | MQL 구성 요소들 중 [1]Budget(예산), [2]Title(고객의 직책/직급), [3]Needs(요구사항), [4]Timeline(희망 납기일) 4가지 항목에 대해서 작성된 값의 비율 |  |  |
| customer_country(범주) | 고객의 국적 | 국가가 범주로 나눠져 있어서 분할 필요 | 결측값:other로 대체
인코딩:라벨 |
| business_unit(범주) | MQL 요청 상품에 대응되는 사업부 |  | 인코딩:라벨 |
| com_reg_ver_win_rate | Vertical Level 1, business unit, region을 기준으로 oppty 비율을 계산 | 수직 레벨1(비즈니스 계층 구조에서 가장 상위 수준의 사업 영역), 비즈니스 단위(특정 비즈니스 영역), 지역(지리적 위치)에 따른 예상 매출 기회 비율 | 결측값을 계산해서 대체하면 좋을 듯 |
| customer_idx | 고객의 회사명 | ‘2421’ 회사가 영업 전환을 성공한 기업의 절반을 차지함 |  |
| customer_type(범주) | 고객 유형 |  | 결측값:other로 대체
인코딩:라벨 |
| enterprise(범주) | Global 기업인지, Small/Medium 규모의 기업인지 |  | 인코딩:원핫 |
| historical_existing_cnt | 이전에 Converted(영업 전환) 되었던 횟수 | 높을수록 좋음 | 결측값:중위값으로 대체 |
| id_strategic_ver | (도메인 지식) 특정 사업부(Business Unit), 특정 사업 영역(Vertical Level1)에 대해 가중치를 부여 | -특정 사업부면 영업전환 기회에 영향을 준다고 가정
-파생변수 만들때 다른 변수와 곱해줌으로써 가중치 부여 가능 | 결측값: 0으로 대체 |
| it_strategic_ver | (도메인 지식) 특정 사업부(Business Unit), 특정 사업 영역(Vertical Level1)에 대해 가중치를 부여 | -특정 사업부면 영업전환 기회에 영향을 준다고 가정
-파생변수 만들때 다른 변수와 곱해줌으로써 가중치 부여 가능 | 결측값: 0으로 대체 |
| idit_strategic_ver | Id_strategic_ver이나 it_strategic_ver 값 중 하나라도 1의 값을 가지면 1 값으로 표현 |  | 결측값: 0으로 대체해서 가중치 부여X |
| customer_job(범주) | 고객의 직업군 |  | 결측값:other로 대체
인코딩:라벨 |
| lead_desc_length | 고객이 작성한 Lead Descriptoin 텍스트 총 길이 | 길수록 기업에 관심이 있다는 뜻 |  |
| inquiry_type(범주) | 고객의 문의 유형 | 문의 유형 긍정, 부정으로 나눌 수 있을 듯 | 결측값:other로 대체
이상치처리:대소문자 통합
인코딩:감정스코어 |
| product_category(범주) | 요청 제품 카테고리 |  | 결측값:etc.로 대체
인코딩:라벨 |
| product_subcategory(범주) | 요청 제품 하위 카테고리 |  | 결측값:etc.로 대체
인코딩:라벨 |
| product_modelname(범주) | 요청 제품 모델명 |  | 결측값:etc.로 대체
인코딩:라벨 |
| customer_country.1 | 담당 자사 법인명 기반의 지역 정보(대륙) |  |  |
| customer_position(범주) | 고객의 회사 직책 |  | 인코딩:라벨 |
| response_corporate(범주) | 담당 자사 법인명 |  | 인코딩:라벨 |
| expected_timeline(범주) | 고객의 요청한 처리 일정 |  | 결측값:최빈값으로 대체
인코딩: 기간인 경우 범주로 묶은 후 기간의 평균값으로 변환→수치형으로 변환 |
| ver_cus | 특정 Vertical Level 1(사업영역) 이면서 Customer_type(고객 유형)이 소비자(End-user)인 경우에 대한 가중치 | -파생변수 만들때 다른 변수와 곱해줌으로써 가중치 부여 가능 | 결측값은 0으로 대체 |
| ver_pro | 특정 Vertical Level 1(사업영역) 이면서 특정 Product Category(제품 유형)인 경우에 대한 가중치 | -파생변수 만들때 다른 변수와 곱해줌으로써 가중치 부여 가능 | 결측값은 0으로 대체 |
| ver_win_rate_x | 전체 Lead 중에서 Vertical을 기준으로 Vertical 수 비율과 Vertical 별 Lead 수 대비 영업 전환 성공 비율 값을 곱한 값 |  | 결측값:중위값으로 대체 |
| ver_win_ratio_per_bu | 특정 Vertical Level1의 Business Unit 별 샘플 수 대비 영업 전환된 샘플 수의 비율을 계산 |  | 결측값:중위값으로 대체 |
| business_area(범주) | 고객의 사업 영역 |  | 결측값:others로 대체
인코딩:라벨 |
| business_subarea(범주) | 고객의 세부 사업 영역 |  | 결측값:Others로 대체
인코딩:라벨 |
| lead_owner | 영업 담당자 이름 |  |  |
| is_converted | 영업 성공 여부. True일 시 성공. |  | True면 1, False면 0 |

### 3. 변수 생성

- 다른 정형 데이터와 결합
- 집약하여 통계량 도출
    - 단순 통계량
    - 시간 정보 통계량
    - 집계 단위 변경
    - 아이템이나 이벤트 주목

### 4. ML/DL  모델 학습

- Logistic Regression
- Decision Tree
- RandomForest
- Extreme RandomForest
- XGBoost
- LGBM
- AutoML
- MLP
- DNN

### 5. 교차 검증, 앙상블

- K-fold validation
- Hold Out Validation
- Basic Ensemble(Mean, Weighted Mean, Voting, Boosting)
- Stacking

### 6. 모델 튜닝

- Bayesian Optimization
- Optuna

### 7. 모델 평가
---


## 6. 느낀점

---

- 팀장으로써 팀원들의 의견을 조합하고 필요한 파트를 분배해주며 원할하게 프로젝트가 진행될 수 있도록 고민해보는 시간을 가질 수 있었습니다. 특히 프로젝트 관리에 있어서 버전 관리의 중요성을 알게 되었고 엑셀로 표로 만들어서  실험 내용, 성능을 기록하며 관리하였습니다.
- 소스 코드의 경우 각자 실험을 진행한 뒤 구글 드라이브에 코드를 업로드하는 식으로 협업을 진행하였습니다. 최종 마감 전까지 리더보드 상위 10위에 들만큼 좋은 성능을 보였지만, 최종 submission file을 생성할 때 가장 좋았던 성능의 코드가 재구현되지 않는 문제가 발생했습니다. 각 팀원들의 코드들이 각각 다른 환경에서 구현되며 하나로 통합되지 않아서 발생한 문제였고, 하나의 통합된 main 코드가 필요했었음을 깨달았습니다.
- 추후에는 구글 드라이브가 아닌, 깃허브를 통해서 main 코드를 기반으로 각각 brunch를 만들어서 버전 관리를 진행하면 협업을 해야겠다고 느꼈습니다. 최종 리더보드 성능이 떨어져서 아쉬웠지만, 버전 관리의 중요성과 협업의 필요 요소들을 배울 수 있었던 프로젝트였습니다.
