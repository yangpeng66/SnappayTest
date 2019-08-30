
1. How to provision the cluster in 30 miniutes

	Use Terraform to provision Elasticsearch cluster and Kibana server in 30 minutes.
	Directories elasticsearch-instance and kibana-instance are the files to provision the cluster and server.  

2. How to scale up or down the cluster

	By creating an Auto Scaling group in AWS.

3. How to prevent unauthorized access to the cluster

	By setting up AWS elasticache security group to control access to one or more clusters.

4. How to ship logs from application to the elasticsearch cluster
	
	Using Filebeat to collect log events and ship them to the cluster.

5. How to monitor the performance of the cluster
	
	Using Nagios Linux Monitoring or using Amazon CloudWatch.

6. What about if the applications are running in multiple regions, (one system in us-east-1 and one system in us-west-2)

	Set a standard region.
	Build a regions adaptor by python or shellscript to convert all other regions to the stardard region.

