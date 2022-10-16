# Дипломный практикум в YandexCloud

 * [Цели:](#цели)
  * [Этапы выполнения:](#этапы-выполнения)
      * [Регистрация доменного имени](https://github.com/TedFak/diplom#%D1%80%D0%B5%D0%B3%D0%B8%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D1%8F-%D0%B4%D0%BE%D0%BC%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D0%B8%D0%BC%D0%B5%D0%BD%D0%B8)
      * [Создание инфраструктуры](https://github.com/TedFak/diplom#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8%D0%BD%D1%84%D1%80%D0%B0%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D1%8B)
          * [Установка Nginx и LetsEncrypt](https://github.com/TedFak/diplom#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-nginx-%D0%B8-letsencrypt)
          * [Установка кластера MySQL](https://github.com/TedFak/diplom#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B0-mysql)
          * [Установка WordPress](https://github.com/TedFak/diplom#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-wordpress)
          * [Установка Gitlab CE, Gitlab Runner и настройка CI/CD](https://github.com/TedFak/diplom#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-gitlab-ce-%D0%B8-gitlab-runner)
          * [Установка Prometheus, Alert Manager, Node Exporter и Grafana](https://github.com/TedFak/diplom#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-prometheus-alert-manager-node-exporter-%D0%B8-grafana)
          
### Регистрация доменного имени
Куплен домен у регистратора domains.google.com , в нем прописаны все А записи, так же в Cloud DNS в Yandex изменены записи NS на Google днс сервера.

![image](https://user-images.githubusercontent.com/95320903/194674667-42e9db1d-e683-422e-9dcc-0d7a8e7f1c9b.png)

___
### Создание инфраструктуры
[Репо Terraform с манифестами](https://github.com/TedFak/diplom/tree/main/terraform)
#### Конфиги Терраформ:
- настройка провайдера и S3 bucket [provider.tf](https://github.com/TedFak/diplom/tree/main/terraform/provider.tf)
- Сеть, подсеть и записи в Cloud DNS [network.tf](https://github.com/TedFak/diplom/tree/main/terraform/network.tf)
- Инвентори файл [inventory.tf](https://github.com/TedFak/diplom/tree/main/terraform/inventory.tf)
- Ansible playbook [ansible.tf](https://github.com/TedFak/diplom/tree/main/terraform/ansible.tf)
- Сервера:
  - Nginx+LE [proxy.tf](https://github.com/TedFak/diplom/tree/main/terraform/proxy.tf)
  - База данных [db.tf](https://github.com/TedFak/diplom/tree/main/terraform/db.tf)
  - Wordpress [app.tf](https://github.com/TedFak/diplom/tree/main/terraform/app.tf)
  - Gitlab [gitlab.tf](https://github.com/TedFak/diplom/tree/main/terraform/gitlab.tf)
  - Gitlab-Runner [runner.tf](https://github.com/TedFak/diplom/tree/main/terraform/runner.tf)
  - Сервер мониторинга [monitoring.tf](https://github.com/TedFak/diplom/tree/main/terraform/monitoring.tf)

![image](https://user-images.githubusercontent.com/95320903/194674645-5802cc14-473d-485a-a3e1-ba5a0c6666ea.png)

Поднятие всей инфраструктуры выполняется одной командой `terraform apply`

#### Так же использовал packer с конфигурацией Centos и Ubuntu 

[packer](https://github.com/TedFak/diplom/tree/main/packer)

___
### Установка Nginx и LetsEncrypt

Использовал материал: 
- https://gist.github.com/mattiaslundberg/ba214a35060d3c8603e9b1ec8627d349

Role: 
- [nginxle](https://github.com/TedFak/diplom/tree/main/ansible/roles/nginxle)

___
### Установка кластера MySQL

Использовал роль:
- https://github.com/geerlingguy/ansible-role-mysql

 Role:
 - [mysql](https://github.com/TedFak/diplom/tree/main/ansible/roles/mysql)

На сервер добавлена бд для `wordpress`, так же пользователь `wordpress`.
Статус мастера
```
mysql> SHOW MASTER STATUS;
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000002 |  1513855 | wordpress    |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
1 row in set (0.00 sec)

mysql> 
```
___
### Установка WordPress
Использовал роль: 
- https://github.com/bertvv/ansible-role-wordpress

Role: 
- [wordpress](https://github.com/TedFak/diplom/tree/main/ansible/roles/wordpress)


На сервере крутится wordpress + apache

![image](https://user-images.githubusercontent.com/95320903/195425571-925d0f49-8380-412d-abab-63ca33ac7481.png)

___
### Установка Gitlab CE и Gitlab Runner

Использовал материал:
- Gitlab-CE https://github.com/geerlingguy/ansible-role-gitlab
- Runner https://github.com/riemers/ansible-gitlab-runner

Role:
- [gitlab](https://github.com/TedFak/diplom/tree/main/ansible/roles/gitlab)
- [runner](https://github.com/TedFak/diplom/tree/main/ansible/roles/runner)

Gitlab repo использовал [скрипт](https://github.com/TedFak/diplom/tree/main/ansible/roles/wordpress/templates/push.sh.j2) для быстрого пуша с сервера `wordpress`
```bash
[root@app wordpress]# ./push.sh 
Initialized empty Git repository in /var/www/wordpress/.git/
[master (root-commit) e79a8ec] Create repo Wordpress
 Committer: root <root@app.svgsmsc.com>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1753 files changed, 875775 insertions(+)
 ...
Username for 'http://gitlab.svgsmsc.com': root  
Password for 'http://root@gitlab.svgsmsc.com': 
Counting objects: 1916, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (1885/1885), done.
Writing objects: 100% (1916/1916), 11.86 MiB | 6.93 MiB/s, done.
Total 1916 (delta 177), reused 0 (delta 0)
remote: Resolving deltas: 100% (177/177), done.
remote: 
remote: 
remote: The private project root/wordpress was successfully created.
remote: 
remote: To configure the remote, run:
remote:   git remote add origin http://gitlab.svgsmsc.com/root/wordpress.git
remote: 
remote: To view the project, visit:
remote:   http://gitlab.svgsmsc.com/root/wordpress
remote: 
remote: 
remote: 
To http://gitlab.svgsmsc.com/root/wordpress.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
```
![image](https://user-images.githubusercontent.com/95320903/194785525-7a4d3305-661a-4919-bb16-6cce6feb3f34.png)


Для подключение runner'a вписываю token взятый с сервера gitlab в `ansible/roles/gitlab-runner/defaults/main.yml`:
```
...
# GitLab registration token
gitlab_runner_registration_token: 'CF1kJQRV287R8cnDfPYT'
...
```
![image](https://user-images.githubusercontent.com/95320903/194674476-085bfc56-6abf-4e7e-8314-23592de8760a.png)

##### CI/CD
Для работы pipeline в Setings-CI/CD-Variables прописан ssh ключ с кодировкой base64 инфа взята [тут](https://gitlab.com/gitlab-examples/ssh-private-key/-/issues/1#note_15038961)


[.gitlab-ci.yml](https://github.com/TedFak/diplom/.gitlab-ci.yml)
```
before_script:
  - eval $(ssh-agent -s)
  - ssh-add <(echo "$SSH_PRIVATE_KEY" | base64 -d)
  - mkdir -p ~/.ssh
  - chmod 700 ~/.ssh

stages:
  - deploy

deploy-job:
  stage: deploy
  script:
    - ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null centos@app.svgsmsc.com "cd /var/www/wordpress/ && sudo chown -R centos /var/www/wordpress/ && exit"
    - rsync -arvzc -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" ./* centos@app.svgsmsc.com:/var/www/wordpress/
```
![image](https://user-images.githubusercontent.com/95320903/195724753-49a35a32-acba-463c-9b5a-6008496cd22d.png)
![image](https://user-images.githubusercontent.com/95320903/195724712-ebd09efd-e258-4d16-b7bc-a8bc5d5ae7eb.png)

___
### Установка Prometheus, Alert Manager, Node Exporter и Grafana

Использовал материал:
- Monitoring https://github.com/MiteshSharma/PrometheusWithGrafana
- Node exporter https://github.com/prometheus/node_exporter

Role:
- [monitoring](https://github.com/TedFak/diplom/tree/main/ansible/roles/monitoring)
- [node_exporter](https://github.com/TedFak/diplom/tree/main/ansible/roles/node_exporter)

##### prometheus
![image](https://user-images.githubusercontent.com/95320903/194674494-96d696c0-a916-425c-b3cd-383ec9e36ff2.png)


##### grafana
![image](https://user-images.githubusercontent.com/95320903/194674530-8cc21767-4147-43c8-b6b2-9512ab76c2bb.png)


##### alertmanager
![image](https://user-images.githubusercontent.com/95320903/194674559-0f037913-9242-4a3b-ba13-f790953a9486.png)


Node Exporter устанавливается на все сервера.

Config file для Prometheus [config](https://github.com/TedFak/diplom/blob/main/ansible/roles/monitoring/templates/prometheus.yml.j2)
```yml
global:
  scrape_interval: 15s

rule_files:
  - alert.rules.yml

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets:
        - 192.168.101.11:9100
        - 192.168.101.12:9100
        - 192.168.101.17:9100
        - 192.168.101.13:9100
        - 192.168.101.14:9100
        - 192.168.101.15:9100
        - 192.168.101.16:9100
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - 'localhost:9093'
```
___



![image](https://user-images.githubusercontent.com/95320903/196021556-b4fe3915-c741-4287-8b61-9e744be41284.png)

![image](https://user-images.githubusercontent.com/95320903/196021560-9d2d10bc-9d3e-4fb9-b30a-e4c64dbdf5b5.png)

![image](https://user-images.githubusercontent.com/95320903/196021574-16d30898-93bc-46d4-bf13-f0080456fd23.png)

![image](https://user-images.githubusercontent.com/95320903/196021565-84c9e189-e83d-46a8-b068-95f0a7e0b49c.png)

![image](https://user-images.githubusercontent.com/95320903/196021588-aa40263c-be4b-471a-8aba-35837dbd99fc.png)

