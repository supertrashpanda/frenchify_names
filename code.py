from pypinyin import pinyin, lazy_pinyin, Style
import pandas as pd

df = pd.read_csv('inventory.csv')

import re
def remove(string):
    ns=""
    for i in string:
        if(not i.isspace()):
            ns+=i
    return ns   


def frenchize(name):
  fname=""
  for kanji in name:
    try:
        sheng=pinyin(kanji, style=Style.INITIALS)[0][0] 
        if sheng=='':sheng='0'
        yun=pinyin(kanji, style=Style.FINALS)[0][0]
        fsheng=df.loc[(df['pinyin']==sheng)&(df['initial']==1)].french.values[0]
        fyun=df.loc[(df['pinyin']==yun)&(df['initial']==0)].french.values[0]
    except: return('检测到非中文名')
    fpinyin=remove(fsheng+fyun)
    fpinyin=re.sub("ii", "i", fpinyin)
    fpinyin=re.sub("yi", "y", fpinyin)
    fpinyin=re.sub("iy", "i", fpinyin)
    fpinyin=re.sub("yy", "y", fpinyin)
    fpinyin=re.sub("ee", "e", fpinyin)
    fpinyin=re.sub("e'e", "e'a", fpinyin)
    fpinyin=re.sub("i'i", "'i", fpinyin)
    fpinyin=re.sub("ny", "'gn", fpinyin)
    fpinyin=re.sub("ni", "gn", fpinyin)
    fpinyin=re.sub("ce", "que", fpinyin)
    fpinyin=re.sub("c'e", "qu'e", fpinyin)
    fpinyin=re.sub("ci", "qui", fpinyin)
    fpinyin=fpinyin.capitalize()
    fname=fname+" "+fpinyin
  return fname



