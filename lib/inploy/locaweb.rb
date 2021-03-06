module Inploy
  module Locaweb
    def remote_setup
      run "rm -Rf #{tmp_path} && git clone . #{tmp_path} && tar czf - #{tmp_path} | ssh #{user}@#{host} 'tar xzfv - -C ~/ && mv ~#{tmp_path} #{path}/ && cd #{application_path} && rake inploy:local:setup'"
    end

    def remote_update
      run "git push ssh://[#{user}@#{host}]#{application_path} master"
      super
    end

    def local_setup
      super
      run "ln -s #{application_path}/public /home/#{user}/public_html/#{application}"
    end

    def local_update
      after_update_code
    end

    def path
      @path ||= "/home/#{user}/rails_app"
    end

    private

    def tmp_path
      "/tmp/#{application}"
    end
  end
end
