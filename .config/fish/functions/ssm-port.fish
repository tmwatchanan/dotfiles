function ssm-port -d "ssm-port <instance-id>"
	aws ssm start-session --target $argv[1] \
	--document-name AWS-StartPortForwardingSession \
	--parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'
end

