README

1)사용한 데이터
(Main Data)
01. 서울특별시 학원 교습소정보.csv
->서울특별시에 개설되어있는 학원 및 교습소의 학원명, 휴원일자, 정원, 분야, 계열 및 과정등을 확인할 수 있으며 수강료 공개여부에 따라 수강료 내용을 확인할 수 있습니다.
02. 서울특별시 학교 기본정보.csv
->서울특별시 학교 기본정보에 대한 학교명, 소재지, 주소, 남녀공학여부, 주야구분, 개교기념일 등을 확인할 수 있는 현황입니다.
03. 서울특별시 유치원 일반현황.csv
->서울특별시 소재 유치원 기본정보 유치명, 소재지, 주소 등 현황입니다.
04. 서울시 주민등록연앙인구(연령별동별) 통계.csv
->서울시 통계정보시스템에서 제공하는 주민등록인구(연령별, 동별)에 대한 통계정보 입니다.

(Sub Data)
01. 서울시 가구형태별 가구 및 가구원 (동별) 통계.csv
->서울시 통계정보시스템에서 제공하는 가구형태별 가구 및 가구원(동별)에 대한 통계정보 입니다.
02. 서울시 주민등록인구 (동별) 통계.csv
->서울시 통계정보시스템에서 제공하는 주민등록인구(동별)에 대한 통계정보 입니다.
03. 서울특별시 유치원 통학차량 현황.csv
->서울특별시 소재 유치원의 차량운행여부, 운행차량 수, 신고차량 수 등 현황입니다.
04. 자치구별 1인당 지역내총생산 및 수준지수.csv
->자치구별 지역내총생산(당해년가격)을 나타내는 데이터입니다.

(외부데이터)
2021 서울시 학급당 학생수 통계.xlsx
->2021년 자치구별 유치원, 초등학교, 중학교, 고등학교 학생 수 데이터입니다.

(제작데이터)
helloworld_data_set.xlsx
->Main Data 1~4, Sub Data 1, 3, 4 전처리 후 시트별로 구분하여 하나의 excel 파일로 통합한 데이터입니다.

2)소스코드 파일구성
Project_A_핼로월드조_Main_01.ipynb
->Main Data 01. 서울특별시 학원 교습소정보.csv에 대해서 Preprocessing, Analyze, Visualize를 하였습니다.
->주제 2 – 강남 8학군은 실제로 학구열이 높을까?를 주제로 분석하고 결론을 도출했습니다.

Project_A_핼로월드조_Main_02.ipynb
->Main Data 02. 서울특별시 학교 기본정보.csv에 대해서 Preprocessing, Analyze, Visualize를 하였습니다.
->주제 3 - gdp가 높은 자치구 학구열 높을까?를 주제로 분석하고 결론을 도출했습니다.

Project_A_핼로월드조_Main_03.ipynb
-> Main Data 03. 서울특별시 유치원 일반현황.csv에 대해서 Preprocessing, Analyze, Visualize를 하였습니다.
->주제 1 - 자치구별 학교 다니는 학생수 비율, 자치구별 학원 다니는 학생수 비율을 주제로 분석하고 결론을 도출했습니다.

Project_A_핼로월드조_Main_04.ipynb
-> Main Data 04. 서울시 주민등록연앙인구(연령별동별) 통계.csv에 대해서 Preprocessing, Analyze, Visualize를 하였습니다.
-> 주제 4 - 서울 외곽 지역에 학원 수가 많은 이유는?을 주제로 분석하고 결론을 도출했습니다.

Project_A_핼로월드조_Sub.ipynb
-> Sub Data 01,02,03,04에 대해서 Preprocessing, Analyze, Visualize를 하였습니다.
-> 주제 5 - 서울특별시의 교육사각지대와 서울런 사업을 주제로 분석하고 결론을 도출했습니다.


