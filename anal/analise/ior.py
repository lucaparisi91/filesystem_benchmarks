
import numpy as np
import matplotlib
import matplotlib.pylab as plt
import scipy as sp
import pandas as pd
import re
import os
from . import find_reports

def build_ior_pattern():
    pattern_float=r"(\d+(?:\.\d+)*)"
    patter_int=r"(\d+)"
    pattern="^(\w+)" 
    for i in range(10):
        pattern=pattern + r"\s+" + pattern_float
    pattern=pattern+r"$"
    return pattern

def load(filename):
    pattern=build_ior_pattern()
    data={"op":[], "bandwidth" : [] }
    node=0
    tasks=0
    stripes=-1
    with open(filename) as f:
        
        for line in f.readlines():
            m=re.match(pattern,line.strip())
            if m is not None:
                data["op"].append(m[1])
                data["bandwidth"].append(float(m[2])/1e+3)
            else:
                m=re.match(r"nodes\s+:\s+(\d+)",line)
                if m is not None:
                    node=int(m[1])
                else:
                    m=re.match(r"tasks\s+:\s+(\d+)",line)
                    if m is not None:
                        tasks=int(m[1])
                    else:
                        m=re.match(r"stripes\s*:\s*(\d+)",line)
                        if m is not None:
                            stripes=int(m[1])
                        else:
                            m=re.match(r"segments\s*:\s*(\d+)",line)
                            if m is not None:
                                segments=int(m[1])
                            
                    
                
    data["nodes"]=node
    data["tasks"]=tasks
    data["stripes"]=stripes
    data["segments"]=segments
    
    return pd.DataFrame(data)



def load_reports(directoryname):
    
    return pd.concat([pd.DataFrame(load(filename)) for filename in find_reports(directoryname)])


def aggregate_OST(data):
    return data.groupby(["nodes","tasks","op","stripes","segments"]).aggregate(func=[np.average,np.std]).reset_index(drop=False)
                    


def scatter_plot_ost(data):
    x="tasks"
    y="bandwidth"
    fig,ax=plt.subplots()
    for value,_data in data.groupby("nodes"):
        ax.plot(_data[x],_data[y],"o",label=f"nodes={value}")
    plt.legend()
    #yticks=np.linspace(np.min(data[y]),np.max(data[y]),num=10 )
    #ax.set_yticks(yticks)


def scatter_plot_ost_aggregated(data_aggregated,by="nodes",x="tasks"):
    for value,_data in data_aggregated.sort_values(x).groupby(by):
        plt.errorbar( _data.loc[:,x] , _data.loc[:,('bandwidth', 'average')],_data.loc[:,('bandwidth', 'std')],label=f"{by}={value}",fmt="o--")
    plt.legend()