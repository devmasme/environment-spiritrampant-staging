#!/bin/sh

DIR= ../

# 최신을 받는다
git -C $DIR pull # hook은 별도의 행동이구나 이걸 해줘야하는구나

# 최신파일로 이미지를 빌드한다, todo 버전관리, 이전이미지는 관리하며 롤백을 구현해야한다.
docker build gcr.io/pro-kayak-218810/hello-node:v2 $DIR

# 최신 도커이미지를 GCR에 올린다
docker push gcr.io/pro-kayak-218810/hello-node:v2

# pod에 새로운 이미지를 적용하여 배포한다
kubectl run spiritrampant --image=gcr.io/pro-kayak-218810/hello-node:v2 --port=8080

# pod를 expose 시켜준다
kubectl expose deployment hello-node --type="LoadBalancer"

