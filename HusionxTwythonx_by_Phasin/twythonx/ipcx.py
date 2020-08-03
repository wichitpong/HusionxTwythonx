import rospy
import time
import json
from std_msgs.msg import String


class IPC:

    def __init__(self,node):
        #------- initialize IPC -------#
        self.node = node
        rospy.init_node(node)

    def isRun(self):
        #------- to check is ros run? -------#
        return not rospy.is_shutdown()

    def spin(self):
        #------- loop ros (use in subscriber) -------#
        rospy.spin()

    def off(self):
        #------- off loop ros (use in subscriber) -------#
        rospy.signal_shutdown("bye")

class server:

    def __init__(self,topic):
        #------- create server that will publish : topic -------#
        self.topic = topic
        self.publisher = rospy.Publisher(topic, String, queue_size=10)

       
        

    def publish(self,message,**kwargs):
        #------- publish message -------#
        #can select to show message : "on"
        if kwargs:
            if kwargs["show"] == "on": 
                print(message)

        self.publisher.publish(message)
        
class client:

    def __init__(self,topic,callback = None):
         #------- create client that will subscribe : topic -------#
         # if you want to use data, you must create callback function
        self.topic = topic
        if callback == None :
            callback = defaultCallback
        self.subscriber = rospy.Subscriber(topic, String, callback)




        

def defaultCallback(msg):
    #------- default callback function -------#
    print(msg.data)



def toJson(data):
    #------- make data to json-------#
    return json.dumps(data)

def toDict(data):
    #------- make json to dict-------#
    return json.loads(data)
        