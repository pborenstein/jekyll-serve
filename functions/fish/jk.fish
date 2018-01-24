function jk --description="Run jekyll site in current dir in  container"
  set -l port 80
  
  if test (count $argv) = 1
    set port $argv[1]
  end

  docker run -p $port:4000 -v (pwd):/site pborenstein/jekyll-server
end
