# MeCab + Python3 + Lambda
## Usage
1. Build MeCab in docker image of Lambda (lambci/lambda:build-python3.8).
    ```
    $ docker-compose up
    ```
2. Compress files for deploy.
    ```
    $ cd function && zip -r ../deploy_package.zip * .* 
    ```
3. Upload "deploy_package.zip" to your Lambda function.