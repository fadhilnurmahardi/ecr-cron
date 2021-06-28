set -e
REGION=$AWS_DEFAULT_REGION
SECRET_NAME=${REGION}-ecr-registry
EMAIL=$EMAIL_ECR
TOKEN=`aws ecr get-login --region ${REGION} --registry-ids ${ACCOUNT} | cut -d' ' -f6`
echo "ENV variables setup done."
kubectl -n ${KUBE_NAMEPSACE} delete secret --ignore-not-found $SECRET_NAME
kubectl -n ${KUBE_NAMEPSACE} create secret docker-registry $SECRET_NAME \
--docker-server=https://${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com \
--docker-username=AWS \
--docker-password="${TOKEN}" \
--docker-email="${EMAIL}"
echo "Secret created by name. $SECRET_NAME"