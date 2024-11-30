# Ubuntu-24.04 리눅스 4개 노드 설정
---
### 설정 내용
* user1/asdf 로 사용자 생성
* user1을 sudoer로 등록
* git, docker 설치
* hostname : server1 ~ server4
* ip 주소 : 192.168.56.201~204
* 모든 vm에 hosts 파일 등록 : server1~4
 
### 설정이 끝나고 난 후 해야할 일
* server2~server4 에서 user1로 로그인 후
```ssh
ssh-copy-id server1
```
* server1에서 
```ssh
scp ~/.ssh/authorized_keys server2:~/.ssh/authorized_keys 
scp ~/.ssh/authorized_keys server3:~/.ssh/authorized_keys 
scp ~/.ssh/authorized_keys server4:~/.ssh/authorized_keys 	
```