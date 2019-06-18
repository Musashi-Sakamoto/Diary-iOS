# MyDiary iOS app
simple private memo app you can upload texts and images and videos.

[MyDiary](https://frontend.1292602b.now.sh)

[MyDiary Web Application Repository](https://github.com/Musashi-Sakamoto/node-file-uploader)

## prerequisite
 - MyDiary Web Application Backend (docker or heroku)
 
## usage
In the root directory of the project, just run
```
pod install && open MyDiaryiOS.xcworkspace/
```
then `Command + R` .

For the setup of the api, in the root directory of the web application project you need run the command below,
```
docker-compose build && docker-compose up
```
then,
```
docker-compose exec backend npm run migrate
```
    
## author
Musashi Sakamoto
