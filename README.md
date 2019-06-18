# MyDiary iOS app
simple private memo app you can upload texts and images and videos.

[MyDiary](https://frontend.1292602b.now.sh)
[Repository](https://github.com/Musashi-Sakamoto/node-file-uploader)

## prerequisite
 - docker
 - send grid api key
 - heroku cli(production)
 - aws s3 bucket(production)
 - mysql db(production)
 - redis(production)
 
## usage
In the root directory of the web application project you need run the command below,
```
docker-compose build && docker-compose up
```
then,
```
docker-compose exec backend npm run migrate
```
    
## author
Musashi Sakamoto
