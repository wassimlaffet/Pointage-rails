Raisin.configure do |api|
  api.version.using   = :header
  api.version.vendor  = 'captaindash'

  api.enable_auth_by_default = false
   api.default_auth_method  = :authenticate_user!
end

class Raisin::Base
  def _prefixes
    @_prefixes ||= begin
      parent_prefixes = self.class.parent_prefixes
      parent_prefixes.compact.unshift(controller_path).map! { |pr| pr.split('/').last } # Bouuuuuh
    end
  end
end