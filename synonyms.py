#################################################################################
# usage of the script
# usage: python search-terms.py -k APIKEY -v VERSION -s STRING
# see https://documentation.uts.nlm.nih.gov/rest/search/index.html for full docs
# on the /search endpoint
#################################################################################

from __future__ import print_function
from Authentication import *
import requests
import json
import argparse
from nltk.corpus import wordnet
import re


def from_wordnet(string=''):

    split = string.split(" ")
    string = "_".join(split)
    # print ("string",string)
    syns = wordnet.synsets(string)
    l = []
    for i in syns:
        for j in i.lemmas():
            word = j.name().lower()
            word = re.sub("_"," ",word)
            l.append(word)
    return l
def from_ULMS(string=""):
    syn = []
    parser = argparse.ArgumentParser(description='process user given parameters')
    # parser.add_argument("-u","--upgrade", help="fully automatized upgrade", action="store_true")

    #parser.add_argument("-u", "--username", required =  True, dest="username", help = "enter username")
    #parser.add_argument("-p", "--password", required =  True, dest="password", help = "enter passowrd")
    # parser.add_argument("-k", "--apikey", required = True, dest = "apikey", help = "enter api key from your UTS Profile")
    # parser.add_argument("-v", "--version", required =  False, dest="version", default = "current", help = "enter version example-2015AA")
    # parser.add_argument("-s", "--string", required =  True, dest="string", help = "enter a search term, like 'diabetic foot'")

    # args = parser.parse_args()
    username = "shivamagl"
    password = "Abcd12345$"
    apikey = "adbcff59-2092-4d03-ab9c-1ab14eab4c00"
    version = "2015AA"
    # string = args.string
    uri = "https://uts-ws.nlm.nih.gov"
    content_endpoint = "/rest/search/"+version
    ##get at ticket granting ticket for the session
    AuthClient = Authentication(apikey)
    tgt = AuthClient.gettgt()
    pageNumber=0

    while pageNumber<2:
        ##generate a new service ticket for each page if needed
        ticket = AuthClient.getst(tgt)
        pageNumber += 1
        query = {'string':string,'ticket':ticket, 'pageNumber':1}
        #query['includeObsolete'] = 'true'
        #query['includeSuppressible'] = 'true'
        #query['returnIdType'] = "sourceConcept"
        #query['sabs'] = "SNOMEDCT_US"
        r = requests.get(uri+content_endpoint,params=query)
        r.encoding = 'utf-8'
        items  = json.loads(r.text)
        jsonData = items["result"]
        #print (json.dumps(items, indent = 4))

        # print("Results for page " + str(1)+"\n")
        
        for result in jsonData["results"]:
            
        # try:
        #     print("ui: " + result["ui"])
        # except:
        #     NameError
        # try:
        #     print("uri: " + result["uri"])
        # except:
        #     NameError
        # try:
        #     print("name: " + result["name"])
        # except:
        #     NameError
        # try:
        #     print("Source Vocabulary: " + result["rootSource"])
        # except:
        #     NameError
        
        # print("\n")
            syn.append(result["name"].lower())
            # print (result["name"])
        ##Either our search returned nothing, or we're at the end
        # if jsonData["results"][0]["ui"] == "NONE":
        #     break
        # print("*********")
        # print (syn)
    return syn

def get_synonyms(string='',sources=['all']):
    syn = []
    sources_list = ["wordnet","UMLS"]
    if sources[0] == "all":
        sources = sources_list
        # print (sources)
    else:
        pass
    if "wordnet" in sources:
        syn += from_wordnet(string)
            # print (syn)
    if "UMLS" in sources:
        syn += from_ULMS(string)
        # print (syn)
    return syn
    
# print (get_synonyms("leukemia"))