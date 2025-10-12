# 1. 배경 & 목적

---

- **주제명**  : PDF 문서 기반 RAG 벤치마크자동구축서비스
- 문제 정의
    - **문서 구조별 파싱 성능 한계**: 비정형 문서에서는 문서 구조에 따라 OCR 라이브러리별 성능 차이가 있으며, 문서 구조에 적합한 라이브러리를 사람이 직접 비교·선택하는 과정에서 큰 시간 소모가 발생함
    - **수작업 QA 데이터 구축의 한계**: 비용·시간 소모가 크고, 사람이 만든 데이터임에도 난이도가 낮거나 단순한 문제가 포함될 수 있음
    
    <img width="1199" height="340" alt="doc1" src="https://github.com/user-attachments/assets/81931325-f9ba-46a0-bad8-379fb3ac04fa" />
    

# 2. 주최 & 참가 대상 & 성과

---

- 주최 : Meta Llama Academy
- 팀 인원 : 5명 팀
- 성과 : 수료

# 3. 대회 기간

---

- 대회 기간 : 2025년 9월 30일~2025년 10월 2일

# 4. 담당 역할

---

- 추출된 텍스트 기반 벤치마크 데이터 구축
- LLM-Judgge 파이프라인 구축
- HuggingFace 데이터셋 업로드

# 5. 서비스

## 5.1 서비스 소개

---

<img width="659" height="404" alt="doc2" src="https://github.com/user-attachments/assets/a87702d8-2bcd-4c45-a6df-37730421b425" />


**[Multi-Agent 기반 문서 구조에 최적화된 텍스트 추출 자동화]**

- 기존에는 사용자가 여러 API를 실험적으로 비교·선택해야 했으나, 본 시스템은 문서 구조를 분석해 **최적의 파싱 방식을 자동으로 결정**
- Multi-Agent 기반 입력된 문서 구조 분석 → 품질∙비용이 최적화된 파싱 도구 추천
- On-device LLM 기반 사전 필터링으로 정제가 꼭 필요한 문서만 외부 LLM에 전달 → 최종 정제 비용 절감 효과
- **장점**: 사용자가 직접 API를 비교·선택할 필요가 없어 **시간과 비용을 절감**하고, 문서 유형별로 항상 **최적화된 품질**의 텍스트를 확보할 수 있음

**[RAG 벤치마크 자동 구축]**

- 추출된 텍스트 기반 질의응답 데이터 자동 생성
- 3가지 유형의 LLM-Judge를 통해 RAG 벤치마크의 분별력과 타당성 확보
- **장점**: 도메인과 무관한 일반 질문이나 **너무 쉬운 문제**는 제거하여, 벤치마크로서의 **분별력과 타당성**을 보장

## 5.2 서비스 구현

### **5.2.1 Doc-to-Text: API Recommendation**

- 3가지 Agent가 순차적으로 실행되는 Multi-Agent 구조를 통해 문서 구조에 최적화된 파싱 도구를 추천
1. 기본 추출 Agent
2. 유효성 검증 Agent (Solar Pro 2)
3. LLM-Judge Agent (Solar Pro 2)

<img width="1140" height="1082" alt="doc3" src="https://github.com/user-attachments/assets/d68875fb-f0c8-4211-8f01-3e63e5f71520" />


### **5.2.2 Doc-to-Text: Text Refinement**

- 3가지 Agent가 순차적으로실행되는Multi-Agent 구조를 통해 벤치마크 구축에 활용할 텍스트 최종 정제
1. 기본 추출 Agent
2. 정제 필요 여부 검증 Agent (Llama-3.2-3B-Instruct_
3. 문서 정제 Agent (Solar Pro 2)
- On-device LLM을 통해 정제 필요 문서만 Solar Pro2에 전달 → 불필요한 정제 비용 절감
    
<img width="999" height="1082" alt="doc4" src="https://github.com/user-attachments/assets/e917c10c-39ed-4ab3-a4ab-a87e09ab15a6" />


### **5.2.3 Text-to-Benchmark**

**1) LLM 기반 질문–정답 자동 생성**

- **기능**
    - OCR로 추출된 문맥을 활용해서 LLM으로 질문-정답 쌍을 생성
    - 입력된 문맥 중 민감 정보에 해당하는 부분은 마스킹(예: <NAME>, <PHONE>) 되어 있음
    - 마스킹된 부분이 중요하다고 생각되면 마스킹을 포함해서 질문-정답 쌍을 생성함

**2) RAG 기반 Top-K 문서 구성**

- **기능**
    - Retriever를 활용해 관련 Top-K 문서 후보군 구성
- **구현 과정**
    - OCR 끝난 전체 문서 임베딩
    - 코사인 유사도 기반 벡터 인덱스 생성
    - 질문 임베딩 후 Retriver 사용해서 유사한 문서 검색
    - Retriever가 질문을 임베딩하고 문서 임베딩과 유사도 점수 산출
    - 점수 기준 상위 K개의 문서(Top-K 후보 문서)를 선별

**3) 벤치마크 타당성 확보**

**3-1) 도메인 적합성 평가**

- **기능**
    - LLM이 문서의 도메인을 자동으로 판단 → 도메인에 적합한 프롬프트를 생성
    - 생성된 프롬프트 기반으로 LLM이 벤치마크의 도메인 적합성 평가
        
        <img width="1238" height="520" alt="doc5" src="https://github.com/user-attachments/assets/440d1f0e-db6b-4ed9-8b37-85d3752c9050" />

        
- **적합성 평가 기준**
    - 도메인 전문 용어 사용 정확성
    - 도메인 특화 지식 정확성
    - 도메인 맥락의 적절성
- **평가 점수 기준**
    - 1점: very valid
    - 2점: valid
    - 3점: normal
    - 4점: invalid
    - 5점: very invalid

**3-2) 질의응답 난이도 평가**

- **기능**
    - 질의응답 데이터의 난이도를 평가
- **난이도 평가 기준**
    - 필요한 배경 지식의 수준
    - 추론과 분석의 복잡성
    - 전문 용어와 개념의 어려움
    - Context에서 답을 찾는 난이도
    - 종합적 사고력 요구 수준
- **평가 점수 기준**
    - 1점: very easy
    - 2점: easy
    - 3점: medium
    - 4점: hard
    - 5점: very hard

**2-3) 데이터 품질 평가**

- **기능**
    - 질의응답 데이터의 품질을 평가
- **품질 평가 기준**
    - Context와 Question의 관련성
    - Question의 명확성과 구체성
    - Answer의 정확성과 완성도
    - 전체적인 논리적 일관성
    - 정보의 유용성과 가치
- **평가 점수 기준**
    - 1점: very poor
    - 2점: poor
    - 3점: average
    - 4점: good
    - 5점: excilent

3-4) 평가 기반 필터링

- **기능**
    - 도메인 타당성, 퀄리티, 난이도를 종합적으로 고려해 기준을 만족하지 않는 벤치마크 항목을 제거
- **필터링 기준**
    - 도메인 타당성 > 2점
    - 퀄리티 > 2점
    - 난이도 > 2점

- 동일한 context에 대해서 생성된 질문 후보
    - LLM이 판단한 도메인에 적합한지 점수를 매김

<img width="1229" height="313" alt="doc6" src="https://github.com/user-attachments/assets/8c83cd21-9bf1-49eb-86a2-371d598055a7" />


- HuggingFace에 공개한 데이터셋 예시

<img width="1784" height="391" alt="doc7" src="https://github.com/user-attachments/assets/74c177e0-92d2-47bf-be21-a1b92f350fc6" />


## 5.3 데모 페이지

### [메인 & 업로드 페이지]

<img width="2559" height="1338" alt="domo1" src="https://github.com/user-attachments/assets/bf5da013-56b5-483e-9a37-9c69b59f2f9b" />


<img width="2559" height="1339" alt="domo2" src="https://github.com/user-attachments/assets/fde91e5f-4832-44e8-82da-f057b06640cc" />

---

### [분석 현황 페이지]

- 텍스트 추출
- 벤치마크 구축

<img width="2559" height="1342" alt="domo3" src="https://github.com/user-attachments/assets/65f58301-e724-40ed-b78a-257f4b9f55bf" />
---

## [텍스트 추출]

- OCR 결과 페이지

<img width="2559" height="1339" alt="domo4" src="https://github.com/user-attachments/assets/1b260ab3-c776-4358-b1e1-3163a860486e" />

- 구성 요소
    - 문서 정보
        - 파일명, 총 페이지, 처리일
    - OCR 결과 비교
        - LLM-Judge 결과 가장 좋은 거 & 비용 가장 낮은 거에 하이라이팅
        - 페이지 개수 정보 활용해서 총 예상 비용까지 함께 제공
        - 최종적으로, llm-judge 결과 + 비용을 모두 고려해서 최종 추천하는 api가 무엇인지 llm으로 생성
    - 텍스트 추출 과정

<img width="1157" height="1344" alt="domo5" src="https://github.com/user-attachments/assets/b663bbcc-2865-4aee-8764-b18deb51e50b" />

## 5.4 결론

**[기대효과]**

- 다양한 문서 구조에 대해 Multi-Agent 기반 분석을 통해 적합한 파서도구를 추천함으로써, 사람이 직접 도구를 비교 선택하던 과정을 제거
- On-device LLM을 통해 필터링 필요 문서만 외부 LLM에 전달 → 불필요한 정제 비용 절감
- 문서 기반으로 LLM이 질의응답 자동 생성 → 시간 비용 절감

**[추후 개발 계획]**

- 사용자가 질의응답 생성 프롬프트 설정에 직접 개입할 수 있도록 고도화
- 말투 질문 유형을 사용자 맞춤형으로 조절해서 벤치마크 개선 가능

# 6. 느낀점

---
강의를 통해 LLM Agent Workflow 설계 방법과 On-device LLM을 로컬 환경에서 실행하는 방법을 학습하고, 이를 실제 프로젝트에 적용해볼 수 있는 유익한 시간이었습니다. 

이번 프로젝트는 프론트엔드, 백엔드, 그리고 AI 엔지니어가 함께 협업한 팀 프로젝트로, 저는 AI 엔지니어 역할을 맡아 진행했습니다. 

팀장님께서 프로젝트 주제를 정한 뒤 각자의 역량에 맞게 역할을 분담해 주셨고, 전체 진행 상황을 꾸준히 점검하며 프로젝트 매니저 역할을 수행해주신 덕분에 원활하게 프로젝트를 마무리할 수 있었습니다. 

GitHub Organization을 통해 코드를 통합하고, Notion 테스크 보드를 활용해 Doc-to-Text, Text-to-Benchmark, Drive 등으로 세부 파트를 나누어 체계적으로 협업했습니다. 

이 과정을 통해 효율적인 협업 방법과 프로젝트 관리 노하우를 습득할 수 있었고, 동시에 완성도 높은 서비스를 구축하는 경험을 얻을 수 있었습니다.
