function __hugo_deploy -d " Deploy script"
  set -l date (date)
  set -l HUGO_SOURCE_MSG "rebuilding site source ($date)"
  set -l HUGO_PUBLIC_MSG "rebuilding public site ($date)"

  if not type -q hugo
    printf "`hugo` command not found. Please check your $PATH."
    return 1
  end
  
  hugo > /dev/null; and pushd public

  if test ! -s CNAME
    get -p "Enter the url for your site (eg. blog.example.com): " | read cname
      echo "Adding CNAME to public folder..."
      echo $cname > CNAME
    end

    if git_is_dirty
      git add -A; and git commit -m "$HUGO_SOURCE_MSG" > /dev/null; and git push origin master --quiet
    end
  
    popd

    if git_is_dirty
      git add -A; and git commit -m "$HUGO_PUBLIC_MSG" > /dev/null; and git push origin source --quiet
    end

    return 0
  end  
