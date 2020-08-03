import pandas as pd 
import os

class fileAPI:

    def __init__(self,name):
        self.fileName = name
    
    def readFile(self):
        #open csv files
        df = pd.read_csv(self.fileName)
        tempDict = df.to_dict('list')
        return tempDict

    def writeFile(self,inDict):
        #save files in csv form
        df = pd.DataFrame(inDict)
        df.to_csv(path_or_buf= self.fileName ,index=False)
        return "success"
        
        
