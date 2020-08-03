import json

class prep:
    def __init__(self):
        
        f = open('map.json',)
        self.data = json.load(f)
        self.lmlist = self.data['LandmarkList'].keys()
        f.close()
    def check (self,text):
        position=['null','near','far','at']
        place=self.data['LandmarkList']
        x=[]
        check=0
        check2=0
        for a in position:
            if a in text:
                x.append(position.index(a))
                check+=1
        
            
            
        for a in place:
            if a in text:
                x_coords = [p[0] for p in place[a]['Vertices']]
                y_coords = [p[1] for p in place[a]['Vertices']]
                _len = len(place[a]['Vertices'])
                centroid_x = sum(x_coords)/_len
                centroid_y = sum(y_coords)/_len
                x.append(centroid_x)
                x.append(centroid_y)
                check2+=1
        if check2==0 or check==0:
            return None
        else:
            return(x)


"""
#usage

x=prep()
y=x.check('found near b1')
print(y)   

"""
