## 1. 배경 & 목적

---

- 네이버 뉴스 기사 홈페이지에는 “정치”,”경제”,”생활/문화”,”사회”,”과학”등으로 섹션이 나누어져 있습니다.
- 스크래핑을 통해서 섹션 별 뉴스 기사의 본문을 가져온 후 본문 내용에 BOW를 이용해서 텍스트 분석을 진행했습니다. 이를 바탕으로 RandomForest Classifier을 이용해서 뉴스 섹션을 예측하는걸 목표로 두었습니다.

## 2. 주최 & 참가 대상 & 성과

---

- 주최: 개인 프로젝트
- 참가 자격 및 팀 인원 제한 사항: -
- 성과: -

## 3. 프로젝트 기간(대회 기간)

---

- 프로젝트 기간: 2023년 1월

## 4. 담당 역할

---

- 전체 분석 진행-

## 5. 내용

---

### 활용 데이터

[Data List (1)](https://www.notion.so/cc6599290f9b40369e9575a0fa317576?pvs=21)

### 분석 방법

1. 뉴스기사 본문 스크래핑
2. 뉴스기사 본문 BOW 진행
3. RandomForest Classifier로 섹션 예측

 

## 6. 데이터분석 PROCESS

---

### Ch1. 뉴스기사 스크래핑

![네이버 뉴스 기사_1](https://github.com/Gayeon6423/Project/assets/113704015/9535e993-769c-4f00-87a2-b2f7082a5746)

- 경제, 생활/문화, 정치섹터의 기사 제목, url, 기사 본문을 스크래핑 해서 각 섹터별로 정보가 담긴 데이터프레임을 제작했습니다.

  1. 라이브러리를 불러옵니다.

```python
!pip install beautifulsoup4 -U 
import requests
from bs4 import BeautifulSoup
from urllib.request import urlopen
```
1. 경제 섹터에 있는 기사 제목, url, 섹션명을 가져와서 economy 리스트에 넣어줍니다.

```python
from tqdm import tqdm

date = "20230221"
sections = [("금융","259"),("증권","258"),("산업/재계","261"),("중기/벤처","771"),
    ("부동산","260"),("글로벌 경제","262"),("생활경제" ,"310"),("경제 일반","263")]

economy = []
class1 = ['type06_headline','type06']

for name, code in sections:
    url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid2={code}&sid1=101&date={date}&page=999"
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
    html = requests.get(url,headers=headers).text
    soup = BeautifulSoup(html,"html.parser")
    max_page = soup.select("#main_content > div.paging > strong")[0].text
    max_page = int(max_page)

    for i in tqdm(range(1,max_page)):
        url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid2={code}&sid1=101&date={date}&page={i}"
        headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
        html = requests.get(url,headers=headers).text
        soup = BeautifulSoup(html,"html.parser")
        
        for k in class1:
            for n in range(1,11):
                href_dict = f"#main_content > div.list_body.newsflash_body > ul.{k} > li:nth-child({n}) > dl > dt:nth-child(2) > a"
                href_html = soup.select(href_dict)
                for j in href_html:
                    dic = {}
                    dic["name"] = j.text.strip()
                    dic["url"] = j["href"]
                    dic['sections'] = name
                    dic["Sectors"] = '경제'
                    economy.append(dic)
                print(dic)
```

1. economy에 있는 url을 바탕으로 기사의 본문 내용을 가져와줍니다.

```python
for dic in economy:
    url = dic['url']
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
    html = requests.get(url, headers=headers).text
    soup = BeautifulSoup(html,"html.parser")

    href_dict = "#dic_area"
    href_html = soup.select(href_dict)

    if href_html:
        content = href_html[0].text.strip()
    else:
        content = None
    print(content)
```

1. 데이터프레임으로 만들어준 후 csv파일로 제작합니다.

```python
economy_df = pd.DataFrame(economy)
economy_df.to_csv('economy_df.csv',encoding = "utf-8-sig")
```

1. 생활/문화 섹터도 동일한 과정을 반복해 줍니다.

```python
date = "20230221"
sections = [("건강정보","241"),("자동차/시승기","239"),("도로/교통","240"),("여행/레저","237"),
    ("음식/맛집","238"),("패션/뷰티","376"),("공연/전시" ,"242"),("책","243"),("종교","244"),("날씨","248"),("생활문화 일반","245")]

culture = []
class1 = ['type06_headline','type06']

for name, code in sections:
    url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid2={code}&sid1=103&date={date}&page=999"
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
    html = requests.get(url,headers=headers).text
    soup = BeautifulSoup(html,"html.parser")
    max_page = soup.select("#main_content > div.paging > strong")[0].text
    max_page = int(max_page)

    for i in tqdm(range(1,max_page)):
        url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid2={code}&sid1=103&date={date}&page={i}"
        headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
        html = requests.get(url,headers=headers).text
        soup = BeautifulSoup(html,"html.parser")
        
        for k in class1:
            for n in range(1,11):
                href_dict = f"#main_content > div.list_body.newsflash_body > ul.{k} > li:nth-child({n}) > dl > dt:nth-child(2) > a"
                href_html = soup.select(href_dict)
                for j in href_html:
                    dic = {}
                    dic["name"] = j.text.strip()
                    dic["url"] = j["href"]
                    dic['sections'] = name
                    dic["Sectors"] = '생활문화 일반'
                    culture.append(dic)
                print(dic)

for dic in culture:
    url = dic['url']
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
    html = requests.get(url, headers=headers).text
    soup = BeautifulSoup(html,"html.parser")

    href_dict = "#dic_area"
    href_html = soup.select(href_dict)

    if href_html:
        dic["content"] = href_html[0].text.strip()
    else:
        dic["content"] = None
    print(dic["content"])
```

```python
culture_df = pd.DataFrame(culture)
culture_df.to_csv('culture_df.csv',encoding = "utf-8-sig")
```

1. 정치 섹터도 동일한 과정을 반복해줍니다.

```python
date = "20230221"
sections = [("대통령실","264"),("국회/정당","265"),("북한","240"),("여행/레저","268"),
    ("행정","266"),("국방/외교","267"),("정치일반" ,"269")]

politics = []
class1 = ['type06_headline','type06']

for name, code in sections:
    url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid2={code}&sid1=100&date={date}&page=999"
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
    html = requests.get(url,headers=headers).text
    soup = BeautifulSoup(html,"html.parser")
    max_page = soup.select("#main_content > div.paging > strong")[0].text
    max_page = int(max_page)

    for i in tqdm(range(1,max_page)):
        url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid2={code}&sid1=100&date={date}&page={i}"
        headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
        html = requests.get(url,headers=headers).text
        soup = BeautifulSoup(html,"html.parser")
        
        for k in class1:
            for n in range(1,11):
                href_dict = f"#main_content > div.list_body.newsflash_body > ul.{k} > li:nth-child({n}) > dl > dt:nth-child(2) > a"
                href_html = soup.select(href_dict)
                for j in href_html:
                    dic = {}
                    dic["name"] = j.text.strip()
                    dic["url"] = j["href"]
                    dic['sections'] = name
                    dic["Sectors"] = '정치'
                    politics.append(dic)
                print(dic)

for dic in politics:
    url = dic['url']
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"}
    html = requests.get(url, headers=headers).text
    soup = BeautifulSoup(html,"html.parser")

    href_dict = "#dic_area"
    href_html = soup.select(href_dict)

    if href_html:
        dic["content"] = href_html[0].text.strip()
    else:
        dic["content"] = None
    print(dic["content"])
```

```python
politics_df = pd.DataFrame(politics)
politics_df.to_csv('politics_df.csv',encoding = "utf-8-sig")
```

[섹터별 기사정보](https://www.notion.so/e88d969524eb4b52852bb3a34885ebc5?pvs=21)

### Ch2. 뉴스기사 본문 Bag Of Words

- 뉴스기사의 본문을 형태소별로 나눈 후 BOW를 직접 구현해보았습니다. Random Forest Classifier을 이용해서 섹터를 예측해본 결과 accuracy_score 0.86이라는 좋은 결과를 보였습니다.

1. 라이브러리를 가져와줍니다.

```python
!pip install konlpy
import nltk
from konlpy.tag import Okt
from tqdm import tqdm
import requests
from bs4 import BeautifulSoup
from urllib.request import urlopen
import pandas as pd
okt = Okt()
```

1. 경제, 생활/문화, 정치 기사 데이터를 가져온 후 하나의 news_df로 만들어줍니다.

```python
economy_df = pd.read_csv("./economy_df.csv",index_col=0)
culture_df = pd.read_csv("./culture_df.csv",index_col=0)
politics_df = pd.read_csv("./politics_df.csv",index_col=0)
news_df = pd.concat([economy_df,culture_df,politics_df])
news_df = news_df.reset_index(drop=True)
news_df
```

1. 중복을 제거해줍니다.

```python
news_df = news_df.drop_duplicates("url")
news_df = news_df.dropna()
news_df.info()
```

1. okt를 활용해서 형태소 분리를 해줍니다.

```python
pos_map = {}
for i in tqdm(news_df["content"].index):
    text = news_df.loc[i, "content"]
    poss = okt.pos(text)
    pos_map[i] = poss

pos_map
```

1. noun, adjective, verb, adverb형태소만 가져와서 리스트로 만들어줍니다.

```python
#딕셔너리 안에 리스트 넣기
word_class = {}

#행별 기사 가져오기
for i in tqdm(news_df["content"].index):
     text = pos_map[i]
     
#word_class[i]리스트에 해당하는 품사 넣기 
     word_class[i] = []
     for word,tagset in text:
        if tagset in ['Adjective','Adverb','Noun','Verb']:
            word_class[i].append(word)
```

1. 중복값을 제거해줍니다.

```python
#리스트 만들고
#value값만 for문으로 가져와서
#하나씩 extend로 리스트에 추가
#list_set중복 제거

word_list = []
for value in word_class.values():
    word_list.extend(value)
    word_list = list(set(word_list)) #set중복제거, list로 만들기

print(word_list)
```

1. 중복 제거된 단어들을 열로 만들고 단어의 빈도수를 나타내는 데이터 프레임을 제작했습니다.

```python
#처음 index로 for문 돌려서 시리즈로 만들기
#중복이 된거 가져와서 시리즈로 만들기
#value_count해주기
#loc사용해서 value_count한거에 value값만 넣기
#NAN을 0으로 만들기
#품사 개수 value값을 시리즈로 만들고
word_list_df = pd.DataFrame(columns=word_list)
word_list_df
```

```python
datas = []
for i in tqdm(news_df['content'].index):
    word_class_series = pd.Series(word_class[i]).value_counts()
    data = word_class_series.to_dict()
    datas.append(data)

word_list_df = pd.DataFrame(datas, index=news_df.index)
```

1. fillna로 결측값을 처리했습니다.

```python
word_list_nan = word_list_df.fillna(0)
word_list_nan
```

![네이버 뉴스 기사_2](https://github.com/Gayeon6423/Project/assets/113704015/ea8f6d8f-d487-4f45-8231-2907c8334950)

```python
#데이터의 용량이 커져서 중간에 파일을 저장해주었습니다.
word_list_nan.to_csv('bow.csv')
word_list_nan = pd.read_csv("bow.csv", index_col=0)
```

1. Section을 추가해줍니다.

```python
#섹션 컬럼 붙이기
word_list_nan["Sectors"] = news_df["Sectors"]
#섹션 명 0,1,2,3으로 변환 시키기 replace
# word_list_nan.replace([["경제",0],["정치",1],["생활문화 일반",2]], inplace=True)

unique_sectors = word_list_nan["Sectors"].unique()

sector_map = {}
sector_unmap = {}

for i, sector in enumerate(unique_sectors):
    sector_unmap[i] = sector
    sector_map[sector] = i

print(sector_map)
print(sector_unmap)
```

```python
word_list_nan["Sectors"] = word_list_nan["Sectors"].replace(sector_map)
news_df["Sectors"]
```

## RandomForest Classifier로 섹션 예측

1. RandomForest를 이용해서 카테고리 예측 모델을 제작했습니다.

```python
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

X = word_list_nan.drop("Sectors", axis=1) #sectors빼고 출력
y = word_list_nan['Sectors']
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3,random_state=0)

rf = RandomForestClassifier(n_estimators=100, random_state=0)
rf.fit(X_train, y_train)
y_pred = rf.predict(X_test)
print('accuracy_score : ',accuracy_score(y_test,y_pred))
```

```python
#섹션별 비율
bow = word_list_nan
all_len = len(bow["Sectors"])
print('전체 길이:',all_len)
vc = bow["Sectors"].value_counts()
vc = vc / all_len
vc.index = pd.Series(vc.index).replace(sector_unmap)
vc
```
![네이버 뉴스 기사_3](https://github.com/Gayeon6423/Project/assets/113704015/3b40fd91-4737-4a46-ad6f-5b84c0539470)

## 7. 증빙자료

---

- 코드
    
     [스크래핑 코드](https://drive.google.com/file/d/1WaKC1aTR_J5vkotX5IUNAo28--_cnSsc/view?usp=sharing)
    
    [모델링 코드(BOW)](https://drive.google.com/file/d/1ebQjeSz07GzoMpVMiLHm_6OxCqT4L5GT/view?usp=sharing)
    

- 참고자료

https://book.coalastudy.com/data_crawling/week3/stage3

[https://celltong.tistory.com/entry/파이썬-크롤링-실습-네이버-뉴스-섹션들-기사-링크-추출하기](https://celltong.tistory.com/entry/%ED%8C%8C%EC%9D%B4%EC%8D%AC-%ED%81%AC%EB%A1%A4%EB%A7%81-%EC%8B%A4%EC%8A%B5-%EB%84%A4%EC%9D%B4%EB%B2%84-%EB%89%B4%EC%8A%A4-%EC%84%B9%EC%85%98%EB%93%A4-%EA%B8%B0%EC%82%AC-%EB%A7%81%ED%81%AC-%EC%B6%94%EC%B6%9C%ED%95%98%EA%B8%B0)
