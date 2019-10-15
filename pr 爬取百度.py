import requests
import json

def getjson(loc,page_num=0):
    headers = {'User-Agent':'Mozilla/5.0(Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36'}
    pa={'q':'公园',
    'region':loc,
    'scope':'2',
    'page_size':'20',
    'page_num':page_num,
    'output':'json',
    'ak':'1DyRIrDBmCoy9E2QwXFiy10U4Mi2DkvE'
    }

    r=requests.get('http://api.map.baidu.com/place/v2/search',params=pa,headers=headers)
    decodejson=json.loads(r.text)
    return(decodejson)
    city=decodejson['name']
    num=decodejson['num']
    output='\t'.join([city,str(num)])+'\r\n'
    with open('city.txt','a+',encoding='utf-8') as f:
        f.write(output)
        f.close() 

getjson('北京市')
