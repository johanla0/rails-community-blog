# frozen_string_literal: true

module AuthenticationHelper
  def current_user(session)
    User.find_by(id: session.session[:current_user_id])
  end

  def sign_out(session = self)
    session.delete session.destroy_user_session_url
  end

  def sign_in(resource)
    open_session do |s|
      raise "Unknown resource to sign_in #{resource}" unless resource.instance_of?(User)

      s.post s.user_session_url, params: {
        user: {
          email: resource.email,
          password: 'password'
        }
      }
    end
  end
end
