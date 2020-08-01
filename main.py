import threading
import time 
import twythonx
import json
import random
import queueAPI

ipc = twythonx.IPC("fusion")
serv1 = twythonx.server("updateSensor")
serv2 = twythonx.server("twitupdate")

#--------- start twythonx engine ---------#
twitAPI = twythonx.twit()
searchWord = "#CUASL"

queue = queueAPI.twitupdate(searchWord)
print(queue)

def updateSensor():
    #--------- this function will trigger update sensor at husion(matlab) ---------#
    while True:
        serv1.publish(".")
        time.sleep(0.02)

def twitHandler():

    while True:
        tweet = twitAPI.search2(searchWord,'tweet_when','text','tweet_id')
        
        queue.autoupdate(tweet)
        msg = queue.dequeue() 
        print(msg)
        templis = [2,random.randrange(50,100),random.randrange(50,100)]#lis[count]
        if msg != None:
            temp = json.dumps(templis)

        #print(tweet)
        print(temp)
        
        serv2.publish(temp)

        time.sleep(1)


if __name__ == "__main__":

    thread1 = threading.Thread(target=updateSensor)
    thread2 = threading.Thread(target=twitHandler)

    cmd = input("Press any key to continue")

    thread1.start() 
    thread2.start() 




        