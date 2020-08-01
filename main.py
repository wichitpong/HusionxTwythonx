import threading
import time 
import twythonx
import json
import random
import queueAPI
import prep

ipc = twythonx.IPC("fusion")
serv1 = twythonx.server("updateSensor")
serv2 = twythonx.server("twitupdate")

#--------- start twythonx engine ---------#
twitAPI = twythonx.twit()
searchWord = "#cuasl0"

#--------- start service engine : prep check and queueAPI ---------#
queue = queueAPI.twitupdate(searchWord)
conv = prep.prep()


def updateSensor():
    #--------- this function will trigger update sensor at husion(matlab) ---------#
    while True:
        serv1.publish(".")
        time.sleep(0.02)

def twitHandler():

    while True:
        time.sleep(10)

        tweet = twitAPI.search2(searchWord,'tweet_when','text','tweet_id')
        queue.autoupdate(tweet)             #enqueue new twit
        tempCell = queue.dequeue()          #dequeue : return front of queue


        if tempCell != None:
            #check if have tweet and check exist location 
            tempLocation = conv.check(tempCell['text'])
            if tempLocation == None :
                print("Location or Preposition not found at tweet :",tempCell['text'])
                continue

            tempDict = {"timeStamp": tempCell['tweet_when'],"location":tempLocation}
            msg  = twythonx.toJson(tempDict)

        else:
            continue

        print(msg)        
        serv2.publish(msg)

        


if __name__ == "__main__":

    thread1 = threading.Thread(target=updateSensor)
    thread2 = threading.Thread(target=twitHandler)

    cmd = input("Press any key to continue")

    thread1.start() 
    thread2.start() 




        