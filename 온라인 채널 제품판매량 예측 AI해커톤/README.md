# 1. 배경 & 목적

---

- 주제 : 온라인 채널 제품 판매량 예측
- 목적 : LG Aimers 3기 해커톤
- 배경
    - 디지털 시대에 들어, 온라인 판매는 상품과 서비스를 전달하는 핵심 채널로 자리매김 하였습니다. 이러한 변화와 함께, 판매 채널에서 수집되는 대규모 데이터는 온라인 판매 환경에서 귀중한 통찰력을 얻는데 있어 중요한 자산이 되었습니다.
    - 이런 데이터를 활용해 빠르고 정확한 판매 예측을 수행하는 것은, 기업들이 효율적인 재고 관리를 하고, 타겟 마케팅 전략을 세우는데 필수적입니다.
    - 이번 해커톤은 이런 데이터를 파악하고 실제 판매량을 예측하는 AI 모델 개발에 초점을 맞추고 있습니다.

# 2. 주최/주관 & 참가 대상 & 성과

---

- 주최 : LG AI Research
- 주관 : 데이콘
- 참여 : 한경탓컴
- 참가대상 : LG Aimers 교육생
- 평가지표 : 리더보드 순위
- 성과: 상위20%(154/747)

# 3. 대회 기간

---

- 대회 기간 : 2023년8월1일~2023년8월28일

# 4. 담당 역할

---

- 데이터 전처리
- 데이터 분석
- 예측 모델 훈련
- 예측 모델 최적화

# 5. 분석 과정

---

### [개요]

- 특정 온라인 쇼핑몰의 일별 제품별 판매 데이터를 바탕으로 향후 약 3주간의 제품별 판매량을 예측하는 AI 모델을 개발

### **[데이터]**

- **train.csv**
    - ID : 실제 판매되고 있는 고유 ID
    - 제품 : 제품 코드
    - 대분류 : 제품의 대분류 코드
    - 중분류 : 제품의 중분류 코드
    - 소분류 : 제품의 소분류 코드
    - 브랜드 : 제품의 브랜드 코드
    - 2022-01-01 ~ 2023-04-04 : 실제 일별 판매량
    - 단, 제품이 동일하여도 판매되고 있는 고유 ID 별로 기재한 분류 정보가 상이할 수 있음, 즉 고유 ID가 다르다면, 제품이 같더라도 다른 판매 채널

![온라인 채널_1](https://github.com/user-attachments/assets/10e1c924-d93f-49a4-9379-5e86714516df)

- **submission.csv**
    - ID : 실제 판매되고 있는고유 ID
    - 2023-04-05~2023-04-25 : 예측한 일별 판매

![온라인 채널_2](https://github.com/user-attachments/assets/56e383d3-e37c-4b85-a238-d13f72418a9c)

- **sales.csv - 메타(Meta) 정보**
    - ID : 실제 판매되고 있는 고유 ID
    - 제품 : 제품 코드
    - 대분류 : 제품의 대분류 코드
    - 중분류 : 제품의 중분류 코드
    - 소분류 : 제품의 소분류 코드
    - 브랜드 : 제품의 브랜드 코드
    - 2022-01-01 ~ 2023-04-04 : 실제 일별 총 판매금액
- **brand_keyword_cnt.csv - 메타(Meta) 정보**
    - 브랜드 : 브랜드 코드
    - 2022-01-01 ~ 2023-04-04 : 브랜드의 연관키워드 언급량을 정규화한 일별 데이터
- **product_info.csv - 메타(Meta) 정보**
    - 제품 : 제품 코드
    - 제품특성 : 제품 특성 데이터(Text)

### [모델 훈련 및 예측]

### 1. Import Library

- 필요한 라이브러리를 가져옴

### 2. Hyperparameter Setting

- window size : 시계열 데이터에서 모델이 한 번에 처리하는 데이터의 길이, 지난 몇일간의 데이터를 볼 것인지 결정
- predict size : 모델이 한 번에 예측하는 출력의 크기, 미래 몇 개의 타임스텝을 예측할 것인지 결정
- epoch : 전체 학습 데이터셋을 모델에 한 번 완전히 학습시키는 횟수
- learning rate : 모델을 학습할 때, 가중치를 업데이트하는 속도를 조절하는 값, 값이 크면 학습이 빨라지고 작으면 학습이 느려짐
- batch size : 모델을 학습할 때, 한 번에 처리하는 데이터 샘플의 수, 값이 크면 학습이 안정적이지만 속도가 느려짐, 값이 작으면 속도는 빠르지만 학습이 불안정
- seed : 난수 생성 초기값

### 3. Processing Data

- Data Scaling : 수치형 데이터의 값을 일정 범위로 변환, 특정 열들의 최대값과 최소값 규정
- Label Encoding : 범주형 데이터를 숫자로 변환, LabelEncoder 라이브러리 사용
- window size(train size + predict size)에 맞춰서 학습에 사용할 입력 데이터와 예측할 타켓 데이터 생성
- window size와 predict size에 맞춰서 예측에 필요한 입력 데이터 생성

### 4. Custom Data

- PyTorch를 사용해서 DataLoader 사용 → Batch단위로 데이터 로드 및 학습 가능하게 데이터셋 설정

### 5. Classify Model

- BaseModel 메서드 : LSTM(Long Short Term Memory)기반 시계열 예측 모델
    - input size=5 : 시계열 데이터가 5개의 feature로 구성
    - hidden size=512 : LSTM의 hidden state 크기
    - output size=21 : 예측해야 하는 출력 크기
    - self.lstm : LSTM 레이어 정의(batch_first=True 이므로 (batch_size, sequence_length, input_size) 형태로 받음)
    - self.fc : LSTM의 마지막 hidden state를 입력으로 받아 예측값을 출려ㄱ하는 layer, ReLU Activation function과 Dropout을 구성
    - self.actv : 추가적인 ReLU 활성화 함수
- forward 메서드
    - 입력 데이터 텐서 : (batch_size, sequence_length, input_size)
    - hidden sate, cell state 초기화 → 모든 타입스텝에 대해 hidden state 출력 → sequence의 마지막 타임스텝의 hidden state를 예측을 위한 입력으로 사용 → 마지막 hidden state를 fc layer에 통과시켜 최종 예측값 수령

### 6. Train Model

- train 메서드 : 모델 학습하는 함수로 최적 모델을 저장하고 반환
    - 모델을 학습 모드로 전환 → 이전 기울기값 초기화 → 모델 통해 예측값 계산 → 손실 값에 대해 역전파 수행하여 기울기 계산 → 계산된 기울기 바탕으로 모델 파라미터 업데이트 → 실제값과 예측값의 차이인 손실 값 계산
    - 한 번의 epoch 끝날 때마다 검증 데이터에 대해 손실 계산 → 현재 epoch이 이전 최저 epoch보다 낮으면 모델 저장
- validation 메서드 : 학습 도중 모델의 성능 평가하는 함수
    - 모델을 평가 모드로 전환 → Dropout, 기울기 계산 비활성화 → 각 batch에서 손실 값 저장 → 검증 데이터에 대한 평균 손실 값 반환

### 7. Inference Model

- inference 메서드 : 학습된 모델 사용해 테스트 데이터에 대해 예측 수행 함수
    - 테스트 데이터를 배치 단위로 처리
    - 학습된 모델에 데이터을 입력하여 예측값 얻음 → 예측 결과를 CPU로 이동시키고 Numpy 배열로 변환 후 반환
    - 예측된 값을 원래 값의 스케일로 후처리 수행

# 6. 느낀점

---

- 시계열 데이터를 처음 다뤄본 해커톤이였습니다. 일반적인 횡단면 데이터와 다르게 window size를 잘 지정해줘야 한다는 것을 알게되었고 딥러닝 모델의 입력 데이터 형태에 대해서 알 수 있었습니다.
- 유의미한 수요 예측을 위해서는 고도화된 모델을 사용하는 것도 중요하지만, 해당 데이터의 특성을 파악하고 알맞은 전처리 및 변수를 생성해주는 것이 중요할 것 같다고 느꼈습니다.
- 이번 프로젝트 때는 시계열 모델 구축에만 초점을 두었기에 소비재 데이터에 대한 분석 및 변수 생성이 부족했던것 같습니다. 추후 수요 예측을 진행할 때는 EDA를 꼼꼼히 한 후 유의미한 변수를 만든다면 더욱 효과적인 수요 예측을 수행해볼 예정입니다.

# 7. 증빙자료

---

- 대회 안내
    
    https://dacon.io/competitions/official/236129/overview/description
    
- 코드
    
    https://drive.google.com/file/d/1RNBEBAiDX8Azd0XT3RDhoaiNY7Ui8YpI/view?usp=sharing
