# Ubuntu-24.04 리눅스 3개 노드 설정
---
## 설정 내용
* user1/asdf 로 사용자 생성
* user1을 sudoer로 등록
* git, docker 설치
* hostname : server1 ~ server4
* ip 주소 : 192.168.56.201~204
* 모든 vm에 hosts 파일 등록 : server1~4
 
## Jenkins 서버를 설치하려면
#### DK 설치
```ssh
sudo apt update
sudo apt install openjdk-17-jdk-headless
```
