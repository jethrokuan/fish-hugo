function hugo_deploy -d "Deploy updates to Github"
  if not spin --error=debug.txt --format "@ Deploying updates to Github\r" "__hugo_deploy"
    printf "✘ Deploy Unsuccessful"
  else
    printf "✔ Deploy Successful"
  end
end
