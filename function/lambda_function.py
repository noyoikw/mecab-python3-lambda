# coding: utf-8
import json
import os
import ctypes

mecabdir = os.path.join(os.getcwd(), '/var/task/.mecab')
libmecab = ctypes.cdll.LoadLibrary(os.path.join(mecabdir, 'lib/libmecab.so'))

import MeCab

output_format_type = 'chasen'
dicdir = os.path.join(mecabdir, 'lib/mecab/dic/ipadic')
rcfile = os.path.join(mecabdir, 'etc/mecabrc')

tagger = MeCab.Tagger('-O{} -d{} -r{}'.format(output_format_type, dicdir, rcfile))

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
