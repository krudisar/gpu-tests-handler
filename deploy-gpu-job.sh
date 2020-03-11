JOB_NAME="tf-test-job"
kubectl apply -f deploy-gpu-job.yml
sleep 2

pods=$(kubectl get pods --selector=job-name=$JOB_NAME --output=jsonpath='{.items[*].metadata.name}')
echo "Job/Pod name: " $pods

echo "Waiting for the job to completed (timeout = 15 mins) ... "
kubectl wait --for=condition=Complete --timeout=900s job/$JOB_NAME

#read -p "The job is running on a GPU enabled K8S node. Press enter to continue ..."

timestamp=`date +"%Y-%m-%d--%H-%M-%S"`

kubectl logs $pods >> /tmp/$JOB_NAME-$timestamp-results.txt

echo "Check the output file: " /tmp/$JOB_NAME-$timestamp-results.txt
echo
echo
echo

#read -p "Outputs saved. Now you can delete the job. Press enter to continue ..."
kubectl delete job tf-test-job
echo

