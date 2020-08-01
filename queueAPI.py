class twitupdate:

    def __init__(self,text):

        self.text = text
        self.waitlist = []
        self.alltwit = []


    def autoupdate(self,resultSearchTwit):
        for search in resultSearchTwit:

            if search not in self.alltwit:

                self.alltwit.append(search)
                #enqueue
                self.waitlist.append(search)


    def dequeue(self):
        if len(self.waitlist) == 0: 
            return None

        front = self.waitlist[0]
        self.waitlist = self.waitlist[1:]

        return front