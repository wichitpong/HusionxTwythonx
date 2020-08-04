from twython import Twython
from twython import TwythonStreamer
import datetime
class TweetStreamer(TwythonStreamer):
    def on_success(self, data):
        if 'text' in data:
            print (data['text'].encode('utf-8'))

    def on_error(self, status_code, data):
        print (status_code)
        self.disconnect()
class twit:
    def __init__(self):
        #define needed parameter for twitterapi to access twitter account
        APP_KEY = 'X5gCNKpqL6NUsLvBJjIYIm4Pz'
        APP_SECRET = 'UrlJVaRjpWmZrMjmWH7uADCBCzXwdoceIWVv2ftC34z85wpmMR'
        OAUTH_TOKEN = '1267471839929880577-ks8UGM7ydtxJ8xWJpHtv55tUCVGh7Z'
        OAUTH_TOKEN_SECRET = 'QjKJ2FLe3R6gGtGD17lyBauOAqfptcnK75B5Sk8qZRSYN'
        self.twitter = Twython(APP_KEY, APP_SECRET,OAUTH_TOKEN, OAUTH_TOKEN_SECRET)
        self.streamer = TweetStreamer(APP_KEY, APP_SECRET,
                         OAUTH_TOKEN, OAUTH_TOKEN_SECRET)
    def search(self,tag):
        #q => searched quote
        #result_type >> recent, popular, mixed
        results = self.twitter.search(q=tag,result_type = 'recent')
        #this function return results.keys() = ['statuses','meta_data'] we use only 'statuses' here
        statuses  = results['statuses']
        k = []
        for i in range(len(statuses)) :
            #collect wanted results ((( cd.keys() = ['screen_name','id_user','tweet_when','tweet_id','text'] )))
            #in list ((( k )))
            cd = dict()
            cd['screen_name'] = statuses[i]['user']['screen_name']
            cd['id_user'] = statuses[i]['user']['id']
            cd['tweet_when'] = statuses[i]['created_at']
            cd['tweet_id'] = statuses[i]['id']
            cd['text'] = statuses[i]['text']
            cd['location'] = statuses[i]['user']['location']
            k.append(cd)
        return(k)
    def post(self,text):
        #to post status,but can not spam the same tweet at the time. limit 300 tweets/3 hour for standard account 
        self.twitter.update_status(status=text)
        
    def search2(self,text,*args,**kwrgs):
        #q => searched quote
        #result_type >> recent, popular, mixed
        defKwrgs = {'result_type' : 'recent','lang' :'en','count' : 15,'until': str(datetime.date.today()+datetime.timedelta(days=1))}
        for k,item in kwrgs.items():
            defKwrgs[k] = item

        results = self.twitter.search(q=text,\
            result_type = defKwrgs['result_type'],\
            lang = defKwrgs['lang'],\
            count = int(defKwrgs['count']),\
            until = defKwrgs['until']    )
        #this function return results.keys() = ['statuses','meta_data'] we use only 'statuses' here
        statuses  = results['statuses']
  
    
        #for arg in args:
        k = []
 
        for i,st in enumerate(statuses) :
            #collect wanted results ((( cd.keys() = ['screen_name','id_user','tweet_when','tweet_id','text'] )))
            #in list ((( k )))
            cd = dict()

            cd['screen_name'] = st['user']['screen_name']
            cd['id_user'] = st['user']['id']
            cd['tweet_when'] = st['created_at']
            cd['tweet_id'] = st['id']
            cd['text'] = st['text']
            cd['location'] = st['user']['location']
            temp = dict()
            if len(args) == 0 or args[0] == 'all': temp = cd
            else:
                for arg in args:
                    temp[arg] = cd[arg]
            k.append(temp)
        return k
    def stream(self,text):
        self.streamer.statuses.filter(track = text)
