FROM lambci/lambda:build-python3.7

ENV AWS_DEFAULT_REGION=ap-northeast-1 \
    LAMBDA_ROOT_DIR=/var/task \
    MECAB_SOURCE_URL=https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE \
    IPADIC_SOURCE_URL=https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM \
    MECAB_VERSION=0.996 \
    IPADIC_VERSION=2.7.0-20070801 \
    LIB_MECAB_DIR=.mecab

ENTRYPOINT cd ~ && \
    curl -L ${MECAB_SOURCE_URL} -o mecab.tar.gz && \
    curl -L ${IPADIC_SOURCE_URL} -o mecab-ipadic.tar.gz && \
    tar -zxvf mecab.tar.gz && tar -zxvf mecab-ipadic.tar.gz && \
    cd ~/mecab-${MECAB_VERSION} &&  \
    ./configure --prefix=${LAMBDA_ROOT_DIR}/${LIB_MECAB_DIR} --with-charset=utf8 && \
    make && make install && \
    cd ~/mecab-ipadic-${IPADIC_VERSION} &&  \
    ./configure --prefix=${LAMBDA_ROOT_DIR}/${LIB_MECAB_DIR} --with-charset=utf8 --with-mecab-config=${LAMBDA_ROOT_DIR}/${LIB_MECAB_DIR}/bin/mecab-config && \
    make && make install && \
    cd ~ && pip3 install mecab-python3 -t ${LAMBDA_ROOT_DIR}
