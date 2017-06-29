MRuby::Build.new do |conf|
  # load specific toolchain settings

  # Gets set by the VS command prompts.
  if ENV['MRUBY_TOOLCHAIN']
    toolchain ENV['MRUBY_TOOLCHAIN']
  elsif ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  # enable_debug

  # use mrbgems
  Dir.glob("../mruby-*/mrbgem.rake") do |x|
    g = File.basename File.dirname x
    if g == 'mruby-onig-regexp'
      conf.gem "../deps/#{g}" do |c|
        c.bundle_onigmo
      end
    else
      conf.gem "../deps/#{g}"
    end
  end

#  conf.gem :github => 'matsumoto-r/mruby-vedis'
#  conf.gem :git => 'https://github.com/matsumoto-r/mruby-redis.git'
  conf.gem :github => 'mattn/mruby-json'
#  conf.gem :github => 'take-cheeze/mruby-leveldb'
  conf.gem :github => 'mattn/mruby-sqlite3'
  conf.gem :github => 'matsumoto-r/mruby-http2'
  conf.gem :github => 'udzura/mruby-etcd'
#  conf.gem :github => 'mattn/mruby-sqlite3'
#  conf.gem :github => 'iij/mruby-aws-s3'
#  conf.gem :github => 'mattn/mruby-uv'
#  conf.gem :github => 'mattn/mruby-http'
#  conf.gem :github => 'matsumoto-r/mruby-httprequest'
#  conf.gem :github => 'iij/mruby-digest'
#  conf.gem :github => 'iij/mruby-pack'
   conf.gem :github => 'Asmod4n/mruby-simplemsgpack'
#  conf.gem :github => 'matsumoto-r/mruby-simplehttp'
#  conf.gem :github => 'iij/mruby-socket'
#  conf.gem :git => 'https://github.com/luisbebop/mruby-polarssl.git'
  # include all the core GEMs
  conf.gembox 'full-core'
end
