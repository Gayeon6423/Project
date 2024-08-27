---

# 1. 배경 & 목적

---

- 주제명 : Predicting Daily Emotional Distribution and Mental Health Index via LLM and Further Transfer Learning
- 배경 : 데이터마이닝 수업 프로젝트
- 목적 : 국민들의 정신 건강 상태를 예측하기 위해서 Large Language Model과 SNS데이터를 사용하여  감정 분포와 정신 건강 지수를 도출, 감정 레이블 데이터를 기반으로 4가지 감정을 예측하는 다중 분류 모델을 구축.

# 2. 주최 & 참가 대상 & 성과

---

- 주최 : 데이터마이닝 수업
- 성과 : A+

# 3. 프로젝트 기간

---

- 제출 마감 : 2023년 6월 19일

# 4. 담당 역할

---

- EDA, 데이터 전처리, 모델링, 보고서 작성

# 5. 분석 과정

---

### 0. Abstract

- 본 연구는 국민들의 정신건강 상태를 모니터링 하기 위해서 LLM(Large Language Model)과 유튜브 데이터 기반의 일자 별 감정 분포와 정신건강 지수를 예측하는 것을 목적으로 한다.
- AI HUB의 감정 레이블 데이터를 기반으로 4가지 감정을 예측하는 다중 분류 모델을 구축한다.
- 다중 분류 모델은 구축 방법은 2단계로 구성된다.
    - 첫 번째 단계는 Basic Transfer Learning으로 Pre-Trained된 BERT 기반의 모델을 불러온 후, 대화 감정 레이블 데이터를 활용해서 다중 감정 분류를 위한 Fine-Tuning을 진행한다. Pre-Trained 모델로 BERT-base, RoBERTa-base, RoBERTa-large, KoELECTRA를 사용하며 가장 좋은 성능을 보인 모델을 최종 선택한다.
    - 두 번째 단계는 Further Transfer Learning으로 Fine-Tuning된 기존 다중 감정 분류 모델에 추론을 위해 사용할 라벨 데이터셋을 활용해서 한 번 더 Fine-Tuning을 진행한다. 기존 다중 감정 분류 모델로는 Basic Transfer Learning에서 가장 좋은 성능을 보인 모델을 활용했으며, 추론에 사용할 라벨 데이터셋은 생성형 언어 모델인 Gemma를 사용해서 구축한다.
- 모델의 추론 결과를 활용해서 감정 별 분포와 정신 건강 지수 계산 후 도출한다. 도출된 지수를 일자 별, 월 별로 시계열 자료로 표현함으로써 국민들의 정신건강 지수를 모니터링하는데 활용한다.

## 1. Introduction

- Motivate
    - EIU의 정신건강 및 통합 보고서에 의하면 한국의 정신보건 통합지수 75.9점 ->OECD국가 평균보다 낮은 현황
    - 우울증 유병률 세계 1위,자살률 OECD평균치 상회
    - 한국의 정신건강 지수 측면에서 개선 필요
    - AI를 활용하여 정신건강 지수를 예측함으로써 효율적인 대응책 마련 가능
- Object
    - 국민들의 정신건강 상태를 예측하기 위해서 LLM과 SNS데이터를 사용하여  감정 분포와 정신건강 지수를 예측
    - 감정 레이블 데이터를 기반으로 4가지 감정을 예측하는 다중 분류 모델 구축
    - BasicTransferLearning, Hyperparameter Optimization, Generating Youtube Sentiment Label, Further Transfer Learning
    - 감정 별 분포 및 정신건강 지수  도출

## 2. Proposed Method

- Overall Architecture

![DM_1](https://github.com/user-attachments/assets/9ed4f549-784a-4750-bfa6-384c9be6432c)

### 2.1 Construct Sentiment Classification Model

- Basic Transfer Learning
    - Pre-Training된 언어 모델을 불러와 학습한 뒤 목표 테스크에 맞게Fine-Tuning을 수행
    - Pre-training모델로 KLUE-BERT, KLUE-RoBERTa-base, KLUE-RoBERTa-large, KoELECTRA모델 사용
        
      ![DM_2](https://github.com/user-attachments/assets/2e3d6f9e-3a2e-4c62-ab5c-0cd88ad6ca31)

        
    - KLUE-BERT : 한국어 자연어 처리 작업에 최적화된 BERT기반 모델
    - KoELECTRA : 한국어 기반의 ELECTRA모델로 텍스트 생성하는 Generator&생성된 텍스트가 원래 텍스트인지 아닌지 판별하는 Discriminator로 구성
    - KLUE-RoBERTa:BERT보다 더 큰 배치 사이즈와 더 긴 텍스트 시퀀스 사용하여 성능 극대화한 모델

- Hyper Parameter Tuning
    - 감정 분류 모델의 성능 고도화를 위해 하이퍼 파라미터 최적화 수행
    - 여러가지 조합을 시도해 보며 모델의 최적 조합 탐색
    - Oputna의 TPES최적화 방법 사용 :확률적으로 좋은 후보 값을 선택하기 위해 이전에 시도한 후 보 값들의 분포를 고려
    - ->매 시도마다 새로운 후보 값들의 분포 추정,더 좋은 후보 값 탐색

- Generate Sample Youtube Sentiment Label Dataset
    - GenerativeAI모델인 Gemma를  로드
    - 유튜브 댓글이 들어오면 4가지 감정(행복,분노,슬픔,중립)중 하나의 감정을 예측하도록 PromptTuning수행
    - 9,000개의 유튜브 댓글에 대한 감정 매핑된 데이터셋 구축

- Further Transfer Learning
    - 감정 분류 테스크에 Fine-Tuning된 기존 분류 모델에 (유튜브 댓글 라벨링 데이터셋 +기존 감정 라벨링 데이터셋)을 사용해서 한번 더 Fine-Tuning진행
    - 유튜브 댓글의 특징을 반영한 고도화된 감정 분류 모델 구축
    - 기존 감정 분류 모델보다 성능 개선됨

### 2.2 Inference Yotube Data

- Further Transfer Learning을 통해 구축된 유튜브 댓글 특화 감정 분류 모델을 활용해서 전체 유튜브 댓글 감정 추론
- 원본 유튜브 데이터 전처리 ->batchsize로 분할 ->각 batch에 대해 추론 수행
- 각 batch에 대한 처리 과정 :텍스트 토큰화 ->모델 평가 모드로 전환 ->입력 데이터 기반 추론 수행
- ->출력 logits에 softmax함수 적용하여 각 함수에 대한 확률 계산 ->각 텍스트에 대해 가장 높은 확률을 가진 감정 예측

![DM_3](https://github.com/user-attachments/assets/1948e3f8-f87a-42fb-8b48-db450efa7549)

### 2.3 Prediction Sentiment Distribution & Mental Health Index

![DM_4](https://github.com/user-attachments/assets/f9a39c21-b8f9-4e52-ba29-0c1aa462e0ab)

## 3. Experiment

### 3.1 Dataset

- Dataset : Sentiment Label

| **데이터셋** | **감정** **레이블** | **문장** **수** |
| --- | --- | --- |
| 감성대화말뭉치 | 분노, 슬픔, 행복 | 27,884 |
| 감정 분류를 위한 대화 음성 데이터셋 | 중립 | 7,421 |

| **분노** **문장** **수** | **슬픔** **문장** **수** | **중립** **문장** **수** | **행복** **문장** **수** | **합계** |
| --- | --- | --- | --- | --- |
| **10,417** | **10,128** | **7,421** | **7,339** | **35,305** |
- Dataset : Youtube Comment

![DM_5](https://github.com/user-attachments/assets/6c6ce3c4-de9c-443f-a2bd-6c4e7e53165e)

- Dataset : Youtube Comment-Sentiment mapping

![DM_6](https://github.com/user-attachments/assets/f38faea0-c78b-447c-82e3-b97e49d82499)

### 3.2 Evalution Metric

- Accuracy : 전체 예측 중에서 실제 레이블과 일치한 예측의 비율을 의미하며, 모델이 얼마나 자주 올바르게 예측하는지 나타내는 척도로 사용
- F1 Score : 모델이 True라고 예측한 것 중에서 실제 True인 비율을 나타내는 Precision과 실제 True중에서 모델이 True라고 정확하게 예측한 비율을 나타내는 Recall의 조화 평균
- Per-Class Accuracy : Confusion Matrix를 통해 각 클래스의 정확도를 계산한다 예측 결과와 실제 레이블 간의 매핑을 행렬 형태로 나타냄으로써,각 클래스의 대각선 값을 추출하며 이는 해당 클래스의 정확도 나타냄

### 3.3 Sentiment Classfication

![DM_7](https://github.com/user-attachments/assets/4b70ac3b-c97d-4f67-b814-ab382502ce01)

### 3.4 Inference

- 유튜브 데이터 감정 추론 속도

| **Model** | **Batch Size** | **Inference Count** | **Inference Time** | **Inference Time (1batch)** |
| --- | --- | --- | --- | --- |
| RoBERTa-base | 10 | 100 | 0.04초 | 0.004초 |
| RoBERTa-base | 100 | 100 | 0.5초 | 0.005초 |
| RoBERTa-large | 10 | 100 | 0.12초 | 0.012초 |
| RoBERTa-large | 100 | 100 | 1.6 초 | 0.016초 |
- 유튜브 댓글 감정 추론 결과

| **추론 댓글** | **추론 댓글 수** | **추론 댓글 비율** |
| --- | --- | --- |
| 분노 댓글 | 1,375,562 | 44% |
| 슬픔 댓글 | 1,128,354 | 36% |
| 행복 댓글 | 461,553 | 15% |
| 중립 댓글 | 141,665 | 5% |

### 3.5 **Daily Sentiment Distribution & Mental Health Index**

![DM_8](https://github.com/user-attachments/assets/85d42709-0309-4e64-bba3-daa9082b679a)

## 4. Conclusion

- 데이터 다양화 및 확대
    - 감정 레이블의 다양성 높여 모델 성능 일반화
    - 트위터,페이스북 등 다른 SNS기 반 감정 레이블 데이터 추가 수집
- 실시간 모니터링 시스템 구축
    - 실시간으로 데이터 수집하고 분석할 수 있는 시스템 개발
    - 국민들의 정신 건강 상태를 실시간으로 모니터링하고 즉각적인 대응 가능하도록 설계
- 정신 건강 지수 고도화
    - 감정 분포 기반 정신 건강 지수 외에도 경제 상황, 사회적 이슈, 의료 관련 변수를 포함하여 정신 건강 지수의 예측 정확도 개선

# 6. 느낀점

---

- 유튜브 뉴스 데이터를 분석해서 국민들의 일자 별 감정 분포를 도출해보았습니다. 이를 통해서 국민들의 감정 변화를 파악하였고 해당 추론 결과를 활용해서 정신 건강 지수를 만들었습니다. 다양한 변수를 추가해서 정신 건강 지수를 더욱 고도화 시켜서 실시간으로 국민들의 정신 건강 점수를 파악할 수 있는 유용한 지표로 활용될 것이라고 생각합니다.
- Chat GPT, Gemmi와 같은 생성형 언어 모델 성능이 크게 증가하고 많은 문제를 풀고 있습니다. 하지만 특정 도메인 문제를 풀 때는 해당 도메인 레이블 데이터로 Fine-Tuning한 모델이 더욱 특화되어 있고 신뢰의 근거가 있다고 생각했습니다.
- 따라서 이와 같은 도메인 특화 문제를 풀 때는 Fine-Tuning 모델을 기본 모델로 정한 후, 생성형 모델은 보조 모델로 함께 사용해 주는 게 좋다고 판단하였고 분석을 진행하였습니다.
- 실제 사회적인 문제를 인공지능 모델을 활용해서 해결해 볼 수 있는 재밌는 프로젝트였습니다.

# 7. 증빙 자료

- 보고서 및 발표 자료
    
    [DM24_발표자료_120240328정가연.pdf](https://prod-files-secure.s3.us-west-2.amazonaws.com/8ad533bb-3998-4a33-a175-66381eda6e91/74adee14-f21b-4ba0-a433-71c73d4995d6/DM24_%EB%B0%9C%ED%91%9C%EC%9E%90%EB%A3%8C_120240328%EC%A0%95%EA%B0%80%EC%97%B0.pdf)
