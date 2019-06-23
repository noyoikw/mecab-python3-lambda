# coding: utf-8
import json
import os
import ctypes
libdir = os.path.join(os.getcwd(), '/var/task/.mecab/lib')
libmecab = ctypes.cdll.LoadLibrary(os.path.join(libdir, 'libmecab.so'))

import MeCab
tagger = MeCab.Tagger ('-Ochasen')

def lambda_handler(event, context):
    req_body = json.loads(event['body'])    
    res_body = {
      'morphemes': tagger.parse(req_body['text'])
    }
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps(res_body)
    }


