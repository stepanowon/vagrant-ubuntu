


# Ubuntu-24.04 리눅스 3개 노드 설정
---
## 설정 내용
* user1/asdf 로 사용자 생성
* user1을 sudoer로 등록
* git, docker 설치
* hostname : server1 ~ server4
* ip 주소 : 192.168.56.201~204
* 모든 vm에 hosts 파일 등록 : server1~4

## 설치방법
* Oracle VirtualBox 설치(https://www.virtualbox.org/)
* Vagrant 설치(https://developer.hashicorp.com/vagrant/install?product_intent=vagrant)
* git clone https://github.com/stepanowon/vagrant-ubuntu
* cd vagrant-ubuntu
* vagrant up

---
## Jenkins 서버를 설치하려면...
---
#### JDK 설치
```ssh
sudo apt update
sudo apt install openjdk-17-jdk-headless
```

#### Jenkins 설치
```ssh
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install jenkins -y
```

#### docker 설치(혹시 설치하지 않았다면)
```ssh
sudo apt update
sudo apt-get install apt-transport-https ca-certificates curl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

sudo apt update

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo usermod -a -G docker jenkins  

sudo systemctl enable docker
sudo systemctl start docker
sudo chmod 666 /var/run/docker.sock   
```

#### Jenkins 초기 패스워드 획득
```ssh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
---

## Jenkins 분산 에이전트 추가
---
#### SSH 키 생성(server1 에서)
```ssh
# ssh-keygen -t rsa 명령어로 키페어 생성
# 생성된 키페어 중 Public Key를 server, server3으로 복사
   ssh-copy-id server2
   ssh-copy-id server3
# jenkins의 Jenkins관리-Credential에 ssh Private Key 등록
```

#### 노드 추가 시작
```ssh
# Jenkins 관리 - Nodes 로 이동하여 New Node 버튼 클릭
# 노드명은 적절히 예) 서버명 입력하고 Type을 Permanent Agent 지정 ---> Create
```

### 노드 설정
```ssh
# 설명은 간단히 알아보기 쉽게 : 서버명, IP 주소등 입력
# Number of executors : 2
# Remote Root Directory : /home/stepano/jenkins-agent   (사용자 홈디렉토리에 생성)
   * 디렉토리 미리 생성해두어야 함
   * 디렉토리가 명령 실행시에 접근할 수 있는 권한이 있어야 함.
   * 루트에 디렉토리를 생성했다면 sudo!!
# Labels : agent 지정시 사용할 레이블
# launch method : launch agent via SSH
# Host : 192.168.56.202(연결하려는 Agent의 주소)
# Credentials : Jenkins Credentials에 등록한 자격증명 지정
# Host Key Verification Strategy : Manually trusted key Verification Strategy
# Availability : Keep this agent online as much as posiible
```
