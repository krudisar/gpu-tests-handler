JOB_NAME="tf-test-job"
TIME_STAMP=`date +"%Y-%m-%d--%H-%M-%S"`
OUTPUT_PATH="/var/www/html"

# create a K8S job to be scheduled on GPUs
echo "Creating a job: " $JOB_NAME
kubectl apply -f deploy-gpu-job.yml

# print corresponding K8S pods
pods=$(kubectl get pods --selector=job-name=$JOB_NAME --output=jsonpath='{.items[*].metadata.name}')
echo "Job/Pod name: " $pods

# wait till this K8S job is finished = all calculation are completed
echo "Waiting for the job to completed (timeout = 15 mins) ... "
kubectl wait --for=condition=Complete --timeout=900s job/$JOB_NAME

# save test & calculation results to web server directory
echo "Saving results to " $OUTPUT_PATH/$JOB_NAME-$TIME_STAMP-results.txt
kubectl logs $pods >> $OUTPUT_PATH/$JOB_NAME-$TIME_STAMP-results.txt

echo ""

# finally delete this K8S job
echo "Done! ... Deleting K8S job: " $JOB_NAME
kubectl delete job tf-test-job

echo ""

