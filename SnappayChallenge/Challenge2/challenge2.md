Effort estimation:  
	People: 1  
	Time: 1.5 hours  

1. The code to create all necessary infrasture for the website (servers, load balances, etc.)  
	
	Since this sever only need to run static webpage, we can set up manually. 

	The infrasture for the website:  
		- Cloud server: AWS Linux 2 64-bit x86 t2.small  
		- Web server: Apache  
		- Purchase domain name and point to IP address  
		- Use Cerbot to install SSL Certificate  
		- Load balance: Create a Classic Load Balancer through the AWS  
		- Set up /etc/httpd/conf.d/ssl.conf  
			Below is an mock code for integrating the website being accessed via HTTP:  
```
				Alias /AppName /Path to the website directory
				<Directory /Path to the company website directory >
			        Options Indexes FollowSymLinks MultiViews
			        AllowOverride All
			        Require all granted
				</Directory>
				RewriteEngine   On
				RewriteRule     ^/?$    /AppName               [PT]
```
	
	We also can use Ansible to build the infrasture for the website. Under directory website-ansible is the design and I have implemented the basic struture of the ansible script to build the infrusture. Below is a description for the each directory:  

	website-ansible  
			|-tasks: set up directories, user, Certbot, set up ssl.conf  
			|-setup: prepare to run the Ansbile
			|-local_inventory: put server list into inventory, the Ansible can run tasks on multiple servers in once.
			|-certbot_inventory: put server list into inventory, the Asible can set up SSL certificate on multiple servers

2. The pipeline to deploy files from the git repo to the website  
	
	Use Jenkins to build up a pipeline to deploy files from git repo to server.  
	Showing design below by using Groovy script  
	
```
	pipeline {
		agent any
		stages {
			stage('clone repo') {
				steps {
					sh "git clone https://github.com/companywebsite/app.git"
					sh "script to clean old files"
				}
			}
			stage('Deploy') {
				steps {
					sh "script to make sure files are set up properly"
				}	
			}
		}
	}
```


3. Be able to rollback to any version deployed in last 3 month  
	
	One way is to create tags in Github when doing each release. So we can switch to any tag in Github, run the pipeline to rollback to any version deployed before.  
	
	Workflow could be:  
		- Before merge the release branch to master , verify existence of tag with previous stable release or create a new one.   
		- Merge the release (qa, test, or whatever) to master branch  
		- Execute your current pipeline with master branch.  
		- If some error is detected, perform a rollback using your Git.   
		- Execute again the same pipeline with master branch as parameter. If rollback was not possible, Execute this pipeline with last stable tag as parameter.  

	
4. Be able to support HTTPS

	Configure the instance to accept connections on the following TCP ports:  
		&nbsp;&nbsp;    SSH (port 22)  
		&nbsp;&nbsp;    HTTP (port 80)  
		&nbsp;&nbsp;    HTTPS (port 443)  
	Install mod_ssl  
	Restart httpd  

