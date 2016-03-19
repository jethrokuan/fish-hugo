function __hugo_deploy -d " Deploy script"
  set -l date (date)
  set -l HUGO_SOURCE_MSG "rebuilding site source ($date)"
  set -l HUGO_PUBLIC_MSG "rebuilding public site ($date)"
  
  hugo > /dev/null; and pushd public

  if test ! -s CNAME
    get -p "Enter the url for your site (eg. blog.example.com): " | read cname
    echo "Adding CNAME to public folder..."
    echo $cname > CNAME
  end

  if git_is_dirty
    git add -A; and git commit -m "$HUGO_SOURCE_MSG"; and git push origin master
    if test 1 -eq $status
      echo "Failed to push public content" > /dev/stderr
      return 1
    end
  end
  
  popd

  if git_is_dirty
    git add -A; and git commit -m "$HUGO_PUBLIC_MSG"; and git push origin source
    if test 1 -eq $status
      echo "Failed to push source content" > /dev/stderr
      return 1
    end
  end

  return 0
end  
