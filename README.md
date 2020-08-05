# HusionxTwythonx

## How to Install
1.Install WSL, Python3, Matlab 

2.Install required python library : 
* twython
* pandas

please run this following command on WSL
```bash
pip3 install pandas
pip3 install twython
```

3.Install [ROS](http://wiki.ros.org/noetic/Installation/Ubuntu)
> you can see our ROS installation tutorial at [https://github.com/CUASL/ipcx/wiki/Installation](https://github.com/CUASL/ipcx/wiki/Installation)

4.Copy our library folder [ipcx](https://github.com/CUASL/ipcx/tree/master/ipcx) on our github
to your project directory so that you can use our library.

5.import our library in your code
    
python
```python
import twythonx
```
matlab
```matlab
addpath('twythonx')
```

https://github.com/CUASL/ipcx/wiki/Installation

## How to run

step 1 edit path in democode.m

step 2 edit # in main.py Example #cuasl0 #cuasl01 

step 3 on WSL and matlab

open wsl 1
```bash
roscore
```

open wsl 2
กด ctrl+shift+right click ที่ directory ของไฟล์ main.py
```bash
python3 main.py
```

run democode.m in matlab


